Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE817C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 09:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbiEYJdj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 05:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiEYJdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:33:36 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C138A326;
        Wed, 25 May 2022 02:33:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VEMu0is_1653471195;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VEMu0is_1653471195)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 May 2022 17:33:33 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     olivierdautricourt@gmail.com
Cc:     sr@denx.de, vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] dmaengine: altera: Fix kernel-doc
Date:   Wed, 25 May 2022 17:33:13 +0800
Message-Id: <20220525093313.52749-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following W=1 kernel warnings:

drivers/dma/altera-msgdma.c:927: warning: expecting prototype for
msgdma_dma_remove(). Prototype was for msgdma_remove() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/dma/altera-msgdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 6f56dfd375e3..bdaac5d62a04 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -918,7 +918,7 @@ static int msgdma_probe(struct platform_device *pdev)
 }
 
 /**
- * msgdma_dma_remove - Driver remove function
+ * msgdma_remove() - Driver remove function
  * @pdev: Pointer to the platform_device structure
  *
  * Return: Always '0'
-- 
2.20.1.7.g153144c

