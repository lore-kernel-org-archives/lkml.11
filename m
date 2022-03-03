Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81448C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 02:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiCCCbC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 21:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiCCCa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:30:59 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E013DBB2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 18:30:14 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V65YKLq_1646274611;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V65YKLq_1646274611)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Mar 2022 10:30:11 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     alison.wang@nxp.com
Cc:     stefan@agner.ch, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/fsl-dcu: Remove unnecessary print function dev_err()
Date:   Thu,  3 Mar 2022 10:30:10 +0800
Message-Id: <20220303023010.61403-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print function dev_err() is redundant because platform_get_irq()
already prints an error.

Eliminate the follow coccicheck warning:
./drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c:277:2-9: line 277 is
redundant because platform_get_irq() already prints an error

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 7a503bf08d0f..20895ea79739 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -273,10 +273,8 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 	}
 
 	fsl_dev->irq = platform_get_irq(pdev, 0);
-	if (fsl_dev->irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (fsl_dev->irq < 0)
 		return fsl_dev->irq;
-	}
 
 	fsl_dev->regmap = devm_regmap_init_mmio(dev, base,
 			&fsl_dcu_regmap_config);
-- 
2.20.1.7.g153144c

