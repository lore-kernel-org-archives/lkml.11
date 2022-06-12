Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F9AC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jun 2022 22:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbiFLWYk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jun 2022 18:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbiFLWYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 18:24:30 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACC52603;
        Sun, 12 Jun 2022 15:24:28 -0700 (PDT)
Received: from hednb3.intra.ispras.ru (unknown [109.252.137.140])
        by mail.ispras.ru (Postfix) with ESMTPSA id 1E71A40D403E;
        Sun, 12 Jun 2022 22:24:15 +0000 (UTC)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Vinod Koul <vkoul@kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] dmaengine: stm32-mdma: Remove dead code in stm32_mdma_irq_handler()
Date:   Mon, 13 Jun 2022 01:23:58 +0300
Message-Id: <1655072638-9103-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local variable chan is initialized by an address of element of chan array
that is part of stm32_mdma_device struct, so it does not make sense to
compare chan with NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: a4ffb13c8946 ("dmaengine: Add STM32 MDMA driver")
---
 drivers/dma/stm32-mdma.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index caf0cce8f528..b11927ed4367 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1328,12 +1328,7 @@ static irqreturn_t stm32_mdma_irq_handler(int irq, void *devid)
 		return IRQ_NONE;
 	}
 	id = __ffs(status);
-
 	chan = &dmadev->chan[id];
-	if (!chan) {
-		dev_warn(mdma2dev(dmadev), "MDMA channel not initialized\n");
-		return IRQ_NONE;
-	}
 
 	/* Handle interrupt for the channel */
 	spin_lock(&chan->vchan.lock);
-- 
2.7.4

