Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323B4C00140
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 17:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244322AbiHHRow (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244212AbiHHRoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:44:08 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997E8B7D0
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980504; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/b5mnnm0Rrk2tWrdMsk7U9nz3befFnxCSquAwgZEHQ=;
        b=1+vRiiKDKVDx3qSemL/wdCxkvhMxUvBM+FzgzwYncJXoNAcGKp8l8sQ0sgQkBu6D55By6N
        KMaE8atGItwWOyyiGJR8K7p2ZelBIUJ9JfcrRwRWnqMtjadetwBvcg47P5E0rBrfhgY9eQ
        C+/hyoao3dxTeduG8Vd7LVobgIB5/rQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 15/30] mfd: sm501: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:40:52 +0200
Message-Id: <20220808174107.38676-16-paul@crapouillou.net>
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
 drivers/mfd/sm501.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index bc0a2c38653e..81e15e646e77 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1432,8 +1432,6 @@ static int sm501_plat_probe(struct platform_device *dev)
 
 }
 
-#ifdef CONFIG_PM
-
 /* power management support */
 
 static void sm501_set_power(struct sm501_devdata *sm, int on)
@@ -1509,10 +1507,6 @@ static int sm501_plat_resume(struct platform_device *pdev)
 
 	return 0;
 }
-#else
-#define sm501_plat_suspend NULL
-#define sm501_plat_resume NULL
-#endif
 
 /* Initialisation data for PCI devices */
 
@@ -1714,8 +1708,8 @@ static struct platform_driver sm501_plat_driver = {
 	},
 	.probe		= sm501_plat_probe,
 	.remove		= sm501_plat_remove,
-	.suspend	= sm501_plat_suspend,
-	.resume		= sm501_plat_resume,
+	.suspend	= pm_sleep_ptr(sm501_plat_suspend),
+	.resume		= pm_sleep_ptr(sm501_plat_resume),
 };
 
 static int __init sm501_base_init(void)
-- 
2.35.1

