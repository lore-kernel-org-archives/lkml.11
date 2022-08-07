Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D59C19F2A
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Aug 2022 14:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbiHGOy1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Aug 2022 10:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbiHGOyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:54:20 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4199AAE68
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659883983; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9EEjxCxLicj8lTr6QCkk7V2VA0JvsqtxcXWH+ZhahwI=;
        b=c5LvvzDrwTynPBgZJl9rxPixvuEHUAEGLiuvYtoPsYMYez88X0fjE1fQ92PIPiaHEcp26z
        qju+KtrhzjTZ8+UMcDvLYhIfLh1cLdFnvFgPG9KeWmXQuCIsKUIcWL5R0U+yHFfESB61++
        AxFnGgRO9BjkXkGrmoa/apGMagQIop0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 09/28] mfd: ucb1x00: Remove #ifdef guards for PM related functions
Date:   Sun,  7 Aug 2022 16:52:28 +0200
Message-Id: <20220807145247.46107-10-paul@crapouillou.net>
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
 drivers/mfd/ucb1x00-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index b690796d24d4..fc4d4c844a81 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -660,7 +660,6 @@ void ucb1x00_unregister_driver(struct ucb1x00_driver *drv)
 	mutex_unlock(&ucb1x00_mutex);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int ucb1x00_suspend(struct device *dev)
 {
 	struct ucb1x00_plat_data *pdata = dev_get_platdata(dev);
@@ -728,15 +727,15 @@ static int ucb1x00_resume(struct device *dev)
 	mutex_unlock(&ucb1x00_mutex);
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(ucb1x00_pm_ops, ucb1x00_suspend, ucb1x00_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ucb1x00_pm_ops,
+				ucb1x00_suspend, ucb1x00_resume);
 
 static struct mcp_driver ucb1x00_driver = {
 	.drv		= {
 		.name	= "ucb1x00",
 		.owner	= THIS_MODULE,
-		.pm	= &ucb1x00_pm_ops,
+		.pm	= pm_sleep_ptr(&ucb1x00_pm_ops),
 	},
 	.probe		= ucb1x00_probe,
 	.remove		= ucb1x00_remove,
-- 
2.35.1

