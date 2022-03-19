Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3349C4332F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Mar 2022 17:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243758AbiCSRsq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Mar 2022 13:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243741AbiCSRsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 13:48:35 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC9A2467E5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 10:47:11 -0700 (PDT)
Received: from localhost.localdomain (abxi119.neoplus.adsl.tpnet.pl [83.9.2.119])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 49D783ED8B;
        Sat, 19 Mar 2022 18:47:09 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] arm64: dts: qcom: msm8992: Use the correct MMCC compatible
Date:   Sat, 19 Mar 2022 18:46:37 +0100
Message-Id: <20220319174645.340379-8-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220319174645.340379-1-konrad.dybcio@somainline.org>
References: <20220319174645.340379-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that proper msm8992 support is in the driver, switch to
the new compatible.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/msm8992.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
index 1b175b7f1514..1de1d9c4643d 100644
--- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
@@ -14,6 +14,16 @@ &gcc {
 	compatible = "qcom,gcc-msm8992";
 };
 
+&mmcc {
+	compatible = "qcom,mmcc-msm8992";
+
+	assigned-clock-rates = <800000000>,
+			       <808000000>,
+			       <1020000000>,
+			       <960000000>,
+			       <800000000>;
+};
+
 &rpmcc {
 	compatible = "qcom,rpmcc-msm8992";
 };
-- 
2.35.1

