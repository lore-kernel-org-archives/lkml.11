Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF45EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 11:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiBRLhm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 06:37:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiBRLgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:36:42 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C782B0B38
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:36:23 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3AD822245C;
        Fri, 18 Feb 2022 12:36:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645184179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/nRIForTo2KQPxd/AMOdX/ky4GDtYbolPskG8tcKSBY=;
        b=N5bD1JrYy18L4GsPMn13XuZjxttiF1LXN0Q/F1n9P8lcrgnYz9hbPgO/gND7TA+3HeC8Sw
        3LvKtjogVXa1G/dtorFAYfllVg89n4xtHV3HLRdQqp2CxkCnUO+dFesjQbcR71ELGZ1xbl
        6UcB9XOCOCem6NUSZDqmHbWO+Jm0+WU=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v2 16/32] mtd: spi-nor: xmc: unify function names
Date:   Fri, 18 Feb 2022 12:35:51 +0100
Message-Id: <20220218113607.1360020-17-michael@walle.cc>
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
 drivers/mtd/spi-nor/xmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
index 2992af03cb0a..051411e86339 100644
--- a/drivers/mtd/spi-nor/xmc.c
+++ b/drivers/mtd/spi-nor/xmc.c
@@ -8,7 +8,7 @@
 
 #include "core.h"
 
-static const struct flash_info xmc_parts[] = {
+static const struct flash_info xmc_nor_parts[] = {
 	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
 	{ "XM25QH64A", INFO(0x207017, 0, 64 * 1024, 128)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
@@ -20,6 +20,6 @@ static const struct flash_info xmc_parts[] = {
 
 const struct spi_nor_manufacturer spi_nor_xmc = {
 	.name = "xmc",
-	.parts = xmc_parts,
-	.nparts = ARRAY_SIZE(xmc_parts),
+	.parts = xmc_nor_parts,
+	.nparts = ARRAY_SIZE(xmc_nor_parts),
 };
-- 
2.30.2

