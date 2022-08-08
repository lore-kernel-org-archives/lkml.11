Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6DDC00140
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 17:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243876AbiHHRoR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbiHHRnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:43:37 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9F717E0D
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980504; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kZIVuuKKO+sS/oNnpnJC3ag5t6waBzISKhOioOsnm4=;
        b=dcV7nTb2v4GfByhH2Zck6ifngQ987cv/AmVNxvD7h8UHDHwCT0qLNBWJ6dv3N44zBSRTS2
        2KJl9GGvr8hVyK5F7udILXA1JbdftHHCaNwXK37evov1L6yT9fOj38n3SLgVENUcZalCFA
        hExwxYRJMEBrtR60FAaHZymRiG1BNbs=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 13/30] mfd: mcp-sa11x0: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:40:50 +0200
Message-Id: <20220808174107.38676-14-paul@crapouillou.net>
In-Reply-To: <20220808174107.38676-1-paul@crapouillou.net>
References: <20220808174107.38676-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new pm_sleep_ptr() macro to handle the .suspend/.resume
callbacks.

This macro allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mfd/mcp-sa11x0.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index 4629dff187cd..1c9831b78cf9 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -255,7 +255,6 @@ static int mcp_sa11x0_remove(struct platform_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mcp_sa11x0_suspend(struct device *dev)
 {
 	struct mcp_sa11x0 *m = priv(dev_get_drvdata(dev));
@@ -277,17 +276,14 @@ static int mcp_sa11x0_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops mcp_sa11x0_pm_ops = {
-#ifdef CONFIG_PM_SLEEP
 	.suspend = mcp_sa11x0_suspend,
 	.freeze = mcp_sa11x0_suspend,
 	.poweroff = mcp_sa11x0_suspend,
 	.resume_noirq = mcp_sa11x0_resume,
 	.thaw_noirq = mcp_sa11x0_resume,
 	.restore_noirq = mcp_sa11x0_resume,
-#endif
 };
 
 static struct platform_driver mcp_sa11x0_driver = {
@@ -295,7 +291,7 @@ static struct platform_driver mcp_sa11x0_driver = {
 	.remove		= mcp_sa11x0_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
-		.pm	= &mcp_sa11x0_pm_ops,
+		.pm	= pm_sleep_ptr(&mcp_sa11x0_pm_ops),
 	},
 };
 
-- 
2.35.1

