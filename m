Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093DAC00140
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 17:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244257AbiHHRnj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244177AbiHHRnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:43:15 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF69BF51
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980503; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o88MccR3qEu1Ka3g1RWgK0rEm5DdYE6bq3HPlQGFNi4=;
        b=eWq4vwHNIQTJEixfagkwe7b0TWqu3V3U/Kw5gXfVGNC5USoO0zhaVyd1KS+dKfSR+69eom
        qfcxArmyxLJfINGzNPqw/m6iZq/BgJjQoNn2n/IeKjoWy2JCF57vnoZ8tQrGYiQiVi2Vmi
        I5k+5QzqaExyI+L02AC0NJnISXNTQQM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 10/30] mfd: ucb1x00: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:40:47 +0200
Message-Id: <20220808174107.38676-11-paul@crapouillou.net>
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

