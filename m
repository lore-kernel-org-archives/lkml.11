Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF04EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 08:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiGFI1x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 04:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiGFI1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:27:22 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6924624962;
        Wed,  6 Jul 2022 01:26:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VIXSr0B_1657095968;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VIXSr0B_1657095968)
          by smtp.aliyun-inc.com;
          Wed, 06 Jul 2022 16:26:17 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     olivierdautricourt@gmail.com
Cc:     sr@denx.de, vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH v3] dmaengine: altera-msgdma: Fixed some inconsistent function name descriptions
Date:   Wed,  6 Jul 2022 16:26:05 +0800
Message-Id: <20220706082605.114907-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inconsistent function names describing msgdma_chan_remove() and
msgdma_dma_remove are modified to msgdma_dev_remove() and msgdma_remove().

Remove some warnings found by running scripts/kernel-doc, which is caused
by using 'make W=1'.

drivers/dma/altera-msgdma.c:927: warning: expecting prototype for msgdma_dma_remove(). Prototype was for msgdma_remove() instead.
drivers/dma/altera-msgdma.c:758: warning: expecting prototype for msgdma_chan_remove(). Prototype was for msgdma_dev_remove() instead.

Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v3:
  -Modified the commit title and message.

 drivers/dma/altera-msgdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 6f56dfd375e3..4153c2edb049 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -749,7 +749,7 @@ static irqreturn_t msgdma_irq_handler(int irq, void *data)
 }
 
 /**
- * msgdma_chan_remove - Channel remove function
+ * msgdma_dev_remove() - Device remove function
  * @mdev: Pointer to the Altera mSGDMA device structure
  */
 static void msgdma_dev_remove(struct msgdma_device *mdev)
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

