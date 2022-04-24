Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EE8C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Apr 2022 02:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbiDXCpA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Apr 2022 22:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237795AbiDXCoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:44:01 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C9D86E12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:41:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VAzpPKJ_1650768058;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VAzpPKJ_1650768058)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 10:40:59 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 16/16] virtio_ring: virtqueue_resize() no longer call recycle() directly
Date:   Sun, 24 Apr 2022 10:40:44 +0800
Message-Id: <20220424024044.94749-17-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220424024044.94749-1-xuanzhuo@linux.alibaba.com>
References: <20220424024044.94749-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: c42022d07dde
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtqueue_resize() no longer calls the recycle callback to release the
buffer. These bufs are reused by virtqueue_resize_* first, and if they
cannot be used, the buffers that cannot be reused will be released

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 730c8dded4c7..51dab35a54c9 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2895,7 +2895,6 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct virtio_device *vdev = vq->vq.vdev;
 	bool packed;
-	void *buf;
 	int err;
 
 	if (!vq->we_own_ring)
@@ -2922,16 +2921,19 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 	if (err)
 		return err;
 
-	while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
-		recycle(_vq, buf);
-
 	if (packed)
 		err = virtqueue_resize_packed(_vq, num, recycle);
 	else
 		err = virtqueue_resize_split(_vq, num, recycle);
 
-	if (vdev->config->enable_reset_vq(_vq))
+	if (vdev->config->enable_reset_vq(_vq)) {
 		return -EBUSY;
+	} else if (!err) {
+		num = packed ? vq->packed.vring.num : vq->split.vring.num;
+
+		if (num != vq->vq.num_free)
+			virtqueue_kick(_vq);
+	}
 
 	return err;
 }
-- 
2.31.0

