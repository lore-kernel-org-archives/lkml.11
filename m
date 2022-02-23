Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A55C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 13:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbiBWNp4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 08:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241080AbiBWNov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:44:51 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB366AC926
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:44:14 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2A15F223F0;
        Wed, 23 Feb 2022 14:44:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645623853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H5jDgKwJxZ6D3piaR2vguRJO+uJ6+EZP+5Pa5gMWIq8=;
        b=iY0lURYYi5YNHKZEvq3YSkw+pDUesfaIgrKnL+iSHocRWGwcJwLVQrGVweGrSPvOo/HARq
        OmnxNRv13UoqHUBfQpC81yO3bxtP0/Z2AkLUVLoY4YkSPb8pgrenWZ7tqoxOsfxoZ+QcMk
        CwaK5zr8ehogfYby3GqDyzk7ahsGLnY=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v5 20/32] mtd: spi-nor: guard _page_size parameter in S3AN_INFO()
Date:   Wed, 23 Feb 2022 14:43:46 +0100
Message-Id: <20220223134358.1914798-21-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220223134358.1914798-1-michael@walle.cc>
References: <20220223134358.1914798-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _page_size marco parameter was missing parentheses around it. Add
them.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 446218b0e017..3c37b46d60d5 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -469,9 +469,9 @@ struct flash_info {
 			(_jedec_id) & 0xff				\
 			},						\
 		.id_len = 3,						\
-		.sector_size = (8*_page_size),				\
+		.sector_size = (8 * (_page_size)),			\
 		.n_sectors = (_n_sectors),				\
-		.page_size = _page_size,				\
+		.page_size = (_page_size),				\
 		.addr_width = 3,					\
 		.flags = SPI_NOR_NO_FR | SPI_NOR_XSR_RDY,
 
-- 
2.30.2

