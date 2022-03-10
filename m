Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E406AC433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 14:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244538AbiCJO4U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 09:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347027AbiCJOu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:50:27 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC4118CC74;
        Thu, 10 Mar 2022 06:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646923529; x=1678459529;
  h=from:to:cc:subject:date:message-id;
  bh=YF2MjvNRHP7HzoRLkPlFoND+9ZHy/RpbA3JxeI0ULBI=;
  b=vC8fMdThiyEjzGOTdkI+nSTpv9bQyv2GoygVM6PPp4wVsjvhm2QeGWwm
   Xp3ZF5blX4ziQ+ChCZfsZThe2/uU/HkovzuGXSHUCNgOzCxdYHiHCnwit
   VC30Xtl/rBUFRojxpiQv1HodpdwiJe4Fx9GX+5J5xXW5c3b1ksTirO4jo
   M=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 10 Mar 2022 06:45:27 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Mar 2022 06:45:25 -0800
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 10 Mar 2022 20:15:06 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 3ED0F5913; Thu, 10 Mar 2022 20:15:05 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     krzk+dt@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_asutoshd@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V2] arm64: dts: qcom: sc7280: Enable gcc HW reset
Date:   Thu, 10 Mar 2022 20:15:03 +0530
Message-Id: <1646923503-28847-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable gcc HW reset for eMMC and SD card.

Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---

Changes since V1:
	- Updated commit message, subject and comments in dtsi file as
	  suggested by Krzysztof Kozlowski.
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index c07765d..721abf5 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -881,6 +881,9 @@
 			mmc-hs400-1_8v;
 			mmc-hs400-enhanced-strobe;
 
+			/* Add gcc hw reset dt entry for eMMC */
+			resets = <&gcc GCC_SDCC1_BCR>;
+			reset-names = "core_reset";
 			sdhc1_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
@@ -2686,6 +2689,9 @@
 
 			qcom,dll-config = <0x0007642c>;
 
+			/* Add gcc hw reset dt entry for SD card */
+			resets = <&gcc GCC_SDCC2_BCR>;
+			reset-names = "core_reset";
 			sdhc2_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

