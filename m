Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C2AC25B0D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 04:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiHPEbz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 00:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiHPEbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 00:31:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4714416658C;
        Mon, 15 Aug 2022 13:22:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 530F76108F;
        Mon, 15 Aug 2022 20:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4405DC433C1;
        Mon, 15 Aug 2022 20:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660594971;
        bh=xL5a/gAxJH4uFQYlVestcdxCd6X4ul2rdgS4aszoXTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wd+Vx8c8RugAkywiyzYfNGmill+LN7O6nNiz1icso0hLhgniCQHWwOZVEkIquqpfh
         7OwgCBRt0zgigD5Pmj+kXe5Pd1M571zjproJvv3eAjdugLrYflAIDthFXzImOsrQAC
         kNuTiWoQBimvIcPdh+ctAvx6sl8R7BPkRBAma88c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.19 0615/1157] dmaengine: dw: dmamux: Export the module device table
Date:   Mon, 15 Aug 2022 19:59:31 +0200
Message-Id: <20220815180504.255234231@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180439.416659447@linuxfoundation.org>
References: <20220815180439.416659447@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 2717d33841957a0f5fb65fd8b37f9c2321593864 ]

This is a tristate driver that can be built as a module, as a result,
the OF match table should be exported with MODULE_DEVICE_TABLE().

Fixes: 134d9c52fca2 ("dmaengine: dw: dmamux: Introduce RZN1 DMA router support")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20220609141455.300879-1-miquel.raynal@bootlin.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dw/rzn1-dmamux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/dw/rzn1-dmamux.c b/drivers/dma/dw/rzn1-dmamux.c
index 11d254e450b0..0ce4fb58185e 100644
--- a/drivers/dma/dw/rzn1-dmamux.c
+++ b/drivers/dma/dw/rzn1-dmamux.c
@@ -140,6 +140,7 @@ static const struct of_device_id rzn1_dmamux_match[] = {
 	{ .compatible = "renesas,rzn1-dmamux" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, rzn1_dmamux_match);
 
 static struct platform_driver rzn1_dmamux_driver = {
 	.driver = {
-- 
2.35.1



