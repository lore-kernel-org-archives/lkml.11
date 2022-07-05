Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ED6CCA481
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 12:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiGEMMf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 08:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbiGEMHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:07:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021D01929C;
        Tue,  5 Jul 2022 05:06:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 54883CE1B88;
        Tue,  5 Jul 2022 12:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7D3C341C7;
        Tue,  5 Jul 2022 12:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657022797;
        bh=i1Pt/HVI+FTFQcfbMjDjOMMSXHFTulBRm3Xksv22LK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p3mOWsuYY0+4wW3zH8Z/3ohTKnRNUTYByWgOTM3z5oRuc3llz3wL93A2X5thwfL6d
         8sd9Zw9igaaWnVHV2PSX4o609z0MJdJCSokgJGuo/FceJq42y58xi93/qmh6nhGotU
         lQXH2Txkb0u3+GXsuRabBbsQkbOJl3eSnhYlC7mk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 5.10 14/84] virtio-net: fix race between ndo_open() and virtio_device_ready()
Date:   Tue,  5 Jul 2022 13:57:37 +0200
Message-Id: <20220705115615.743512513@linuxfoundation.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705115615.323395630@linuxfoundation.org>
References: <20220705115615.323395630@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>

commit 50c0ada627f56c92f5953a8bf9158b045ad026a1 upstream.

We currently call virtio_device_ready() after netdev
registration. Since ndo_open() can be called immediately
after register_netdev, this means there exists a race between
ndo_open() and virtio_device_ready(): the driver may start to use the
device before DRIVER_OK which violates the spec.

Fix this by switching to use register_netdevice() and protect the
virtio_device_ready() with rtnl_lock() to make sure ndo_open() can
only be called after virtio_device_ready().

Fixes: 4baf1e33d0842 ("virtio_net: enable VQs early")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20220617072949.30734-1-jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3171,14 +3171,20 @@ static int virtnet_probe(struct virtio_d
 		}
 	}
 
-	err = register_netdev(dev);
+	/* serialize netdev register + virtio_device_ready() with ndo_open() */
+	rtnl_lock();
+
+	err = register_netdevice(dev);
 	if (err) {
 		pr_debug("virtio_net: registering device failed\n");
+		rtnl_unlock();
 		goto free_failover;
 	}
 
 	virtio_device_ready(vdev);
 
+	rtnl_unlock();
+
 	err = virtnet_cpu_notif_add(vi);
 	if (err) {
 		pr_debug("virtio_net: registering cpu notifier failed\n");


