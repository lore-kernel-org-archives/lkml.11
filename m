Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A9BC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Jul 2022 02:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiGGCzv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 22:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbiGGCzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:55:44 -0400
Received: from smtp236.sjtu.edu.cn (smtp236.sjtu.edu.cn [202.120.2.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668982E9FE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 19:55:43 -0700 (PDT)
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp236.sjtu.edu.cn (Postfix) with ESMTPS id 86E7B1008B38D;
        Thu,  7 Jul 2022 10:44:52 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 0172A200A52B4;
        Thu,  7 Jul 2022 10:44:50 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kpTCTY_YsFCG; Thu,  7 Jul 2022 10:44:49 +0800 (CST)
Received: from localhost.localdomain (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 9FFD1200A5BFF;
        Thu,  7 Jul 2022 10:44:39 +0800 (CST)
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
To:     jasowang@redhat.com, mst@redhat.com
Cc:     eperezma@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>
Subject: [PATCH v2 3/4] virtio_test: use random length scatterlists to test descriptor chain
Date:   Thu,  7 Jul 2022 10:44:08 +0800
Message-Id: <20220707024409.1869-4-qtxuning1999@sjtu.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220707024409.1869-1-qtxuning1999@sjtu.edu.cn>
References: <20220707024409.1869-1-qtxuning1999@sjtu.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior implementation only use one descriptor for each io event, which
does't test code of descriptor chain. More importantly, one descriptor
will not use indirect feature even indirect feature is specified. Use
random length scatterlists here to test descriptor chain.

Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
---
 tools/virtio/virtio_test.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 1ecd64271..363695b33 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -20,6 +20,7 @@
 #include "../../drivers/vhost/test.h"
 
 #define RANDOM_BATCH -1
+#define MAX_SG_FRAGS 8UL
 #define ALIGN 4096
 #define RINGSIZE   256
 #define TEST_BUF_NUM 0x100000
@@ -172,7 +173,8 @@ static void wait_for_interrupt(struct vdev_info *dev)
 static void run_test(struct vdev_info *dev, struct vq_info *vq,
 		     bool delayed, int batch, int reset_n, int bufs)
 {
-	struct scatterlist sl;
+	struct scatterlist sg[MAX_SG_FRAGS];
+	int sg_size = 0;
 	long started = 0, completed = 0, next_reset = reset_n;
 	long completed_before, started_before;
 	int r, test = 1;
@@ -197,8 +199,11 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 
 			while (started < bufs &&
 			       (started - completed) < batch) {
-				sg_init_one(&sl, dev->buf, dev->buf_size);
-				r = virtqueue_add_outbuf(vq->vq, &sl, 1,
+				sg_size = random() % (MAX_SG_FRAGS - 1) + 1;
+				sg_init_table(sg, sg_size);
+				for (int i = 0; i < sg_size; ++i)
+					sg_set_buf(&sg[i], dev->buf + i, 0x1);
+				r = virtqueue_add_outbuf(vq->vq, sg, sg_size,
 							 dev->buf + started,
 							 GFP_ATOMIC);
 				if (unlikely(r != 0)) {
-- 
2.17.1

