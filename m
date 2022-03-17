Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA38C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 23:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiCQXiq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 19:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiCQXip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:38:45 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9D22986F6;
        Thu, 17 Mar 2022 16:37:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V7TGI0g_1647560243;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V7TGI0g_1647560243)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Mar 2022 07:37:24 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     dinguyen@kernel.org
Cc:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] EDAC/altera: Remove unnecessary print function dev_err()
Date:   Fri, 18 Mar 2022 07:37:22 +0800
Message-Id: <20220317233722.109036-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print function dev_err() is redundant because platform_get_irq()
already prints an error.

Eliminate the follow coccicheck warnings:
./drivers/edac/altera_edac.c:2153:2-9: line 2153 is redundant because
platform_get_irq() already prints an error
./drivers/edac/altera_edac.c:2188:2-9: line 2188 is redundant because
platform_get_irq() already prints an error

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/edac/altera_edac.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index e7e8e624a436..47dc35938fa8 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2149,10 +2149,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	}
 
 	edac->sb_irq = platform_get_irq(pdev, 0);
-	if (edac->sb_irq < 0) {
-		dev_err(&pdev->dev, "No SBERR IRQ resource\n");
+	if (edac->sb_irq < 0)
 		return edac->sb_irq;
-	}
 
 	irq_set_chained_handler_and_data(edac->sb_irq,
 					 altr_edac_a10_irq_handler,
@@ -2184,10 +2182,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	}
 #else
 	edac->db_irq = platform_get_irq(pdev, 1);
-	if (edac->db_irq < 0) {
-		dev_err(&pdev->dev, "No DBERR IRQ resource\n");
+	if (edac->db_irq < 0)
 		return edac->db_irq;
-	}
 	irq_set_chained_handler_and_data(edac->db_irq,
 					 altr_edac_a10_irq_handler, edac);
 #endif
-- 
2.20.1.7.g153144c

