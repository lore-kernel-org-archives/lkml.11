Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDADC04AA5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 07:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbiHYHeK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 03:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbiHYHeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:34:05 -0400
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133C0A285E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:34:02 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id R7NGoP3xBXaJmR7NGoO40u; Thu, 25 Aug 2022 09:34:00 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 25 Aug 2022 09:34:00 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: au1xmmc: Fix an error handling path in au1xmmc_probe()
Date:   Thu, 25 Aug 2022 09:33:57 +0200
Message-Id: <21d99886d07fa7fcbec74992657dabad98c935c4.1661412818.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If clk_prepare_enable() fails, there is no point in calling
clk_disable_unprepare() in the error handling path.

Move the out_clk label at the right place.

Fixes: b6507596dfd6 ("MIPS: Alchemy: au1xmmc: use clk framework")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mmc/host/au1xmmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index a9a0837153d8..c88b039dc9fb 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -1097,8 +1097,9 @@ static int au1xmmc_probe(struct platform_device *pdev)
 	if (host->platdata && host->platdata->cd_setup &&
 	    !(mmc->caps & MMC_CAP_NEEDS_POLL))
 		host->platdata->cd_setup(mmc, 0);
-out_clk:
+
 	clk_disable_unprepare(host->clk);
+out_clk:
 	clk_put(host->clk);
 out_irq:
 	free_irq(host->irq, host);
-- 
2.34.1

