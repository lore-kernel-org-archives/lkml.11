Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C02C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 10:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240431AbiC1LAF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 07:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239700AbiC1LAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:00:03 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189D817069
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 03:58:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V8R4is0_1648465099;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0V8R4is0_1648465099)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Mar 2022 18:58:19 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     mst@redhat.com, jasowang@redhat.com, sgarzare@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH 1/2] virtio_ring: remove unnecessary to_vvq call in vring hot path
Date:   Mon, 28 Mar 2022 18:58:16 +0800
Message-Id: <20220328105817.1028065-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It passes '_vq' to virtqueue_use_indirect(), which still calls
to_vvq to get 'vq', let's directly pass 'vq'. It can avoid
unnecessary call of to_vvq in hot path.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 962f1477b1fa..d597fc0874ec 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -205,11 +205,9 @@ struct vring_virtqueue {
 
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
 
-static inline bool virtqueue_use_indirect(struct virtqueue *_vq,
+static inline bool virtqueue_use_indirect(struct vring_virtqueue *vq,
 					  unsigned int total_sg)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
 	/*
 	 * If the host supports indirect descriptor tables, and we have multiple
 	 * buffers, then go indirect. FIXME: tune this threshold
@@ -507,7 +505,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 	head = vq->free_head;
 
-	if (virtqueue_use_indirect(_vq, total_sg))
+	if (virtqueue_use_indirect(vq, total_sg))
 		desc = alloc_indirect_split(_vq, total_sg, gfp);
 	else {
 		desc = NULL;
@@ -1194,7 +1192,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 
 	BUG_ON(total_sg == 0);
 
-	if (virtqueue_use_indirect(_vq, total_sg)) {
+	if (virtqueue_use_indirect(vq, total_sg)) {
 		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
 						    in_sgs, data, gfp);
 		if (err != -ENOMEM) {
-- 
2.17.1

