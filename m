Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0EAC433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 21:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiDEVU2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349606AbiDEJue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:50:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8F4ED;
        Tue,  5 Apr 2022 02:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7EA96CE1C6C;
        Tue,  5 Apr 2022 09:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9343EC385A1;
        Tue,  5 Apr 2022 09:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649152112;
        bh=Vsd42PPUK3t7g0u09QB28bdvrrlD0K9u5QGtoOtoB+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uitfP1z2FF9KSPj2aj6JOfkRiqNL1uzI6M2rLl0I14lVN030IDHCyENGTwVaJFtfE
         aJuHgqTJKtBbgUgmalyfBAS//AcWs20/8mz3uNwPhSZK7RmgHkmeiYnWChtSXi9lOx
         Sv+EZFo7C+jrY2lwN32aR3ztt+4e/j9GTbxGZizE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 657/913] vsock/virtio: enable VQs early on probe
Date:   Tue,  5 Apr 2022 09:28:39 +0200
Message-Id: <20220405070359.531891031@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070339.801210740@linuxfoundation.org>
References: <20220405070339.801210740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit 88704454ef8b00ea91537ae0d47d9348077e0e72 ]

virtio spec requires drivers to set DRIVER_OK before using VQs.
This is set automatically after probe returns, but virtio-vsock
driver uses VQs in the probe function to fill rx and event VQs
with new buffers.

Let's fix this, calling virtio_device_ready() before using VQs
in the probe function.

Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/virtio_transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4a8548bdf86c..c5f936fbf876 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -627,6 +627,8 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 
 	vdev->priv = vsock;
 
+	virtio_device_ready(vdev);
+
 	mutex_lock(&vsock->tx_lock);
 	vsock->tx_run = true;
 	mutex_unlock(&vsock->tx_lock);
-- 
2.34.1



