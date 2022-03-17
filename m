Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603B3C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 10:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbiCQKYG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiCQKYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:24:03 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450811DE6E4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 03:22:46 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 17 Mar
 2022 18:22:45 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 17 Mar
 2022 18:22:44 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] dmaengine: pl08x: remove unneeded variable: "retval". Return "NULL"
Date:   Thu, 17 Mar 2022 18:22:42 +0800
Message-ID: <1647512562-18246-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unneeded variable: "retval". Return "NULL" , so we have to make code clear.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/dma/amba-pl08x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index a24882b..c70552a 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1538,9 +1538,7 @@ static void pl08x_free_chan_resources(struct dma_chan *chan)
 static struct dma_async_tx_descriptor *pl08x_prep_dma_interrupt(
 		struct dma_chan *chan, unsigned long flags)
 {
-	struct dma_async_tx_descriptor *retval = NULL;
-
-	return retval;
+	return NULL;
 }
 
 /*
-- 
2.7.4

