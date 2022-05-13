Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DF5C43217
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 13:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381603AbiEMNiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 09:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381356AbiEMNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:35:35 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA67263B8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:35:33 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id AD66022253;
        Fri, 13 May 2022 15:35:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1652448929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7SVQYJZn3MFW22DboTz0AGRIBdFV6caUuIlQOpfVNEM=;
        b=OqgVcIKS9cWpiQSb6R55BgLtStx6Yx9vXWnqlEsYfTEm5DYWcLaRCzLRvv6cTYbrhFCvng
        hy7n5II+ilnbm8VrXTtcrzWBghu5e5J3dj/HsoXNSZVFJhDTZlnjfSjjnU8vQyHb86QlCg
        HlOfx8oSH8wmt9CvAPSNdXx5046yqXw=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH 6/6] mtd: spi-nor: sysfs: print JEDEC ID for generic flash driver
Date:   Fri, 13 May 2022 15:35:20 +0200
Message-Id: <20220513133520.3945820-7-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513133520.3945820-1-michael@walle.cc>
References: <20220513133520.3945820-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't have a database entry for the generic SPI-NOR flash driver and
thus we don't have a JEDEC ID to print. Print the (cached) JEDEC ID
instead.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/sysfs.c b/drivers/mtd/spi-nor/sysfs.c
index 20563c1926f4..c09bb832b3b9 100644
--- a/drivers/mtd/spi-nor/sysfs.c
+++ b/drivers/mtd/spi-nor/sysfs.c
@@ -35,8 +35,10 @@ static ssize_t jedec_id_show(struct device *dev,
 	struct spi_device *spi = to_spi_device(dev);
 	struct spi_mem *spimem = spi_get_drvdata(spi);
 	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
+	const u8 *id = nor->info->id_len ? nor->info->id : nor->id;
+	u8 id_len = nor->info->id_len ?: SPI_NOR_MAX_ID_LEN;
 
-	return sysfs_emit(buf, "%*phN\n", nor->info->id_len, nor->info->id);
+	return sysfs_emit(buf, "%*phN\n", id_len, id);
 }
 static DEVICE_ATTR_RO(jedec_id);
 
@@ -76,7 +78,7 @@ static umode_t spi_nor_sysfs_is_visible(struct kobject *kobj,
 
 	if (attr == &dev_attr_manufacturer.attr && !nor->manufacturer)
 		return 0;
-	if (attr == &dev_attr_jedec_id.attr && !nor->info->id_len)
+	if (attr == &dev_attr_jedec_id.attr && !nor->info->id_len && !nor->id)
 		return 0;
 
 	return 0444;
-- 
2.30.2

