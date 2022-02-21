Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42253C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 12:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357579AbiBUMKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 07:10:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357301AbiBUMIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:08:54 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F2B201B9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:08:30 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A94092245C;
        Mon, 21 Feb 2022 13:08:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645445308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+etW7jzC7OWPI2fMPjfRTOpJ5DdDj/wXEqI0+Wud4xs=;
        b=uh8hBx0ikTe7+OSBt58HDvOpjRz7vJfwfGjJdyt5YVAUTn3+jlUYxLZDwWT5XgTw49qaBO
        FPmPQHmnM3pGKhEZxf1L61Q/ILYMcQ+1XvF9fgJwzUFwKcF7CyW3PLASf3V8cJ0AW5Y2gO
        SaZ2xFCW3LcQNy3sLBWQLeUyKhxCtqM=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v4 23/32] mtd: spi-nor: xilinx: correct the debug message
Date:   Mon, 21 Feb 2022 13:08:00 +0100
Message-Id: <20220221120809.1531502-24-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221120809.1531502-1-michael@walle.cc>
References: <20220221120809.1531502-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XRDSR is a combination of xilinx and the RDSR opcode, but the register
is just the status register. Correct the debug message.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
index ffd5579d45cb..9459ac2609dc 100644
--- a/drivers/mtd/spi-nor/xilinx.c
+++ b/drivers/mtd/spi-nor/xilinx.c
@@ -87,7 +87,7 @@ static int xilinx_nor_read_sr(struct spi_nor *nor, u8 *sr)
 	}
 
 	if (ret)
-		dev_dbg(nor->dev, "error %d reading XRDSR\n", ret);
+		dev_dbg(nor->dev, "error %d reading SR\n", ret);
 
 	return ret;
 }
-- 
2.30.2

