Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66143C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 11:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiBRLhc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 06:37:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiBRLgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:36:40 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AAC2B0B09
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:36:23 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CDF4022453;
        Fri, 18 Feb 2022 12:36:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645184177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e5GfVMbBGWmdvXhXIoW+ggWd1G9vkp3A24ZAKD/FfOY=;
        b=STLkdrZwqV4ycL94P2bDWqeV/e8uQfyZ/vlcjqTYXR3mMh1TR+KzMzx2E7ydoBjWrJFDLU
        r73PV/KrpV6uyzPeWQHM61jFECRCYeLhX2GxNJHrJhm+BMbLXpKL9KTII5dcNhJ1S9WNI8
        K413aWqOGGIjuWAn9/tsi7iRExHEWd0=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v2 12/32] mtd: spi-nor: spansion: unify function names
Date:   Fri, 18 Feb 2022 12:35:47 +0100
Message-Id: <20220218113607.1360020-13-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220218113607.1360020-1-michael@walle.cc>
References: <20220218113607.1360020-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid name clashes unify all the function and static object names and
use one of the following prefixes which should be sufficiently unique:
 - <vendor>_nor_
 - <flash_family>_
 - <flash_part>_

There are no functional changes.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/spansion.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 534196b1d3e7..c57ee085e1ba 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -20,7 +20,7 @@
 #define SPINOR_OP_CYPRESS_RD_FAST		0xee
 
 /**
- * spi_nor_cypress_octal_dtr_enable() - Enable octal DTR on Cypress flashes.
+ * cypress_nor_octal_dtr_enable() - Enable octal DTR on Cypress flashes.
  * @nor:		pointer to a 'struct spi_nor'
  * @enable:              whether to enable or disable Octal DTR
  *
@@ -29,7 +29,7 @@
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
+static int cypress_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
 {
 	struct spi_mem_op op;
 	u8 *buf = nor->bouncebuf;
@@ -116,7 +116,7 @@ static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
 
 static void s28hs512t_default_init(struct spi_nor *nor)
 {
-	nor->params->octal_dtr_enable = spi_nor_cypress_octal_dtr_enable;
+	nor->params->octal_dtr_enable = cypress_nor_octal_dtr_enable;
 	nor->params->writesize = 16;
 }
 
@@ -202,7 +202,7 @@ static const struct spi_nor_fixups s25fs_s_fixups = {
 	.post_bfpt = s25fs_s_post_bfpt_fixups,
 };
 
-static const struct flash_info spansion_parts[] = {
+static const struct flash_info spansion_nor_parts[] = {
 	/* Spansion/Cypress -- single (large) sector size only, at least
 	 * for the chips listed here (without boot sectors).
 	 */
@@ -294,7 +294,7 @@ static const struct flash_info spansion_parts[] = {
 	},
 };
 
-static void spansion_late_init(struct spi_nor *nor)
+static void spansion_nor_late_init(struct spi_nor *nor)
 {
 	if (nor->params->size <= SZ_16M)
 		return;
@@ -305,13 +305,13 @@ static void spansion_late_init(struct spi_nor *nor)
 	nor->mtd.erasesize = nor->info->sector_size;
 }
 
-static const struct spi_nor_fixups spansion_fixups = {
-	.late_init = spansion_late_init,
+static const struct spi_nor_fixups spansion_nor_fixups = {
+	.late_init = spansion_nor_late_init,
 };
 
 const struct spi_nor_manufacturer spi_nor_spansion = {
 	.name = "spansion",
-	.parts = spansion_parts,
-	.nparts = ARRAY_SIZE(spansion_parts),
-	.fixups = &spansion_fixups,
+	.parts = spansion_nor_parts,
+	.nparts = ARRAY_SIZE(spansion_nor_parts),
+	.fixups = &spansion_nor_fixups,
 };
-- 
2.30.2

