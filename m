Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1812C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 10:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbiERKSQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 06:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiERKSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:18:08 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF28DC5E77;
        Wed, 18 May 2022 03:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4TQRH
        C3LKR1FplyucHsj4yZYXJRNePwajQzUjdPa1gM=; b=QEgLea40nMEtaxQqLxBYc
        /N/1IACe8D8otPSpu2mFnk/A4p266kkM6lDnErLV0XljnnOx4NUg21sPzDaT80tD
        SWPMcBde1cWdkSu/YWsts/WUmOdP0SdnkNwvIrMqMr2xO7+5oC6p42rqXaPyeW1T
        tl7b0H6Cteqt5hWcgIbsh4=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.20])
        by smtp13 (Coremail) with SMTP id EcCowACXG6mlx4RimzKrDA--.63720S3;
        Wed, 18 May 2022 18:17:10 +0800 (CST)
From:   qianfanguijin@163.com
To:     linux-sunxi@lists.linux.dev
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Evgeny Boger <boger@wirenboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH v4 1/2] ARM: dts: sun8i-r40: Add USB0_OTG/HOST support
Date:   Wed, 18 May 2022 18:17:05 +0800
Message-Id: <20220518101706.26869-2-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518101706.26869-1-qianfanguijin@163.com>
References: <20220518101706.26869-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowACXG6mlx4RimzKrDA--.63720S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFy3Zr17try8Gr1kXr17Awb_yoW8Zr1Upa
        4j9rZ3t3yrWr1Sq3W3KFs5Jrn5J348Crs7Krn2y348Jrn2ga1qgFWxtF1SkFZ7Ww4UAw4a
        qFn3Gry3W3WDZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRa2N_UUUUU=
X-Originating-IP: [218.201.129.20]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiXAYF7VXl28m+uAAAsW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: qianfan Zhao <qianfanguijin@163.com>

The USB0 port of R40 is divided into two controllers, one is H3
compatibled MUSB device, another is OHCI/EHCI.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 212e19183484..ae48474fdefa 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -401,6 +401,21 @@ mmc3: mmc@1c12000 {
 			#size-cells = <0>;
 		};
 
+		usb_otg: usb@1c13000 {
+			compatible = "allwinner,sun8i-r40-musb",
+				     "allwinner,sun8i-h3-musb";
+			reg = <0x01c13000 0x0400>;
+			clocks = <&ccu CLK_BUS_OTG>;
+			resets = <&ccu RST_BUS_OTG>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mc";
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			extcon = <&usbphy 0>;
+			dr_mode = "otg";
+			status = "disabled";
+		};
+
 		usbphy: phy@1c13400 {
 			compatible = "allwinner,sun8i-r40-usb-phy";
 			reg = <0x01c13400 0x14>,
@@ -427,6 +442,25 @@ usbphy: phy@1c13400 {
 			#phy-cells = <1>;
 		};
 
+		ehci0: usb@1c14000 {
+			compatible = "allwinner,sun8i-r40-ehci", "generic-ehci";
+			reg = <0x01c14000 0x100>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_EHCI0>, <&ccu CLK_BUS_OHCI0>;
+			resets = <&ccu RST_BUS_EHCI0>, <&ccu RST_BUS_OHCI0>;
+			status = "disabled";
+		};
+
+		ohci0: usb@1c14400 {
+			compatible = "allwinner,sun8i-r40-ohci", "generic-ohci";
+			reg = <0x01c14400 0x100>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_EHCI0>, <&ccu CLK_BUS_OHCI0>,
+				 <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_EHCI0>, <&ccu RST_BUS_OHCI0>;
+			status = "disabled";
+		};
+
 		crypto: crypto@1c15000 {
 			compatible = "allwinner,sun8i-r40-crypto";
 			reg = <0x01c15000 0x1000>;
-- 
2.25.1

