Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF7AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 08:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345679AbiBUIyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 03:54:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345670AbiBUIxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:53:23 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FBD1A380
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:52:53 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D255B223F7;
        Mon, 21 Feb 2022 09:52:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645433569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rn1oW6aFXizxZtpF4apAEA9nQ0euOpxJBqkTidXgq28=;
        b=uq62Qq/VneKwFgfUkU1yD6pqdEORrV1Wysny2H5Cp8L1rWgfW56FRh/2eBhsG41AXmvExP
        4aHLqHYqcV/DsTBNK8z0UAqektt+rAdC0jQoNd3i5rb2PaDHEufbxKvUrTpuTprlNKdjTe
        bwga6usGUwUDaEEnHEabknoX0YXf680=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v3 06/32] mtd: spi-nor: fujitsu: unify function names
Date:   Mon, 21 Feb 2022 09:52:10 +0100
Message-Id: <20220221085236.1452024-7-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221085236.1452024-1-michael@walle.cc>
References: <20220221085236.1452024-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid name clashes unify all the function and static object names and
use one of the following prefixes which should be sufficiently unique:
 - <vendor>_nor_
 - <flash_family>_nor_
 - <flash_part>_

There are no functional changes.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/fujitsu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/fujitsu.c b/drivers/mtd/spi-nor/fujitsu.c
index 5fa8f04f2e35..69cffc5c73ef 100644
--- a/drivers/mtd/spi-nor/fujitsu.c
+++ b/drivers/mtd/spi-nor/fujitsu.c
@@ -8,7 +8,7 @@
 
 #include "core.h"
 
-static const struct flash_info fujitsu_parts[] = {
+static const struct flash_info fujitsu_nor_parts[] = {
 	/* Fujitsu */
 	{ "mb85rs1mt", INFO(0x047f27, 0, 128 * 1024, 1)
 		FLAGS(SPI_NOR_NO_ERASE) },
@@ -16,6 +16,6 @@ static const struct flash_info fujitsu_parts[] = {
 
 const struct spi_nor_manufacturer spi_nor_fujitsu = {
 	.name = "fujitsu",
-	.parts = fujitsu_parts,
-	.nparts = ARRAY_SIZE(fujitsu_parts),
+	.parts = fujitsu_nor_parts,
+	.nparts = ARRAY_SIZE(fujitsu_nor_parts),
 };
-- 
2.30.2

