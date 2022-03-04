Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB19EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 15:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240420AbiCDPhN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 10:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiCDPhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:37:06 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574741C60E2;
        Fri,  4 Mar 2022 07:36:19 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2049522247;
        Fri,  4 Mar 2022 16:36:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1646408177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2mmjz+Kg+zve+C9vJUel319BOl8L2+J2zRG93WOEoE=;
        b=eBF5ri9WplXjvZ++J5L2seyyC2gJlQA860VCgRmP2WLAbiY23uQj/Q2jmwLB5srT/Y6NZS
        Ua36XrALVU2oVkx0yec5AQdnmiHbUkBIUGmbVy/Hr7YxD7x8OzEhZW6GPVf1B/zQE/gzwX
        nBMHQTe8xzLGcbPnzkHupb4ujIdiXIU=
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
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 1/7] ARM: dts: lan966x: swap dma channels for crypto node
Date:   Fri,  4 Mar 2022 16:35:42 +0100
Message-Id: <20220304153548.3364480-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304153548.3364480-1-michael@walle.cc>
References: <20220304153548.3364480-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The YAML binding (crypto/atmel,at91sam9g46-aes.yaml) mandates the order
of the channels. Swap them to pass devicetree validation.

Fixes: 290deaa10c50 ("ARM: dts: add DT for lan966 SoC and 2-port board pcb8291")
Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/lan966x.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
index 7d2869648050..5e9cbc8cdcbc 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -114,9 +114,9 @@ aes: crypto@e004c000 {
 			compatible = "atmel,at91sam9g46-aes";
 			reg = <0xe004c000 0x100>;
 			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&dma0 AT91_XDMAC_DT_PERID(13)>,
-			       <&dma0 AT91_XDMAC_DT_PERID(12)>;
-			dma-names = "rx", "tx";
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(12)>,
+			       <&dma0 AT91_XDMAC_DT_PERID(13)>;
+			dma-names = "tx", "rx";
 			clocks = <&nic_clk>;
 			clock-names = "aes_clk";
 		};
-- 
2.30.2

