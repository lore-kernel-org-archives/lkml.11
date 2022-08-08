Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55603C00140
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 17:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244341AbiHHRnf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243479AbiHHRnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:43:08 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C241A63B6
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980502; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3M9dCoUiG7SdzuIW6iaf9KAa+/qkvhEMPsTc9+Iggvw=;
        b=M3NO3DynpYQtboqwTH2CdhzDm/GQkHJUGBIOZYfRKfgjYOhtUfWv9zmWxYBY87cOI1Dd16
        /98EK2yQmcAfItMDu347esZbi4uBSW+JP6MEZrkLGCORY8oqCHeTurTyn6cdXzQVjHbobx
        nREFCkvO64C6NyFCZn5xb8vAF7CfPZs=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 09/30] mfd: stpmic1: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:40:46 +0200
Message-Id: <20220808174107.38676-10-paul@crapouillou.net>
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
 drivers/mfd/stpmic1.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
index eb3da558c3fb..7d8b0c0548fe 100644
--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -162,7 +162,6 @@ static int stpmic1_probe(struct i2c_client *i2c,
 	return devm_of_platform_populate(dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int stpmic1_suspend(struct device *dev)
 {
 	struct i2c_client *i2c = to_i2c_client(dev);
@@ -187,9 +186,8 @@ static int stpmic1_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(stpmic1_pm, stpmic1_suspend, stpmic1_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(stpmic1_pm, stpmic1_suspend, stpmic1_resume);
 
 static const struct of_device_id stpmic1_of_match[] = {
 	{ .compatible = "st,stpmic1", },
@@ -201,7 +199,7 @@ static struct i2c_driver stpmic1_driver = {
 	.driver = {
 		.name = "stpmic1",
 		.of_match_table = of_match_ptr(stpmic1_of_match),
-		.pm = &stpmic1_pm,
+		.pm = pm_sleep_ptr(&stpmic1_pm),
 	},
 	.probe = stpmic1_probe,
 };
-- 
2.35.1

