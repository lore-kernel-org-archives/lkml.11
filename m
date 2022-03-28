Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56377C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 10:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbiC1LAJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 07:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbiC1LAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:00:05 -0400
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EF11C103
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 03:58:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V8SAF7z_1648465100;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0V8SAF7z_1648465100)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Mar 2022 18:58:20 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     mst@redhat.com, jasowang@redhat.com, sgarzare@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH 2/2] virtio_ring: add unlikely annotation for free descs check
Date:   Mon, 28 Mar 2022 18:58:17 +0800
Message-Id: <20220328105817.1028065-2-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220328105817.1028065-1-xianting.tian@linux.alibaba.com>
References: <20220328105817.1028065-1-xianting.tian@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'if (vq->vq.num_free < descs_used)' check will almost always be false.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index d597fc0874ec..ab6d5f0cb579 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -525,7 +525,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		descs_used = total_sg;
 	}
 
-	if (vq->vq.num_free < descs_used) {
+	if (unlikely(vq->vq.num_free < descs_used)) {
 		pr_debug("Can't add buf len %i - avail = %i\n",
 			 descs_used, vq->vq.num_free);
 		/* FIXME: for historical reasons, we force a notify here if
-- 
2.17.1

