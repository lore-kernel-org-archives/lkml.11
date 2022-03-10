Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7543C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 00:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbiCJAXl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 19:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiCJAXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:23:33 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E6363F4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:22:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V6m-sN5_1646871744;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V6m-sN5_1646871744)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Mar 2022 08:22:30 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     codrin.ciubotariu@microchip.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ASoC: atmel: mchp-pdmc: Remove unnecessary print function dev_err()
Date:   Thu, 10 Mar 2022 08:22:21 +0800
Message-Id: <20220310002221.125448-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print function dev_err() is redundant because
platform_get_irq() already prints an error.

Eliminate the follow coccicheck warning:
./sound/soc/atmel/mchp-pdmc.c:991:2-9: line 991 is redundant because
platform_get_irq() already prints an error.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/atmel/mchp-pdmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
index c44636f6207d..2b48bd3434c7 100644
--- a/sound/soc/atmel/mchp-pdmc.c
+++ b/sound/soc/atmel/mchp-pdmc.c
@@ -988,7 +988,6 @@ static int mchp_pdmc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to get irq: %d\n", irq);
 		return irq;
 	}
 
-- 
2.20.1.7.g153144c

