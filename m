Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977ABC25B0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 17:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbiHHRqT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244379AbiHHRpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:45:41 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C500F183A4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980506; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fH7g4YysWMLgOSNDG15jV52CUiW7mUEZ75bQsRILO7Y=;
        b=H0VHLsbYp8c5jqwWIRjjG6MtW8rqM36HU7ADKohq4UDBGIcO//9HKUhYArrvLgt4WI19gv
        OV7lv2IzJZq1tp8HUjrz143P4uoT4zGv+xn1hGiUS4gvbIVY1LDwPpOwAT3XmgBmrRnk+U
        EnpmebtUfqCCCG/RMIX23YTJ5A0QVYY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 24/30] mfd: motorola-cpcap: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:41:01 +0200
Message-Id: <20220808174107.38676-25-paul@crapouillou.net>
In-Reply-To: <20220808174107.38676-1-paul@crapouillou.net>
References: <20220808174107.38676-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
to handle the .suspend/.resume callbacks.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mfd/motorola-cpcap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index 265464b5d7cc..ae8930eff72d 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -221,7 +221,6 @@ static const struct regmap_config cpcap_regmap_config = {
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 };
 
-#ifdef CONFIG_PM_SLEEP
 static int cpcap_suspend(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
@@ -239,9 +238,8 @@ static int cpcap_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(cpcap_pm, cpcap_suspend, cpcap_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(cpcap_pm, cpcap_suspend, cpcap_resume);
 
 static const struct mfd_cell cpcap_mfd_devices[] = {
 	{
@@ -346,7 +344,7 @@ static struct spi_driver cpcap_driver = {
 	.driver = {
 		.name = "cpcap-core",
 		.of_match_table = cpcap_of_match,
-		.pm = &cpcap_pm,
+		.pm = pm_sleep_ptr(&cpcap_pm),
 	},
 	.probe = cpcap_probe,
 	.id_table = cpcap_spi_ids,
-- 
2.35.1

