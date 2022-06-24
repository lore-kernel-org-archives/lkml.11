Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A91DC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 04:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiFXEjT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 00:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiFXEjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 00:39:18 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC40651598;
        Thu, 23 Jun 2022 21:39:17 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25O4d6qS068763;
        Thu, 23 Jun 2022 23:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1656045546;
        bh=Qr7kwL8JoQVm3lN/8hS8jovzJ7eb7o2KHm2DeVEvAWU=;
        h=From:To:CC:Subject:Date;
        b=Ta3MbIfGZIeJ9bSjXBbGrMG5kKQD0/UF6u6aKdCGmIKqzG+gHD6BGgGRSL38c4FL4
         Zt0lKkjRdqn+BE1LQvzD7l0tom+b0A3sWclizsulsE1XzuAHdh+uDOqDZxjWT7Cp1N
         xVAyXqoB71K1SEDr9Caj/++LYIaKpPrFOSd2AZ1k=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25O4d6qC023184
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jun 2022 23:39:06 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Jun 2022 23:39:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Jun 2022 23:39:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25O4d547018862;
        Thu, 23 Jun 2022 23:39:05 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <devicetree@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <j-choudhary@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arm64: dts: ti: k3-am62-main: Enable crypto accelerator
Date:   Fri, 24 Jun 2022 10:09:05 +0530
Message-ID: <20220624043905.129207-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the node for sa3ul crypto accelerator.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
On local testing, crypto self-tests and tcrypt tests were passing
for SHA256, SHA512, ECB-AES and CBC-AES algorithms.
RNG node has not been added due to the indirect access of the
hardware random number generator from OP-TEE.

Changelog v1->v2:
- Change the flag from TI_SCI_PD_EXCLUSIVE to TI_SCI_PD_SHARED
  since sa3ul hardware is also used by OP-TEE and so it should
  be requested using shared TI-SCI flag

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index df3b9883e887..8bb9cb5d4c1a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -165,6 +165,19 @@
 		};
 	};
 
+	crypto: crypto@40900000 {
+		compatible = "ti,am62-sa3ul";
+		reg = <0x00 0x40900000 0x00 0x1200>;
+		power-domains = <&k3_pds 70 TI_SCI_PD_SHARED>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
+
+		dmas = <&main_pktdma 0xf501 0>, <&main_pktdma 0x7506 0>,
+				<&main_pktdma 0x7507 0>;
+		dma-names = "tx", "rx1", "rx2";
+	};
+
 	main_pmx0: pinctrl@f4000 {
 		compatible = "pinctrl-single";
 		reg = <0x00 0xf4000 0x00 0x2ac>;
-- 
2.17.1

