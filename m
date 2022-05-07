Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB3EC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 May 2022 07:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446009AbiEGHYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 May 2022 03:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446033AbiEGHYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 03:24:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09118625F
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 00:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651908054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qxWCBX67LoypfOKx41q1WWRqT+GYqMu3J8aV+HRfxD0=;
        b=FKM/KgNYCxSRPj88Ti3Eys4rbAIn1jOqsMWH0lFzWsehcbEls4dxTD+5yHAtP0vgItGw5d
        y5uu3Y6NIfWVsxd7Sa8PEA5R9kNTX0yfE19cteAkMuy43x/kFLdhR8TjWMLkVFG9dDO052
        aBRmP9otbMV1/EZUce/aKx8gkVHor3s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-bDC2OH_FNzO-ijjO9wdlzA-1; Sat, 07 May 2022 03:20:50 -0400
X-MC-Unique: bDC2OH_FNzO-ijjO9wdlzA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5F7B8002B2;
        Sat,  7 May 2022 07:20:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-216.pek2.redhat.com [10.72.13.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E018240D2971;
        Sat,  7 May 2022 07:20:42 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     jasowang@redhat.com, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, cohuck@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, sgarzare@redhat.com,
        xuanzhuo@linux.alibaba.com
Subject: [PATCH V4 7/9] virtio: allow to unbreak virtqueue
Date:   Sat,  7 May 2022 15:19:52 +0800
Message-Id: <20220507071954.14455-8-jasowang@redhat.com>
In-Reply-To: <20220507071954.14455-1-jasowang@redhat.com>
References: <20220507071954.14455-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows the new introduced __virtio_break_device() to
unbreak the virtqueue.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 21 +++++++++++++++++++++
 include/linux/virtio.h       |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cfb028ca238e..5b7df7c455f0 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2397,6 +2397,27 @@ void virtio_break_device(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(virtio_break_device);
 
+/*
+ * This should allow the device to be used by the driver. You may
+ * need to grab appropriate locks to flush. This should only be used
+ * in some specific case e.g (probing and restoring). Driver should
+ * not call this directly.
+ */
+void __virtio_unbreak_device(struct virtio_device *dev)
+{
+	struct virtqueue *_vq;
+
+	spin_lock(&dev->vqs_list_lock);
+	list_for_each_entry(_vq, &dev->vqs, list) {
+		struct vring_virtqueue *vq = to_vvq(_vq);
+
+		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
+		WRITE_ONCE(vq->broken, false);
+	}
+	spin_unlock(&dev->vqs_list_lock);
+}
+EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
+
 dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 5464f398912a..d8fdf170637c 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -131,6 +131,7 @@ void unregister_virtio_device(struct virtio_device *dev);
 bool is_virtio_device(struct device *dev);
 
 void virtio_break_device(struct virtio_device *dev);
+void __virtio_unbreak_device(struct virtio_device *dev);
 
 void virtio_config_changed(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
-- 
2.25.1

