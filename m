Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D7AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Jul 2022 01:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbiGGBrJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 21:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiGGBrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:47:08 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCAA2ED6F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 18:47:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VIaWWVA_1657158423;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VIaWWVA_1657158423)
          by smtp.aliyun-inc.com;
          Thu, 07 Jul 2022 09:47:04 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tomba@kernel.org
Cc:     daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] drm: Remove unnecessary print function dev_err()
Date:   Thu,  7 Jul 2022 09:47:01 +0800
Message-Id: <20220707014701.74829-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The print function dev_err() is redundant because platform_get_irq()
already prints an error.

Eliminate the follow coccicheck warning:
./drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:817:2-9: line 817 is redundant because platform_get_irq() already prints an error

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index ac869acf80ea..61a27dd7392e 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -813,10 +813,8 @@ static int omap_dmm_probe(struct platform_device *dev)
 	}
 
 	omap_dmm->irq = platform_get_irq(dev, 0);
-	if (omap_dmm->irq < 0) {
-		dev_err(&dev->dev, "failed to get IRQ resource\n");
+	if (omap_dmm->irq < 0)
 		goto fail;
-	}
 
 	omap_dmm->dev = &dev->dev;
 
-- 
2.20.1.7.g153144c

