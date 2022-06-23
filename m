Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93A7C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 10:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiFWKKQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 06:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiFWKKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:10:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E72049F15;
        Thu, 23 Jun 2022 03:10:06 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 467BA66017B4;
        Thu, 23 Jun 2022 11:10:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655979004;
        bh=CoBtqHoaJ3crvrFEw2/iijyoBgcPexhypiGbzCdpsQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kk6kNeH/ymNQtWIUdrryOOACFxxYI6sdBOrYPVwRB2Do2i6U6qxFK/zAb7sLRgJE9
         xUhM+HWCZJF0xcxUe7r7aMc5ro+MNopm0iE8+pE4jGfmkR75dOGq2Qwi8z3C4/kYFv
         Xb50jnDqvB+mbV605xxIvO3c9vPwscpIoWBXkU/JBRA9DnyB4YWLF58puDmG7WN3q1
         Jbf4RnjRTqegmU3BBxkTDTFpJj8I4ocDurd9xlPUdXmMw31kVzZ7uG4p8OyHDFx9my
         sPZjvweyKwmgqJg/xjPZLcJiOpSyiufF7xC4YTsY7iy5g1droDJBL95nOW+BnbGBx0
         8afLewG6QLrDA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/5] soc: mediatek: mt8183-pm-domains: Allow probing vreg supply on MFG_ASYNC
Date:   Thu, 23 Jun 2022 12:09:48 +0200
Message-Id: <20220623100951.21153-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220623100951.21153-1-angelogioacchino.delregno@collabora.com>
References: <20220623100951.21153-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the MTK_SCPD_DOMAIN_SUPPLY cap to the MFG_ASYNC power domain in
order to be able to vote for GPU-related regulators on/off.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mt8183-pm-domains.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mt8183-pm-domains.h b/drivers/soc/mediatek/mt8183-pm-domains.h
index 71b8757e552d..99de67fe5de8 100644
--- a/drivers/soc/mediatek/mt8183-pm-domains.h
+++ b/drivers/soc/mediatek/mt8183-pm-domains.h
@@ -41,6 +41,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = 0,
 		.sram_pdn_ack_bits = 0,
+		.caps = MTK_SCPD_DOMAIN_SUPPLY,
 	},
 	[MT8183_POWER_DOMAIN_MFG] = {
 		.name = "mfg",
-- 
2.35.1

