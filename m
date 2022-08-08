Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EEEC00140
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 17:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243932AbiHHRqf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244567AbiHHRqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:46:12 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B44018385
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980508; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FKwp4R0sM21Ivi8navoOTJy75R51wyGPAcCybh3hh04=;
        b=2GxqKJdDBLDaiQJH6IIZccu2N9k3FrhHHzCMY1gP8AWdV6fMx00EYAurYdebM42B5ggY5W
        nb3qhLvTdkBS66nsybjV522eYsK7dK794hLuOcxxRVNFJZasqqDLLX/LjCBOJAarinTLj+
        5qOTNdIVdVOIl5ExnAEo+8DTeuIsSlI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 29/30] mfd: tc6393xb: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:41:06 +0200
Message-Id: <20220808174107.38676-30-paul@crapouillou.net>
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
 drivers/mfd/tc6393xb.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
index aa903a31dd43..997bb8b5881d 100644
--- a/drivers/mfd/tc6393xb.c
+++ b/drivers/mfd/tc6393xb.c
@@ -813,7 +813,6 @@ static int tc6393xb_remove(struct platform_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int tc6393xb_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct tc6393xb_platform_data *tcpd = dev_get_platdata(&dev->dev);
@@ -876,16 +875,12 @@ static int tc6393xb_resume(struct platform_device *dev)
 
 	return 0;
 }
-#else
-#define tc6393xb_suspend NULL
-#define tc6393xb_resume NULL
-#endif
 
 static struct platform_driver tc6393xb_driver = {
 	.probe = tc6393xb_probe,
 	.remove = tc6393xb_remove,
-	.suspend = tc6393xb_suspend,
-	.resume = tc6393xb_resume,
+	.suspend = pm_sleep_ptr(tc6393xb_suspend),
+	.resume = pm_sleep_ptr(tc6393xb_resume),
 
 	.driver = {
 		.name = "tc6393xb",
-- 
2.35.1

