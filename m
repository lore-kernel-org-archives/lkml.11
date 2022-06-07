Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0679FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 01:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350373AbiFHBOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383063AbiFGWFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:05:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E366195943;
        Tue,  7 Jun 2022 12:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF7A7618EC;
        Tue,  7 Jun 2022 19:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED0DC385A2;
        Tue,  7 Jun 2022 19:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654629383;
        bh=ezIWh8hccCcDbpXP8PsD5HOqPX41+iBX/icva8GXBPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dTd6y6/DSFku9vWyIZMwpKTdSWuaaccyB6YV2+v510G/FrbeV1JKT4En/6lVy7ttg
         sYhdaFpPcIO1NAZhLTHQy6oiRjsy7YlFgElG6pePYUPdD7gtNzqXFQGcpBey5vYxbc
         4+5mN2S4ain2hPHXoELEkWIoclP7MHjNPikUNaEg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 634/879] hwrng: omap3-rom - fix using wrong clk_disable() in omap_rom_rng_runtime_resume()
Date:   Tue,  7 Jun 2022 19:02:32 +0200
Message-Id: <20220607165021.250193926@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607165002.659942637@linuxfoundation.org>
References: <20220607165002.659942637@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit e4e62bbc6aba49a5edb3156ec65f6698ff37d228 ]

'ddata->clk' is enabled by clk_prepare_enable(), it should be disabled
by clk_disable_unprepare().

Fixes: 8d9d4bdc495f ("hwrng: omap3-rom - Use runtime PM instead of custom functions")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/omap3-rom-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/omap3-rom-rng.c b/drivers/char/hw_random/omap3-rom-rng.c
index e0d77fa048fb..f06e4f95114f 100644
--- a/drivers/char/hw_random/omap3-rom-rng.c
+++ b/drivers/char/hw_random/omap3-rom-rng.c
@@ -92,7 +92,7 @@ static int __maybe_unused omap_rom_rng_runtime_resume(struct device *dev)
 
 	r = ddata->rom_rng_call(0, 0, RNG_GEN_PRNG_HW_INIT);
 	if (r != 0) {
-		clk_disable(ddata->clk);
+		clk_disable_unprepare(ddata->clk);
 		dev_err(dev, "HW init failed: %d\n", r);
 
 		return -EIO;
-- 
2.35.1



