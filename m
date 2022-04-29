Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A218C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Apr 2022 07:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355143AbiD2H0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Apr 2022 03:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355097AbiD2HZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:25:50 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DE6BF949
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1651216953;
  x=1682752953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s9Yl1wMdrp/ororsKSLtd6aOtPFhY2okSFCoji6bXAg=;
  b=dv17XXy1Eko8sf50m/P6wQisxuCDuGRh0em7QEbb3svbESK/aoMefLqq
   XBDYHA6w5YbNcMvp/1/7Krsxuwww3LRTcE66WHbMvwa97kCtn6CBpvA+E
   CNjnEla/9sJykH8MuKEYtWtnMCBhO418ZJsx5rgHHnNhGLcu8z7b/4mwP
   qIVT5RIbj5TGUyZEB7UbcqojfoajpCmXBPHeUPm5HxKtv7w/FvFrktpRr
   HPTvoGZ9Yws6iZsYbLxIeAzftDGliikJ93jdmoO1Go7TKkaipBHzdoIl8
   ZBGuBVhMcHc1AHmcRDT0c7f6PJPlpy9o37NeB6WHhsp4SKxCKCl42a/ua
   A==;
From:   Rickard Andersson <rickaran@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rickaran@axis.com>, <rickard314.andersson@gmail.com>,
        <perdo@axis.com>
Subject: [PATCH v2 4/5] regulator: pca9450: Make warm reset on WDOG_B assertion
Date:   Fri, 29 Apr 2022 09:22:10 +0200
Message-ID: <20220429072211.24957-4-rickaran@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220429072211.24957-1-rickaran@axis.com>
References: <20220429072211.24957-1-rickaran@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail03w.axis.com
 (10.20.40.9)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rickard x Andersson <rickaran@axis.com>

The default configuration of the PMIC behavior makes the PMIC
power cycle most regulators on WDOG_B assertion. This power
cycling causes the memory contents of OCRAM to be lost.
Some systems neeeds some memory that survives reset and
reboot, therefore this patch is created.

Signed-off-by: Rickard x Andersson <rickaran@axis.com>
---
 drivers/regulator/pca9450-regulator.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 87b4e6e29ba1..4a3ae73c600c 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -702,6 +702,7 @@ static int pca9450_i2c_probe(struct i2c_client *i2c,
 	struct regulator_config config = { };
 	struct pca9450 *pca9450;
 	unsigned int device_id, i;
+	unsigned int reset_ctrl;
 	int ret;
 
 	if (!i2c->irq) {
@@ -802,9 +803,14 @@ static int pca9450_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	if (of_property_read_bool(i2c->dev.of_node, "nxp,wdog_b-warm-reset"))
+		reset_ctrl = WDOG_B_CFG_WARM;
+	else
+		reset_ctrl = WDOG_B_CFG_COLD_LDO12;
+
 	/* Set reset behavior on assertion of WDOG_B signal */
 	ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_RESET_CTRL,
-				WDOG_B_CFG_MASK, WDOG_B_CFG_COLD_LDO12);
+				 WDOG_B_CFG_MASK, reset_ctrl);
 	if (ret) {
 		dev_err(&i2c->dev, "Failed to set WDOG_B reset behavior\n");
 		return ret;
-- 
2.20.1

