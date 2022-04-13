Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3A6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 02:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiDMCiS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 22:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiDMCiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 22:38:11 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D33036B53;
        Tue, 12 Apr 2022 19:35:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V9xY8iS_1649817284;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V9xY8iS_1649817284)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Apr 2022 10:35:49 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     gustavo.pimentel@synopsys.com
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] dmaengine: dw-edma: Fix inconsistent indenting
Date:   Wed, 13 Apr 2022 10:34:42 +0800
Message-Id: <20220413023442.18856-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:

drivers/dma/dw-edma/dw-edma-v0-core.c:419 dw_edma_v0_core_start() warn:
inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index b5b8f8181e77..33bc1e6c4cf2 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -414,17 +414,18 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
 		/* Linked list */
+
 		#ifdef CONFIG_64BIT
-			/* llp is not aligned on 64bit -> keep 32bit accesses */
-			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-				  lower_32_bits(chunk->ll_region.paddr));
-			SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-				  upper_32_bits(chunk->ll_region.paddr));
+		/* llp is not aligned on 64bit -> keep 32bit accesses */
+		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+			  lower_32_bits(chunk->ll_region.paddr));
+		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+			  upper_32_bits(chunk->ll_region.paddr));
 		#else /* CONFIG_64BIT */
-			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-				  lower_32_bits(chunk->ll_region.paddr));
-			SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-				  upper_32_bits(chunk->ll_region.paddr));
+		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+			  lower_32_bits(chunk->ll_region.paddr));
+		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+			  upper_32_bits(chunk->ll_region.paddr));
 		#endif /* CONFIG_64BIT */
 	}
 	/* Doorbell */
-- 
2.20.1.7.g153144c

