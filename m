Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5376C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 17:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbiB1Rh2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 12:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbiB1Reh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:34:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D1C7D029;
        Mon, 28 Feb 2022 09:31:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F2D661419;
        Mon, 28 Feb 2022 17:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53387C340E7;
        Mon, 28 Feb 2022 17:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646069456;
        bh=Rd8jvTNrPWtN6dd5Od5wtu8Di/L6XL1V6MGeJMtvvLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXE+/VOB+5Ire5M1YjlbO35I1GjRaTZfgwGXlHom8xBnYWtt/H09mj1Wbukn3n5Ve
         vOuAXdETsG/jPxN/B8VTMuVXs++KaQZKctLUGuju5nAOJxrMZTCFXRsWIh9PmXZ8dn
         AzJhhZIDlo0xVMvk2nTKsg4V6SWmBTzvqpvfwpHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com
Subject: [PATCH 5.4 03/53] vhost/vsock: dont check owner in vhost_vsock_stop() while releasing
Date:   Mon, 28 Feb 2022 18:24:01 +0100
Message-Id: <20220228172248.525743374@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228172248.232273337@linuxfoundation.org>
References: <20220228172248.232273337@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>

commit a58da53ffd70294ebea8ecd0eb45fd0d74add9f9 upstream.

vhost_vsock_stop() calls vhost_dev_check_owner() to check the device
ownership. It expects current->mm to be valid.

vhost_vsock_stop() is also called by vhost_vsock_dev_release() when
the user has not done close(), so when we are in do_exit(). In this
case current->mm is invalid and we're releasing the device, so we
should clean it anyway.

Let's check the owner only when vhost_vsock_stop() is called
by an ioctl.

When invoked from release we can not fail so we don't check return
code of vhost_vsock_stop(). We need to stop vsock even if it's not
the owner.

Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
Cc: stable@vger.kernel.org
Reported-by: syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com
Reported-and-tested-by: syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vsock.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -570,16 +570,18 @@ err:
 	return ret;
 }
 
-static int vhost_vsock_stop(struct vhost_vsock *vsock)
+static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
 {
 	size_t i;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&vsock->dev.mutex);
 
-	ret = vhost_dev_check_owner(&vsock->dev);
-	if (ret)
-		goto err;
+	if (check_owner) {
+		ret = vhost_dev_check_owner(&vsock->dev);
+		if (ret)
+			goto err;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		struct vhost_virtqueue *vq = &vsock->vqs[i];
@@ -694,7 +696,12 @@ static int vhost_vsock_dev_release(struc
 	 * inefficient.  Room for improvement here. */
 	vsock_for_each_connected_socket(vhost_vsock_reset_orphans);
 
-	vhost_vsock_stop(vsock);
+	/* Don't check the owner, because we are in the release path, so we
+	 * need to stop the vsock device in any case.
+	 * vhost_vsock_stop() can not fail in this case, so we don't need to
+	 * check the return code.
+	 */
+	vhost_vsock_stop(vsock, false);
 	vhost_vsock_flush(vsock);
 	vhost_dev_stop(&vsock->dev);
 
@@ -792,7 +799,7 @@ static long vhost_vsock_dev_ioctl(struct
 		if (start)
 			return vhost_vsock_start(vsock);
 		else
-			return vhost_vsock_stop(vsock);
+			return vhost_vsock_stop(vsock, true);
 	case VHOST_GET_FEATURES:
 		features = VHOST_VSOCK_FEATURES;
 		if (copy_to_user(argp, &features, sizeof(features)))


