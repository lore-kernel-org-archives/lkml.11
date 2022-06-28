Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C15CCA479
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 22:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiF1WV2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 18:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiF1WVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:21:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE0F3E5DE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656454674; x=1687990674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lejqAX10TwSRtZfZ5iBdyeXkkAo8WkkzD3AhrUowKEI=;
  b=kU3Wpaa0Ijk/TyQ0CVmW0x6kBfxPuy4jzHHHLw5Bdp5TtkhVnmcPQ2LS
   NX/zawl2FU2K+8tT1MaDQCDfHT6YUCYf05p6OszMVlFm1MC18jkj0H+21
   4vykfeiPJCbS56yi83nV1bNgagUKbLiP3dg3g3BwNGFgV1nYpE6+E8NVB
   cTFW/aoPtMEqXPG3hLvQU5KcBO14dYOMEMc2joFhRVNy2PkBhB1cFurqa
   4TkJ1hiP5xmO2GYcPELqLYLloaHXUEECN6MLTIZNKNMDzwXToqR3ZifZg
   uDwU36oRXTcXwDPze5TLH/V+9gbJa3pM0Xqbl+1f0O591FpHCjWlnnfVf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="307348942"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="307348942"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:17:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="658300939"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2022 15:17:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E78AE41; Wed, 29 Jun 2022 01:17:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 02/11] mfd: intel_soc_pmic_bxtwc: Create sysfs attributes using core driver's facility
Date:   Wed, 29 Jun 2022 01:17:38 +0300
Message-Id: <20220628221747.33956-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver core takes care of sysfs attributes. Use this facility instead of
doing it explicitly in ->probe() and ->remove().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
v2: added tag (Lee)
 drivers/mfd/intel_soc_pmic_bxtwc.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index bdc3153ee890..d43cd18f5189 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -396,6 +396,11 @@ static const struct attribute_group bxtwc_group = {
 	.attrs = bxtwc_attrs,
 };
 
+static const struct attribute_group *bxtwc_groups[] = {
+	&bxtwc_group,
+	NULL
+};
+
 static const struct regmap_config bxtwc_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
@@ -555,12 +560,6 @@ static int bxtwc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = sysfs_create_group(&pdev->dev.kobj, &bxtwc_group);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to create sysfs group %d\n", ret);
-		return ret;
-	}
-
 	/*
 	 * There is known hw bug. Upon reset BIT 5 of register
 	 * BXTWC_CHGR_LVL1_IRQ is 0 which is the expected value. However,
@@ -568,15 +567,7 @@ static int bxtwc_probe(struct platform_device *pdev)
 	 * have the software workaround here to unmaksed it in order to let
 	 * charger interrutp work.
 	 */
-	regmap_update_bits(pmic->regmap, BXTWC_MIRQLVL1,
-				BXTWC_MIRQLVL1_MCHGR, 0);
-
-	return 0;
-}
-
-static int bxtwc_remove(struct platform_device *pdev)
-{
-	sysfs_remove_group(&pdev->dev.kobj, &bxtwc_group);
+	regmap_update_bits(pmic->regmap, BXTWC_MIRQLVL1, BXTWC_MIRQLVL1_MCHGR, 0);
 
 	return 0;
 }
@@ -616,12 +607,12 @@ MODULE_DEVICE_TABLE(acpi, bxtwc_acpi_ids);
 
 static struct platform_driver bxtwc_driver = {
 	.probe = bxtwc_probe,
-	.remove	= bxtwc_remove,
 	.shutdown = bxtwc_shutdown,
 	.driver	= {
 		.name	= "BXTWC PMIC",
 		.pm     = &bxtwc_pm_ops,
 		.acpi_match_table = ACPI_PTR(bxtwc_acpi_ids),
+		.dev_groups = bxtwc_groups,
 	},
 };
 
-- 
2.35.1

