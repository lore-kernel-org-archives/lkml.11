Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8FDC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Jul 2022 16:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbiGCQJy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Jul 2022 12:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiGCQJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 12:09:51 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FA460F0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 09:09:50 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 82ANo4WMq5ohR82ANo6E2q; Sun, 03 Jul 2022 18:09:48 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 03 Jul 2022 18:09:48 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: nand: bbt: Use the bitmap API to allocate bitmaps
Date:   Sun,  3 Jul 2022 18:09:45 +0200
Message-Id: <b18c2b6711b8930f0dfb8318b5d19ef6e41f0f9a.1656864573.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mtd/nand/bbt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/bbt.c b/drivers/mtd/nand/bbt.c
index 64af6898131d..db4f93a903e4 100644
--- a/drivers/mtd/nand/bbt.c
+++ b/drivers/mtd/nand/bbt.c
@@ -24,11 +24,8 @@ int nanddev_bbt_init(struct nand_device *nand)
 {
 	unsigned int bits_per_block = fls(NAND_BBT_BLOCK_NUM_STATUS);
 	unsigned int nblocks = nanddev_neraseblocks(nand);
-	unsigned int nwords = DIV_ROUND_UP(nblocks * bits_per_block,
-					   BITS_PER_LONG);
 
-	nand->bbt.cache = kcalloc(nwords, sizeof(*nand->bbt.cache),
-				  GFP_KERNEL);
+	nand->bbt.cache = bitmap_zalloc(nblocks * bits_per_block, GFP_KERNEL);
 	if (!nand->bbt.cache)
 		return -ENOMEM;
 
@@ -44,7 +41,7 @@ EXPORT_SYMBOL_GPL(nanddev_bbt_init);
  */
 void nanddev_bbt_cleanup(struct nand_device *nand)
 {
-	kfree(nand->bbt.cache);
+	bitmap_free(nand->bbt.cache);
 }
 EXPORT_SYMBOL_GPL(nanddev_bbt_cleanup);
 
-- 
2.34.1

