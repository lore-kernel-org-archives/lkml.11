Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111B5C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 18:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242647AbiHOShm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 14:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244017AbiHOSgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:36:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6AB3C15B;
        Mon, 15 Aug 2022 11:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87F0EB81071;
        Mon, 15 Aug 2022 18:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5398C433C1;
        Mon, 15 Aug 2022 18:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660587786;
        bh=PYfW4qUNcV0ql8wYHgPWd/Nrk4am9nAFnFvDd23OFxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYQJGFI4InGsrqLZLWkkVEauqo4Q8hCXIcQatIxMq7xbCqH411lcuxyB4dSZ1pmqa
         bWhd99veAqatGPeV7OwGHqLcn3PlxJvgX4pdGumY/Q6gHJYK5AeifwSwff1z9WLI4J
         mGHW9JOGce+Bsh0QMubx8vUwSXExKhgJgiwvNBD0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 153/779] spi: spi-rspi: Fix PIO fallback on RZ platforms
Date:   Mon, 15 Aug 2022 19:56:37 +0200
Message-Id: <20220815180343.858223258@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180337.130757997@linuxfoundation.org>
References: <20220815180337.130757997@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit b620aa3a7be346f04ae7789b165937615c6ee8d3 ]

RSPI IP on RZ/{A, G2L} SoC's has the same signal for both interrupt
and DMA transfer request. Setting DMARS register for DMA transfer
makes the signal to work as a DMA transfer request signal and
subsequent interrupt requests to the interrupt controller
are masked.

PIO fallback does not work as interrupt signal is disabled.

This patch fixes this issue by re-enabling the interrupts by
calling dmaengine_synchronize().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20220721143449.879257-1-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-rspi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index d575c935e9f0..f634a405382c 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -612,6 +612,10 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 					       rspi->dma_callbacked, HZ);
 	if (ret > 0 && rspi->dma_callbacked) {
 		ret = 0;
+		if (tx)
+			dmaengine_synchronize(rspi->ctlr->dma_tx);
+		if (rx)
+			dmaengine_synchronize(rspi->ctlr->dma_rx);
 	} else {
 		if (!ret) {
 			dev_err(&rspi->ctlr->dev, "DMA timeout\n");
-- 
2.35.1



