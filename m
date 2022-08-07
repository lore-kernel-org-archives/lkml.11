Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C980C19F2A
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Aug 2022 14:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiHGOyZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Aug 2022 10:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiHGOyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:54:12 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2679DAE4A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 07:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659883983; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6u2SIaffd3f7960zDNLsyNem/Dn7gkj0HJTBKauWpVY=;
        b=HLvx3q/e/SrTBpCCaSkYkNwIv5VifzhfF/5i6kczy6q1HLoNoJGqQQIhx30plqQPIg5fiQ
        Qk7c1jsopLP39uBDlGJyoE2Trjphrimfurb01moIv0V4q02YApSjkj+SOte3Ou9ClPPOjJ
        zQ4HseXvox/YdMDOMQMCByBV95WKXwI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 08/28] mfd: stpmic1: Remove #ifdef guards for PM related functions
Date:   Sun,  7 Aug 2022 16:52:27 +0200
Message-Id: <20220807145247.46107-9-paul@crapouillou.net>
In-Reply-To: <20220807145247.46107-1-paul@crapouillou.net>
References: <20220807145247.46107-1-paul@crapouillou.net>
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

The advantage is then that these functions are now always compiled
independently of any Kconfig option, and thanks to that bugs and
regressions are easier to catch.

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

