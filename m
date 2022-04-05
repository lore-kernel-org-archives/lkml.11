Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5673C35295
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355901AbiDEMJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 08:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244639AbiDEIw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:52:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0122609;
        Tue,  5 Apr 2022 01:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9121060FFB;
        Tue,  5 Apr 2022 08:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03BEC385A1;
        Tue,  5 Apr 2022 08:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148097;
        bh=Kz1byvTD0NJ9nT3np/9/Igd+t/G2GR+z4MqYHVKyA7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1X0uXMryzeKd1v4NnpiFhcw4wxcA3CUyu8FEOZfBHq1cd0SkxR+vrruxA13nuoHt6
         lS4juTjl7tYid7T4OMRP62fikLB1Y66mFTe4raZbvbkJiDnUSdCDNU5F/vnkB6HrRK
         DS8zT7l3vZjubesNDmGoM1RlxOczDaor6YQGEV98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0234/1017] spi: spi-zynqmp-gqspi: Handle error for dma_set_mask
Date:   Tue,  5 Apr 2022 09:19:07 +0200
Message-Id: <20220405070401.201329643@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit 13262fc26c1837c51a5131dbbdd67a2387f8bfc7 ]

As the potential failure of the dma_set_mask(),
it should be better to check it and return error
if fails.

Fixes: 126bdb606fd2 ("spi: spi-zynqmp-gqspi: return -ENOMEM if dma_map_single fails")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Link: https://lore.kernel.org/r/20220302092051.121343-1-jiasheng@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-zynqmp-gqspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 328b6559bb19..2b5afae8ff7f 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1172,7 +1172,10 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 
-	dma_set_mask(&pdev->dev, DMA_BIT_MASK(44));
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(44));
+	if (ret)
+		goto clk_dis_all;
+
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->num_chipselect = GQSPI_DEFAULT_NUM_CS;
 	ctlr->mem_ops = &zynqmp_qspi_mem_ops;
-- 
2.34.1



