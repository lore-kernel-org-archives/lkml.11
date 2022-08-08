Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA81C00140
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 17:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244104AbiHHRnM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244291AbiHHRmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:42:45 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E296277
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980502; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+FBECTcdeQLfSp5bHcYAa/1zAvqLKLLp0tQ+VpGze+A=;
        b=OXQCBo5FXH3fsXQ9+jXS+adX5jJl+ptBHGO+bKbqmuBed2aNPbhhG+XfoBUGT8AStcGh/m
        8N6GjMmv+7Lx+6RmNMie2G30HNSqNVG94+Cy+v7zNJknFf3YEO63iSiAvSzPLKLm4WGFei
        OMtKwTQWAo3e8MluzcOTDgAIGnDoSGM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 06/30] mfd: mt6397-irq: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:40:43 +0200
Message-Id: <20220808174107.38676-7-paul@crapouillou.net>
In-Reply-To: <20220808174107.38676-1-paul@crapouillou.net>
References: <20220808174107.38676-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new pm_sleep_ptr() macro to handle the .irq_set_wake() callback.

This macro allows the mt6397_irq_set_wake() function to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org

 drivers/mfd/mt6397-irq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
index eff53fed8fe7..72f923e47752 100644
--- a/drivers/mfd/mt6397-irq.c
+++ b/drivers/mfd/mt6397-irq.c
@@ -54,7 +54,6 @@ static void mt6397_irq_enable(struct irq_data *data)
 	mt6397->irq_masks_cur[reg] |= BIT(shift);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mt6397_irq_set_wake(struct irq_data *irq_data, unsigned int on)
 {
 	struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(irq_data);
@@ -68,9 +67,6 @@ static int mt6397_irq_set_wake(struct irq_data *irq_data, unsigned int on)
 
 	return 0;
 }
-#else
-#define mt6397_irq_set_wake NULL
-#endif
 
 static struct irq_chip mt6397_irq_chip = {
 	.name = "mt6397-irq",
@@ -78,7 +74,7 @@ static struct irq_chip mt6397_irq_chip = {
 	.irq_bus_sync_unlock = mt6397_irq_sync_unlock,
 	.irq_enable = mt6397_irq_enable,
 	.irq_disable = mt6397_irq_disable,
-	.irq_set_wake = mt6397_irq_set_wake,
+	.irq_set_wake = pm_sleep_ptr(mt6397_irq_set_wake),
 };
 
 static void mt6397_irq_handle_reg(struct mt6397_chip *mt6397, int reg,
-- 
2.35.1

