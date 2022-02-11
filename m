Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87A8C43217
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 14:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350381AbiBKO4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Feb 2022 09:56:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351141AbiBKO4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:56:02 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C77F26D;
        Fri, 11 Feb 2022 06:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644591359; x=1676127359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=x8kCVH9lmzPkbkPirgSPb/qdJ0SRmbA8XalqtE/YsF8=;
  b=hRsc2XmtE+vhcdZcKbO2NdnN8QiXvu9EXlHFR6AUp4W70STgGktaqnfx
   CqtoTtGn01P/L7MkfAqjxhnxR5EmKpnYB3qpKaQBzu904gdL4q1U4jV9j
   MsKXwkQDBxZx2/mWcyG7L84mJSzjrjHFlphj27ViLxNxrFRPxYO7wnNlF
   o=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Feb 2022 06:55:59 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 06:55:58 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Feb 2022 06:55:58 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 11 Feb 2022 06:55:54 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [RESEND v3 2/2] arm64: dts: qcom: sc7280: add lpass lpi pin controller node
Date:   Fri, 11 Feb 2022 20:25:05 +0530
Message-ID: <1644591305-6235-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644591305-6235-1-git-send-email-quic_srivasam@quicinc.com>
References: <1644591305-6235-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LPASS LPI pinctrl node required for Audio functionality on sc7280
based platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 147 +++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 99d4ce2..daae5bc 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -1757,6 +1757,153 @@
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		lpass_tlmm: pinctrl@33c0000 {
+			compatible = "qcom,sc7280-lpass-lpi-pinctrl";
+			reg = <0 0x33c0000 0x0 0x20000>,
+				<0 0x3550000 0x0 0x10000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&lpass_tlmm 0 0 15>;
+
+			#clock-cells = <1>;
+
+			dmic01_active: dmic01-active {
+				clk {
+					pins = "gpio6";
+					function = "dmic1_clk";
+					drive-strength = <8>;
+					output-high;
+				};
+
+				data {
+					pins = "gpio7";
+					function = "dmic1_data";
+					drive-strength = <8>;
+				};
+			};
+
+			dmic01_sleep: dmic01-sleep {
+				clk {
+					pins = "gpio6";
+					function = "dmic1_clk";
+					drive-strength = <2>;
+					bias-disable;
+					output-low;
+				};
+
+				data {
+					pins = "gpio7";
+					function = "dmic1_data";
+					drive-strength = <2>;
+					pull-down;
+				};
+			};
+
+			dmic23_active: dmic02-active {
+				clk {
+					pins = "gpio8";
+					function = "dmic2_clk";
+					drive-strength = <8>;
+					output-high;
+				};
+
+				data {
+					pins = "gpio9";
+					function = "dmic2_data";
+					drive-strength = <8>;
+				};
+			};
+
+			dmic23_sleep: dmic02-sleep {
+				clk {
+					pins = "gpio8";
+					function = "dmic2_clk";
+					drive-strength = <2>;
+					bias-disable;
+					output-low;
+				};
+
+				data {
+					pins = "gpio9";
+					function = "dmic2_data";
+					drive-strength = <2>;
+					pull-down;
+				};
+			};
+
+			rx_swr_active: rx-swr-active {
+				clk {
+					pins = "gpio3";
+					function = "swr_rx_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data {
+					pins = "gpio4", "gpio5";
+					function = "swr_rx_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+				};
+			};
+
+			rx_swr_sleep: rx-swr-sleep {
+				clk {
+					pins = "gpio3";
+					function = "swr_rx_clk";
+					drive-strength = <2>;
+					input-enable;
+					bias-pull-down;
+				};
+
+				data {
+					pins = "gpio4", "gpio5";
+					function = "swr_rx_data";
+					drive-strength = <2>;
+					input-enable;
+					bias-pull-down;
+				};
+			};
+
+			tx_swr_active: tx-swr-active {
+				clk {
+					pins = "gpio0";
+					function = "swr_tx_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data {
+					pins = "gpio1", "gpio2", "gpio14";
+					function = "swr_tx_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+				};
+			};
+
+			tx_swr_sleep: tx-swr-sleep {
+				clk {
+					pins = "gpio0";
+					function = "swr_tx_clk";
+					drive-strength = <2>;
+					input-enable;
+					bias-pull-down;
+				};
+
+				data {
+					pins = "gpio1", "gpio2", "gpio14";
+					function = "swr_tx_data";
+					drive-strength = <2>;
+					input-enable;
+					bias-bus-hold;
+				};
+			};
+		};
+
 		gpu: gpu@3d00000 {
 			compatible = "qcom,adreno-635.0", "qcom,adreno";
 			reg = <0 0x03d00000 0 0x40000>,
-- 
2.7.4

