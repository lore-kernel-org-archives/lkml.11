Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07695C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 16:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbiETQmB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 12:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351761AbiETQl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:41:58 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE01F179C03
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:41:46 -0700 (PDT)
Received: from pop-os.home ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id s5h8n8HpQgoLGs5h8nsi7u; Fri, 20 May 2022 18:41:44 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 20 May 2022 18:41:44 +0200
X-ME-IP: 86.243.180.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] mtd: rawnand: meson: Fix a potential double free issue
Date:   Fri, 20 May 2022 18:41:40 +0200
Message-Id: <ec15c358b8063f7c50ff4cd628cf0d2e14e43f49.1653064877.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When meson_nfc_nand_chip_cleanup() is called, it will call:
	meson_nfc_free_buffer(&meson_chip->nand);
	nand_cleanup(&meson_chip->nand);

nand_cleanup() in turn will call nand_detach() which calls the
.detach_chip() which is here meson_nand_detach_chip().

meson_nand_detach_chip() already calls meson_nfc_free_buffer(), so we
could double free some memory.

Fix it by removing the unneeded explicit call to meson_nfc_free_buffer().

Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative, so review with care.
---
 drivers/mtd/nand/raw/meson_nand.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index ac3be92872d0..032180183339 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -1307,7 +1307,6 @@ static int meson_nfc_nand_chip_cleanup(struct meson_nfc *nfc)
 		if (ret)
 			return ret;
 
-		meson_nfc_free_buffer(&meson_chip->nand);
 		nand_cleanup(&meson_chip->nand);
 		list_del(&meson_chip->node);
 	}
-- 
2.34.1

