Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA6CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 11:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353292AbiELLWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 May 2022 07:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353434AbiELLVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:21:17 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D69C243104
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:20:34 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 035B222249;
        Thu, 12 May 2022 13:20:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1652354432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=afkJX7Cvem/WO0jznzGUUKL5imd13N9V0sdXQ0gf+3Q=;
        b=oifvKZEFSeM1JFyaN/jJ/jlQXViRPnY/I6e4F50GXiltvpKQkZCIjDkwYpr/D500uwmlmX
        eryzl0s5NkWK9zPzZvBhcE8fsw4n3PuirvL9FqadMaFx/ILsefabG4J0ukxIBIsgkjcHJP
        QCKVd/IxHGZiQS+StBYBsFsHh6A2A0k=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mtd: spi-nor: debugfs: fix format specifier
Date:   Thu, 12 May 2022 13:20:27 +0200
Message-Id: <20220512112027.3771734-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intention was to print the JEDEC ID in the following format:
  nn nn nn

In this case format specifier has to be "%*ph". Fix it.

Fixes: 0257be79fc4a ("mtd: spi-nor: expose internal parameters via debugfs")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
index bf9fda5d4d0b..4b972bd4b80d 100644
--- a/drivers/mtd/spi-nor/debugfs.c
+++ b/drivers/mtd/spi-nor/debugfs.c
@@ -81,7 +81,7 @@ static int spi_nor_params_show(struct seq_file *s, void *data)
 	int i;
 
 	seq_printf(s, "name\t\t%s\n", info->name);
-	seq_printf(s, "id\t\t%*phn\n", SPI_NOR_MAX_ID_LEN, nor->id);
+	seq_printf(s, "id\t\t%*ph\n", SPI_NOR_MAX_ID_LEN, nor->id);
 	string_get_size(params->size, 1, STRING_UNITS_2, buf, sizeof(buf));
 	seq_printf(s, "size\t\t%s\n", buf);
 	seq_printf(s, "write size\t%u\n", params->writesize);
-- 
2.30.2

