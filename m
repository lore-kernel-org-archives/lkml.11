Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC27C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Apr 2022 02:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbiDXCn4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Apr 2022 22:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbiDXCns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:43:48 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F1F7DA8D
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:40:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VAzcuYK_1650768046;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VAzcuYK_1650768046)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 10:40:46 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 02/16] virtio_ring: split: introduce vring_virtqueue_detach_split()
Date:   Sun, 24 Apr 2022 10:40:30 +0800
Message-Id: <20220424024044.94749-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220424024044.94749-1-xuanzhuo@linux.alibaba.com>
References: <20220424024044.94749-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: c42022d07dde
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function vring_virtqueue_detach_split() is introduced to detach the
vring of the current vq.

num_left records how many buffers there are, which can be used to check
the recovery of buffers completed.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0a2c58557027..f3ad9322b512 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -112,6 +112,8 @@ struct vring_virtqueue_split {
 	 */
 	u32 vring_align;
 	bool may_reduce_num;
+
+	u32 num_left;
 };
 
 struct vring_virtqueue_packed {
@@ -982,6 +984,21 @@ static void virtqueue_reinit_split(struct vring_virtqueue *vq)
 	virtqueue_vring_init_split(vq);
 }
 
+static void virtqueue_vring_detach_split(struct vring_virtqueue *vq,
+					 struct vring_virtqueue_split *vring)
+{
+	vring->vring = vq->split.vring;
+
+	vring->queue_dma_addr = vq->split.queue_dma_addr;
+
+	vring->queue_size_in_bytes = vq->split.queue_size_in_bytes;
+
+	vring->desc_extra = vq->split.desc_extra;
+	vring->desc_state = vq->split.desc_state;
+
+	vring->num_left = vring->vring.num - vq->vq.num_free;
+}
+
 static void virtqueue_vring_attach_split(struct vring_virtqueue *vq,
 					 struct vring_virtqueue_split *vring)
 {
-- 
2.31.0

