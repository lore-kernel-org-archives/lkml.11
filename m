Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22340C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 01:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbiBNBGM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Feb 2022 20:06:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiBNBGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 20:06:09 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAFE527CE
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 17:06:02 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V4JW9p0_1644800759;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V4JW9p0_1644800759)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 14 Feb 2022 09:06:00 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     benh@kernel.crashing.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] macintosh: Fix warning comparing pointer to 0
Date:   Mon, 14 Feb 2022 09:05:58 +0800
Message-Id: <20220214010558.130201-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:
./drivers/macintosh/via-cuda.c:240:16-17: WARNING comparing pointer to 0
./drivers/macintosh/via-cuda.c:243:16-17: WARNING comparing pointer to
0, suggest !E
./drivers/macintosh/via-cuda.c:521:23-24: WARNING comparing pointer to 0

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/macintosh/via-cuda.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index 3d0d0b9d471d..a9feb7d5a068 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -237,10 +237,10 @@ int __init find_via_cuda(void)
     const u32 *reg;
     int err;
 
-    if (vias != 0)
+    if (vias)
 	return 1;
     vias = of_find_node_by_name(NULL, "via-cuda");
-    if (vias == 0)
+    if (!vias)
 	return 0;
 
     reg = of_get_property(vias, "reg", NULL);
@@ -518,7 +518,7 @@ cuda_write(struct adb_request *req)
     req->reply_len = 0;
 
     spin_lock_irqsave(&cuda_lock, flags);
-    if (current_req != 0) {
+    if (current_req) {
 	last_req->next = req;
 	last_req = req;
     } else {
-- 
2.20.1.7.g153144c

