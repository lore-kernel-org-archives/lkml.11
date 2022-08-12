Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA19C2BB45
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Aug 2022 17:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbiHLRgP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Aug 2022 13:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239551AbiHLRfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:35:39 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31896C753;
        Fri, 12 Aug 2022 10:35:37 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1oMYZG-00FqKk-9G; Fri, 12 Aug 2022 17:35:30 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 2/6] arm64: dts: imx8mp-venice-gw74xx: remove invalid and unused pinctrl_sai2
Date:   Fri, 12 Aug 2022 10:35:22 -0700
Message-Id: <20220812173526.15537-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812173526.15537-1-tharvey@gateworks.com>
References: <20220812173526.15537-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pinctrl_sai2 is not yet used and not properly defined - remove it to
avoid:
imx8mp-pinctrl 30330000.pinctrl: Invalid fsl,pins or pins propert
y in node /soc@0/bus@30000000/pinctrl@30330000/sai2grp

Fixes: 7899eb6cb15d ("arm64: dts: imx: Add i.MX8M Plus Gateworks gw7400 dts
support")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index de17021df53f..80f0f1aafdbf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -768,15 +768,6 @@ MX8MP_IOMUXC_NAND_DATA03__GPIO3_IO09	0x110
 		>;
 	};
 
-	pinctrl_sai2: sai2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC
-			MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00
-			MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK
-			MX8MP_IOMUXC_SAI2_MCLK__AUDIOMIX_SAI2_MCLK
-		>;
-	};
-
 	pinctrl_spi2: spi2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK	0x82
-- 
2.25.1

