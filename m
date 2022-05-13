Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EC6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 13:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355744AbiEMNiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 09:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381350AbiEMNfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:35:32 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4753A614D
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:35:30 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 62C1822249;
        Fri, 13 May 2022 15:35:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1652448928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MRhm9+AKqiCcFzEMtgbAPpFPGlNCeXLEsZ2HWJ7ms0c=;
        b=ZhTR67jMRyktCADJBzMCgBxZXj5Y48+NC4yRJ2e+cLkHVKej8MxqnREkz56Kx/05gT3slt
        shj3wLY+wp3CwbGtPvULuvDRGPXlnntCSem8E5uTc/o/w2jVA4DScBmhSui79amE1ZeOHH
        nqyem7xqbK3UCQ9qct/bCAF0zhKN3cQ=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH 2/6] mtd: spi-nor: sysfs: hide manufacturer if it is not set
Date:   Fri, 13 May 2022 15:35:16 +0200
Message-Id: <20220513133520.3945820-3-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513133520.3945820-1-michael@walle.cc>
References: <20220513133520.3945820-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The manufacturer may be optional when pure SFDP flashes are supported.
Hide the sysfs property if no manufacturer is set.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor | 3 +++
 drivers/mtd/spi-nor/sysfs.c                             | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
index e9ef69aef20b..c800621eff95 100644
--- a/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
+++ b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
@@ -15,6 +15,9 @@ KernelVersion:	5.14
 Contact:	linux-mtd@lists.infradead.org
 Description:	(RO) Manufacturer of the SPI NOR flash.
 
+		The attribute is not present if the flash device isn't
+		known to the kernel and is only probed by its SFDP
+		tables.
 
 What:		/sys/bus/spi/devices/.../spi-nor/partname
 Date:		April 2021
diff --git a/drivers/mtd/spi-nor/sysfs.c b/drivers/mtd/spi-nor/sysfs.c
index 4c3b351aef24..20563c1926f4 100644
--- a/drivers/mtd/spi-nor/sysfs.c
+++ b/drivers/mtd/spi-nor/sysfs.c
@@ -74,6 +74,8 @@ static umode_t spi_nor_sysfs_is_visible(struct kobject *kobj,
 	struct spi_mem *spimem = spi_get_drvdata(spi);
 	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
 
+	if (attr == &dev_attr_manufacturer.attr && !nor->manufacturer)
+		return 0;
 	if (attr == &dev_attr_jedec_id.attr && !nor->info->id_len)
 		return 0;
 
-- 
2.30.2

