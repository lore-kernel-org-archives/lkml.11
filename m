Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B9FC00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 21:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349566AbiHOVl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 17:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348817AbiHOVhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:37:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7777B2634;
        Mon, 15 Aug 2022 12:27:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 110B160EF0;
        Mon, 15 Aug 2022 19:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA96C433D6;
        Mon, 15 Aug 2022 19:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660591638;
        bh=dNFBnbzURibeCT2P3eZZy7892rCSoDAp9zS8hNV0w5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZeug/TeByO1VSP7D9FdJ8Thld7QtTpcfb/T6jC1wZsWtHkggBasrgWQRS/qF+yIg
         7NIKPiZJu1nRd266bKenOOnLZcyFe3NMrOitOfGQ56ccxqyFPLb1iTRIzcTadUeoG+
         ta2L/zu0LhWcir2Zrvdndf+deO8WAZZWz3dYukAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 0644/1095] iio: dac: mcp4922: Fix alignment for DMA safety
Date:   Mon, 15 Aug 2022 20:00:43 +0200
Message-Id: <20220815180456.044796888@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180429.240518113@linuxfoundation.org>
References: <20220815180429.240518113@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit e66bf04797f1f95a2402414c00e64d00f63d31ec ]

____cacheline_aligned is an insufficient guarantee for non-coherent DMA
on platforms with 128 byte cachelines above L1.  Switch to the updated
IIO_DMA_MINALIGN definition.

Fixes: 1b791fadf3a1 ("iio: dac: mcp4902/mcp4912/mcp4922 dac driver")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Michael Welling <mwelling@ieee.org>
Link: https://lore.kernel.org/r/20220508175712.647246-61-jic23@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/dac/mcp4922.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
index cb9e60e71b91..6c0e31032c57 100644
--- a/drivers/iio/dac/mcp4922.c
+++ b/drivers/iio/dac/mcp4922.c
@@ -29,7 +29,7 @@ struct mcp4922_state {
 	unsigned int value[MCP4922_NUM_CHANNELS];
 	unsigned int vref_mv;
 	struct regulator *vref_reg;
-	u8 mosi[2] ____cacheline_aligned;
+	u8 mosi[2] __aligned(IIO_DMA_MINALIGN);
 };
 
 #define MCP4922_CHAN(chan, bits) {			\
-- 
2.35.1



