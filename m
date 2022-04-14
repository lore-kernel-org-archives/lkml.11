Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8688FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 15:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbiDNPeP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 11:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245233AbiDNOIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:08:07 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACA38D689;
        Thu, 14 Apr 2022 07:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649944857; x=1681480857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=4dS3wy8SxaPfJ6KPRvcosGOBDu1pk2jmUrq2bCl6TEA=;
  b=x1Z4EhEk8RUTm6r2WpDL7jUt/xNEZVeTZDwt8kAO3yCdIAzMmvdGBKCz
   TEYX5LEukJZN1Ja7OeQyq66ivKBv3ow2SdZpLApmgUo2/4uYYHYEUxYYf
   ov53kbSfprdbSlIZNIM6vQ53lLnsqp9wEx/UODaK40TwtjJxqgiOO4lwR
   k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Apr 2022 07:00:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 07:00:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 07:00:55 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 07:00:51 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v10 1/2] arm64: dts: qcom: sc7280: Add pinmux for I2S speaker and Headset
Date:   Thu, 14 Apr 2022 19:30:26 +0530
Message-ID: <1649944827-6455-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649944827-6455-1-git-send-email-quic_srivasam@quicinc.com>
References: <1649944827-6455-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinmux nodes for primary and secondary I2S for SC7280 based platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 14 +++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 40 ++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 015a347..fb1f4ca 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -359,6 +359,20 @@
 	bias-disable;
 };
 
+&mi2s1_data0 {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s1_sclk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s1_ws {
+	drive-strength = <6>;
+};
+
 &pm7325_gpios {
 	key_vol_up_default: key-vol-up-default {
 		pins = "gpio6";
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index ebbf4a4..ccecf26e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3619,6 +3619,46 @@
 				function = "edp_hot";
 			};
 
+			mi2s0_data0: mi2s0-data0 {
+				pins = "gpio98";
+				function = "mi2s0_data0";
+			};
+
+			mi2s0_data1: mi2s0-data1 {
+				pins = "gpio99";
+				function = "mi2s0_data1";
+			};
+
+			mi2s0_mclk: mi2s0-mclk {
+				pins = "gpio96";
+				function = "pri_mi2s";
+			};
+
+			mi2s0_sclk: mi2s0-sclk {
+				pins = "gpio97";
+				function = "mi2s0_sck";
+			};
+
+			mi2s0_ws: mi2s0-ws {
+				pins = "gpio100";
+				function = "mi2s0_ws";
+			};
+
+			mi2s1_data0: mi2s1-data0 {
+				pins = "gpio107";
+				function = "mi2s1_data0";
+			};
+
+			mi2s1_sclk: mi2s1-sclk {
+				pins = "gpio106";
+				function = "mi2s1_sck";
+			};
+
+			mi2s1_ws: mi2s1-ws {
+				pins = "gpio108";
+				function = "mi2s1_ws";
+			};
+
 			pcie1_clkreq_n: pcie1-clkreq-n {
 				pins = "gpio79";
 				function = "pcie1_clkreqn";
-- 
2.7.4

