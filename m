Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379E3C43217
	for <linux-kernel@archiver.kernel.org>; Sat,  7 May 2022 22:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbiEGWuq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 May 2022 18:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiEGWuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 18:50:44 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F4F1EC42;
        Sat,  7 May 2022 15:46:56 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A96463F612;
        Sun,  8 May 2022 00:46:54 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sm6350: Replace literal rpmpd indices with constants
Date:   Sun,  8 May 2022 00:46:45 +0200
Message-Id: <20220507224645.2238421-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the SM6350_CX definition was temporarily replaced with its
literal value 0 in 1797e1c9a95c ("arm64: dts: qcom: sm6350: Add SDHCI1/2
nodes") to prevent a dependency on the qcom-rpmpd.h header patch being
available prior to this DT patch being applied, similar to c23f1b77358c
("arm64: dts: qcom: sm6125: Avoid using missing SM6125_VDDCX").
However, unlike the revert of that in the sm6125 tree the next merge
window around in a90b8adfa2dd ("Revert "arm64: dts: qcom: sm6125: Avoid
using missing SM6125_VDDCX""), this has not yet happened for sm6350:
replace them back now that the definitions are definitely available.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index fb1a0f662575..b3160720edcb 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -489,7 +489,7 @@ sdhc_1: sdhci@7c4000 {
 			clock-names = "iface", "core", "xo";
 			qcom,dll-config = <0x000f642c>;
 			qcom,ddr-config = <0x80040868>;
-			power-domains = <&rpmhpd 0>;
+			power-domains = <&rpmhpd SM6350_CX>;
 			operating-points-v2 = <&sdhc1_opp_table>;
 			bus-width = <8>;
 			non-removable;
@@ -935,7 +935,7 @@ sdhc_2: sdhci@8804000 {
 			clock-names = "iface", "core", "xo";
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040868>;
-			power-domains = <&rpmhpd 0>;
+			power-domains = <&rpmhpd SM6350_CX>;
 			operating-points-v2 = <&sdhc2_opp_table>;
 			bus-width = <4>;
 
-- 
2.36.0

