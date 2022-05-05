Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377D5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 13:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiEENrY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 09:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379894AbiEENrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:47:04 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBF657988;
        Thu,  5 May 2022 06:43:18 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 245DhDuQ122533;
        Thu, 5 May 2022 08:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651758193;
        bh=pQy8r4nSyp4/lSSZsHHCYvHBoz+cDyLXwl/nngd8tIo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Nm6Puk+1tY3VUjLZhgbK5X8k3qfhoR401QjFt6CnyxC9Mtv0+SpLr+NATsCgsaF9D
         +bV2u+kLXjqcyc9m7oOITtdNwKTEba47AySgkfzlYqzePqbCvm0BL976RtYhCnNa4p
         Z7mPV5tixy4qA2DI+GqGx1R4SXhF8nvyj76taswY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 245DhDAm062630
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 May 2022 08:43:13 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 5
 May 2022 08:43:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 5 May 2022 08:43:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 245DhAS7104725;
        Thu, 5 May 2022 08:43:11 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH v2 4/4] arm64: dts: ti: k3-am625-sk: Add DSS ports, HDMI tx & peripherals
Date:   Thu, 5 May 2022 19:13:03 +0530
Message-ID: <20220505134303.23208-5-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220505134303.23208-1-a-bhatia1@ti.com>
References: <20220505134303.23208-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT nodes for sil9022 HDMI transmitter (tx), HDMI connector and the
HDMI fixed master clock on the am625-sk board.

Additionally, add and connect output port for DSS (vp2), input and output
ports for the sil9022 HDMI tx and the input port for the HDMI connector.

The sil9022 HDMI tx is connected on the i2c1 bus. The HDMI connector on
the board is of type "a". The clock frequency of the master clock that
supports the HDMI tx is 12.288 MHz.

The dpi output signals from the vp2 of DSS are fed into the sil9022 HDMI
transmitter. These signals are converted into HDMI signals which are
further passed on to the HDMI connector on the board, on which display
can be connected via appropriate HDMI cables.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Reviewed-by: Rahul T R <r-ravikumar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 60 ++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 96414c5dacf7..e5b05223e9a1 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -134,6 +134,23 @@ led-0 {
 			default-state = "off";
 		};
 	};
+
+	hdmi_mstrclk: hdmi-mstrclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12288000>;
+	};
+
+	hdmi: connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&sii9022_out>;
+			};
+		};
+	};
 };
 
 &main_pmx0 {
@@ -385,6 +402,38 @@ exp1: gpio@22 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
 	};
+
+	sii9022: sii9022@3b {
+		compatible = "sil,sii9022";
+		reg = <0x3b>;
+
+		clocks = <&hdmi_mstrclk>;
+		clock-names = "mclk";
+
+		interrupt-parent = <&exp1>;
+		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				sii9022_in: endpoint {
+					remote-endpoint = <&dpi1_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				sii9022_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &main_i2c2 {
@@ -450,6 +499,17 @@ &dss {
 	pinctrl-0 = <&main_dss0_pins_default>;
 };
 
+&dss_ports {
+	/* VP2: DPI Output */
+	port@1 {
+		reg = <1>;
+
+		dpi1_out: endpoint {
+			remote-endpoint = <&sii9022_in>;
+		};
+	};
+};
+
 &mailbox0_cluster0 {
 	mbox_m4_0: mbox-m4-0 {
 		ti,mbox-rx = <0 0 0>;
-- 
2.36.0

