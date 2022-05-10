Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0041C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 11:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241282AbiEJL6L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 07:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241270AbiEJLz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:55:58 -0400
Received: from smtp122.ord1d.emailsrvr.com (smtp122.ord1d.emailsrvr.com [184.106.54.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2F326FA56
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1652183518;
        bh=LRMSZmaGPaBfd7950AFVlNtMBAPXjgWJaXpjj29Ai5U=;
        h=From:To:Subject:Date:From;
        b=hjjZRaCVYqCrcTxrmr0JO+qG1DtDrN/lX8a55DVZZE3Zm8ztaXsTjNzlFF1f+5jSD
         5fcXmXYUXyLUoZ2NbkV7Z3BA1yH6yzlA0BT11ERT1iiyf7DcKlHYusSCyv7KdFGr5G
         nP8YgXAsWBw243Ip57rYgyo5yGiH/9YmqoIuEX5E=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp8.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id CC93AC00B5;
        Tue, 10 May 2022 07:51:57 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 1/2] spi: cadence-quadspi: Add missing blank line in cqspi_request_mmap_dma()
Date:   Tue, 10 May 2022 12:51:40 +0100
Message-Id: <20220510115141.212779-2-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510115141.212779-1-abbotti@mev.co.uk>
References: <20220510115141.212779-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: b75da69c-0230-413e-8e5d-188bceb56f6b-2-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "WARNING: Missing a blank line after declarations" reported by
checkpatch.pl.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/spi/spi-cadence-quadspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 30307392c75a..9915704eaf06 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1481,6 +1481,7 @@ static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
 	cqspi->rx_chan = dma_request_chan_by_mask(&mask);
 	if (IS_ERR(cqspi->rx_chan)) {
 		int ret = PTR_ERR(cqspi->rx_chan);
+
 		cqspi->rx_chan = NULL;
 		return dev_err_probe(&cqspi->pdev->dev, ret, "No Rx DMA available\n");
 	}
-- 
2.35.1

