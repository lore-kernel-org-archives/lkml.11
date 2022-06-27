Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9F5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 09:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiF0JRj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 05:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiF0JQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:16:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C826142;
        Mon, 27 Jun 2022 02:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656321412; x=1687857412;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ZfnjeGaTXA62WKjkc0ev0zGBTHlOx0/hvfL7GfyMNRA=;
  b=f+GPv5/SyNFumSAdnRTDmRj+MF3xKUMvt2d8mcAa0KE4nGfweBLYbSe8
   pf2Gv+OlNnX0CHQPjiJVAjsbpnt17YSWQNU9qeIlhB4hu6gJugtzCbG6m
   Sn7TPLPGgEB/kPAqK3jRBpEnj+N1Ds5xvgvv44mAZ2E8NZZHZfQdSio6n
   mmdVmXUihj8GWDE6DjC7kg+8ga4OSdKOQig35HXETbKhhettjSZDv11vP
   IplBU54W27RWKuRobllEDsa6mectaWfbhoUkb/YItGVEV3wQCBIrf7fTH
   8nFZXiLA3OCgOH++c6GCCmiJO2oP1MzRSqAJ4Ig9gK/PtGR7Ca7wszoIc
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="179631289"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jun 2022 02:16:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 27 Jun 2022 02:16:50 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 27 Jun 2022 02:16:47 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <arnd@arndb.de>, <alexandre.belloni@bootlin.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <soc@kernel.org>,
        <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH] ARM: dts: lan966x: Cleanup flexcom3 usart pinctrl settings.
Date:   Mon, 27 Jun 2022 14:42:17 +0530
Message-ID: <20220627091217.21701-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On pcb8291, Flexcom3 usart has only tx and rx pins.
Cleaningup usart3 pinctrl settings.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 arch/arm/boot/dts/lan966x-pcb8291.dts | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
index 3c7e3a7d6f14..5dc8ed4cee9a 100644
--- a/arch/arm/boot/dts/lan966x-pcb8291.dts
+++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
@@ -19,19 +19,13 @@
 };
 
 &gpio {
-	fc_shrd7_pins: fc_shrd7-pins {
-		pins = "GPIO_49";
-		function = "fc_shrd7";
-	};
-
-	fc_shrd8_pins: fc_shrd8-pins {
-		pins = "GPIO_54";
-		function = "fc_shrd8";
+	fc3_b_rxd_pins: fc3-b-rxd-pins {
+		pins = "GPIO_52";
+		function = "fc3_b";
 	};
 
-	fc3_b_pins: fcb3-spi-pins {
-		/* SCK, RXD, TXD */
-		pins = "GPIO_51", "GPIO_52", "GPIO_53";
+	fc3_b_txd_pins: fc3-b-txd-pins {
+		pins = "GPIO_53";
 		function = "fc3_b";
 	};
 
@@ -53,7 +47,7 @@
 	status = "okay";
 
 	usart3: serial@200 {
-		pinctrl-0 = <&fc3_b_pins>, <&fc_shrd7_pins>, <&fc_shrd8_pins>;
+		pinctrl-0 = <&fc3_b_rxd_pins>, <&fc3_b_txd_pins>;
 		pinctrl-names = "default";
 		status = "okay";
 	};
-- 
2.17.1

