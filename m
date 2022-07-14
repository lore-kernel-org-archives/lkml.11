Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCFFC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 07:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbiGNHzn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 03:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiGNHzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:55:39 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9A81E4;
        Thu, 14 Jul 2022 00:55:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VJIAY5q_1657785334;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VJIAY5q_1657785334)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 15:55:34 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next RESEND] soc: qcom: icc-bwmon: Remove unnecessary print function dev_err()
Date:   Thu, 14 Jul 2022 15:55:32 +0800
Message-Id: <20220714075532.104665-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow coccicheck warning:
./drivers/soc/qcom/icc-bwmon.c:349:2-9: line 349 is redundant because platform_get_irq() already prints an error

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/soc/qcom/icc-bwmon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index bea3ea1de7a4..7f8aca533cd3 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -345,10 +345,8 @@ static int bwmon_probe(struct platform_device *pdev)
 	}
 
 	bwmon->irq = platform_get_irq(pdev, 0);
-	if (bwmon->irq < 0) {
-		dev_err(dev, "failed to acquire bwmon IRQ\n");
+	if (bwmon->irq < 0)
 		return bwmon->irq;
-	}
 
 	ret = devm_pm_opp_of_add_table(dev);
 	if (ret)
-- 
2.20.1.7.g153144c

