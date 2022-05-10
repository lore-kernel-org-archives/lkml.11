Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DC1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 15:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346012AbiEJPgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 11:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345860AbiEJPfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:35:07 -0400
Received: from mail-m17638.qiye.163.com (mail-m17638.qiye.163.com [59.111.176.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B018B87A;
        Tue, 10 May 2022 08:30:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.23.13.247])
        by mail-m17638.qiye.163.com (Hmail) with ESMTPA id 9EAEE1C03D5;
        Tue, 10 May 2022 23:30:22 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 1/1] arm64: dts: allwinner: h6: Enable CPU opp tables for OrangePi One Plus
Date:   Tue, 10 May 2022 23:30:06 +0800
Message-Id: <20220510153006.279233-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510153006.279233-1-amadeus@jmu.edu.cn>
References: <20220510153006.279233-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRpOGE5WSU0aHxpDSEwaSE
        lJVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjI6SAw5Kz02PlEqNxQDDUxO
        DAgaCU9VSlVKTU5JSkJNTUlISk5KVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
        VUlIVUpIVUlPTFlXWQgBWUFJTUpCNwY+
X-HM-Tid: 0a80ae97c1fdd993kuws9eaee1c03d5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CPU opp tables for OrangePi One Plus.

This needs to change the CPU regulator max voltage to fit
the OPP table.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index 92745128fcfe..7773c51438ce 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -5,6 +5,7 @@
 /dts-v1/;
 
 #include "sun50i-h6.dtsi"
+#include "sun50i-h6-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
@@ -64,6 +65,10 @@ reg_vcc5v: vcc5v {
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &de {
 	status = "okay";
 };
@@ -208,7 +213,7 @@ reg_cldo3: cldo3 {
 			reg_dcdca: dcdca {
 				regulator-always-on;
 				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
+				regulator-max-microvolt = <1160000>;
 				regulator-name = "vdd-cpu";
 			};
 
-- 
2.25.1

