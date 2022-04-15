Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3ABC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 11:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353010AbiDOMAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 08:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352837AbiDOL7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:59:41 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CDDA9958
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 04:57:04 -0700 (PDT)
Received: from localhost.localdomain (abxj52.neoplus.adsl.tpnet.pl [83.9.3.52])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id C3E5D3F612;
        Fri, 15 Apr 2022 13:57:01 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/23] ARM: dts: qcom-msm8974pro: Use &labels
Date:   Fri, 15 Apr 2022 13:56:24 +0200
Message-Id: <20220415115633.575010-15-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415115633.575010-1-konrad.dybcio@somainline.org>
References: <20220415115633.575010-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use &labels to align with the style used in new DTS and apply tiny
style fixes.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm/boot/dts/qcom-msm8974pro.dtsi | 31 +++++++++++---------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974pro.dtsi b/arch/arm/boot/dts/qcom-msm8974pro.dtsi
index b64c28036dd0..973bd1dafbfe 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974pro.dtsi
@@ -1,23 +1,18 @@
 #include "qcom-msm8974.dtsi"
 
-/ {
-	soc {
-		sdhci@f9824900 {
-			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
-				 <&gcc GCC_SDCC1_AHB_CLK>,
-				 <&xo_board>,
-				 <&gcc GCC_SDCC1_CDCCAL_FF_CLK>,
-				 <&gcc GCC_SDCC1_CDCCAL_SLEEP_CLK>;
-			clock-names = "core", "iface", "xo", "cal", "sleep";
-		};
+&gcc {
+	compatible = "qcom,gcc-msm8974pro";
+};
 
-		clock-controller@fc400000 {
-				compatible = "qcom,gcc-msm8974pro";
-		};
+&gpu {
+	compatible = "qcom,adreno-330.2", "qcom,adreno";
+};
 
-		adreno@fdb00000 {
-			compatible = "qcom,adreno-330.2",
-				     "qcom,adreno";
-		};
-	};
+&sdhc_1 {
+	clocks = <&gcc GCC_SDCC1_APPS_CLK>,
+		 <&gcc GCC_SDCC1_AHB_CLK>,
+		 <&xo_board>,
+		 <&gcc GCC_SDCC1_CDCCAL_FF_CLK>,
+		 <&gcc GCC_SDCC1_CDCCAL_SLEEP_CLK>;
+	clock-names = "core", "iface", "xo", "cal", "sleep";
 };
-- 
2.35.2

