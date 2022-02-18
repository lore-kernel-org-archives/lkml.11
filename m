Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9E6C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 10:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbiBRKpf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 05:45:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbiBRKpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:45:32 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5352325AE46;
        Fri, 18 Feb 2022 02:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645181116; x=1676717116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=zW0AZsu39b4f+1YC4ZeAlYe6MISkArojOSGR+yvIKRg=;
  b=pEh7jZJi37JzU7USZrWd+hjmeTRNho0U/NU9NLKkq8ZMukkyEwIFa9Oy
   D98hKdUnA1C4Q0pelLAkGZrEurlaICjOgKyWkWya38zrreu4YMTc7qL0o
   HMh8Zn1Detb/s/uJJWZ4XPmKQmAMZ1z+6M7QA2H1LSUKHlMlDzxnrfXYY
   g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Feb 2022 02:45:15 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 02:45:15 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 18 Feb 2022 02:45:15 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 18 Feb 2022 02:45:11 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>, <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_rjendra@quicinc.com>,
        <quic_saipraka@quicinc.com>, <quic_schowdhu@quicinc.com>
Subject: [Resend PATCH V1 2/2] Revert "arm64: dts: qcom: sc7280: Add EUD dt node and dwc3 connector"
Date:   Fri, 18 Feb 2022 16:13:46 +0530
Message-ID: <2bf8d74c1871b0e06de53f800fb77484677e610a.1645177190.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1645177190.git.quic_schowdhu@quicinc.com>
References: <cover.1645177190.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a0c68e493007a8c72b6b00f6ac95590a86edc937.

Revert all the changes to add the Embedded USB Debugger(EUD) Node
in the device tree, the connector node and also changes to usb2 Node
associated with this.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 96917fe..937c2e0 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2583,12 +2583,6 @@
 				phys = <&usb_2_hsphy>;
 				phy-names = "usb2-phy";
 				maximum-speed = "high-speed";
-				usb-role-switch;
-				port {
-					usb2_role_switch: endpoint {
-						remote-endpoint = <&eud_ep>;
-					};
-				};
 			};
 		};
 
@@ -2630,36 +2624,6 @@
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		eud: eud@88e0000 {
-			compatible = "qcom,sc7280-eud","qcom,eud";
-			reg = <0 0x88e0000 0 0x2000>,
-			      <0 0x88e2000 0 0x1000>;
-			interrupts-extended = <&pdc 11 IRQ_TYPE_LEVEL_HIGH>;
-			ports {
-				port@0 {
-					eud_ep: endpoint {
-						remote-endpoint = <&usb2_role_switch>;
-					};
-				};
-				port@1 {
-					eud_con: endpoint {
-						remote-endpoint = <&con_eud>;
-					};
-				};
-			};
-		};
-
-		eud_typec: connector {
-			compatible = "usb-c-connector";
-			ports {
-				port@0 {
-					con_eud: endpoint {
-						remote-endpoint = <&eud_con>;
-					};
-				};
-			};
-		};
-
 		nsp_noc: interconnect@a0c0000 {
 			reg = <0 0x0a0c0000 0 0x10000>;
 			compatible = "qcom,sc7280-nsp-noc";
-- 
2.7.4

