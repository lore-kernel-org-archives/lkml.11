Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C46C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 21:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353605AbiETVVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 17:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346297AbiETVVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:21:07 -0400
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr [80.12.242.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A834A3DF
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:21:04 -0700 (PDT)
Received: from pop-os.home ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id sA3Pn0Q162ovCsA3PnypMs; Fri, 20 May 2022 23:21:02 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 20 May 2022 23:21:02 +0200
X-ME-IP: 86.243.180.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clk: bcm: rpi: Use correct order for the parameters of devm_kcalloc()
Date:   Fri, 20 May 2022 23:20:58 +0200
Message-Id: <49d726d11964ca0e3757bdb5659e3b3eaa1572b5.1653081643.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should have 'n', then 'size', not the opposite.
This is harmless because the 2 values are just multiplied, but having
the correct order silence a (unpublished yet) smatch warning.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clk/bcm/clk-raspberrypi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 9d09621549b9..73518009a0f2 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -345,7 +345,7 @@ static int raspberrypi_discover_clocks(struct raspberrypi_clk *rpi,
 	int ret;
 
 	clks = devm_kcalloc(rpi->dev,
-			    sizeof(*clks), RPI_FIRMWARE_NUM_CLK_ID,
+			    RPI_FIRMWARE_NUM_CLK_ID, sizeof(*clks),
 			    GFP_KERNEL);
 	if (!clks)
 		return -ENOMEM;
-- 
2.34.1

