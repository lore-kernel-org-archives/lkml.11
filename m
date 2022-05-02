Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72C8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 22:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiEBWpv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 18:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350815AbiEBWpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:45:09 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B25CE09C;
        Mon,  2 May 2022 15:41:39 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9056222258;
        Tue,  3 May 2022 00:41:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651531297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WDeyz0LlR3w2vrF+SQ8eLPVhnHyoFLscpmzHcNbmj34=;
        b=XDW0x8j2GVHkofLH8ZiayccVc56nO0E1ZOf7HBcrYGOZuzmQkK3S5Is96QBdGaWRLbH08A
        C01YLwZOyt+me+wakYq9FvGuKxct7u9JBcBa6KZW80GEW9NMW2dRs2ZaQ9YHky5FGpL3Nj
        MbTHhI0vyr1f9xB3luZrEfV7s18MVbs=
From:   Michael Walle <michael@walle.cc>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor.Ambarus@microchip.com,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v4 09/13] ARM: dts: lan966x: add MIIM nodes
Date:   Tue,  3 May 2022 00:41:23 +0200
Message-Id: <20220502224127.2604333-10-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220502224127.2604333-1-michael@walle.cc>
References: <20220502224127.2604333-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the MDIO controller nodes. The integrated PHYs are connected to the
second controller. This controller also takes care of the resets of the
integrated PHYs, thus it has two memory regions. The first controller
is routed to the external MDIO/MDC pins.

By default, they are disabled.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/boot/dts/lan966x.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
index 64290fb43926..0442735910da 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -418,6 +418,37 @@ gpio: pinctrl@e2004064 {
 			#interrupt-cells = <2>;
 		};
 
+		mdio0: mdio@e2004118 {
+			compatible = "microchip,lan966x-miim";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xe2004118 0x24>;
+			clocks = <&sys_clk>;
+			status = "disabled";
+		};
+
+		mdio1: mdio@e200413c {
+			compatible = "microchip,lan966x-miim";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xe200413c 0x24>,
+			      <0xe2010020 0x4>;
+			clocks = <&sys_clk>;
+			status = "disabled";
+
+			phy0: ethernet-phy@1 {
+				reg = <1>;
+				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			phy1: ethernet-phy@2 {
+				reg = <2>;
+				interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+		};
+
 		sgpio: gpio@e2004190 {
 			compatible = "microchip,sparx5-sgpio";
 			reg = <0xe2004190 0x118>;
-- 
2.30.2

