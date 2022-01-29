Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2944AC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jan 2022 20:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353076AbiA2U0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jan 2022 15:26:37 -0500
Received: from mail.hugovil.com ([162.243.120.170]:57052 "EHLO
        mail.hugovil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiA2U0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 15:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nB+1Cg03XOHqlY3t8HBuf0gJTSR4wOsWdCqtLuMW07s=; b=SWvd/Oyc5QAnYl+K47OrCkd7b8
        WcVS0UE2zCnGmJPov1KNFmlhHU6j7PQuPi6s7siODdn6k+heeMlGchldUmqzXutFwOpHMhuxtRGxl
        fFaxxgUvGHA6A7WCt7tdwPZGnoKCItIbSiFD+kk4i9OLj6FLlMiIvNtjqoyeNqMXA3Lc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55112 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nDuIf-0005AC-7A; Sat, 29 Jan 2022 15:26:22 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     hugo@hugovil.com, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 29 Jan 2022 15:26:17 -0500
Message-Id: <20220129202617.2332885-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220129060818.GQ4686@dragon>
References: <20220129060818.GQ4686@dragon>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH v2] arm64: dts: imx8mp-evk: add PCA6416 interrupt controller mode
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add interrupt controller mode for the pca6416 on i.MX8MP EVK board's.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---

Rebased on tree: git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
         branch: for-next

 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 2eb943210678..9055ce32aecc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -294,6 +294,12 @@ pca6416: gpio@20 {
 		reg = <0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pca6416_int>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
@@ -448,6 +454,12 @@ MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03	0x000001c0
 		>;
 	};
 
+	pinctrl_pca6416_int: pca6416_int_grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x146 /* Input pull-up. */
+		>;
+	};
+
 	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x41
-- 
2.30.2

