Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1249C43334
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 02:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbiFCCOx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 22:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiFCCOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 22:14:48 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA97D369C0;
        Thu,  2 Jun 2022 19:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654222486; x=1685758486;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=qSqyxUGSBvwO+iIfAgD4DbrPTpHhtxYDB+NXlueOkUk=;
  b=FVkQ0V12NyiFVyHN9vd4v30bvUZN8xdEs+484mCSZkfRZURB4bnHNx+P
   S7Tpp5Cd1XyfSzxiW13oRMDvUdmRmMLqcKjSJrGa4WpIZmwvOwPzHZWYd
   8v6qm/+GEXdL2oucUam0YG0ygn1p9hnuU2ej2n2CG2AhNC1QFIrRWJACJ
   Y=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Jun 2022 19:14:45 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 19:14:45 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 19:14:44 -0700
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 19:14:44 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <gregkh@linuxfoundation.org>,
        <bjorn.andersson@linaro.org>, <kishon@ti.com>,
        <robh+dt@kernel.org>, <agross@kernel.org>, <vkoul@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_jackp@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH] dt-bindings: Update QCOM USB subsystem maintainer information
Date:   Thu, 2 Jun 2022 19:14:32 -0700
Message-ID: <20220603021432.13365-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update devicetree binding files with the proper maintainer, and updated
contact email.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml | 2 +-
 Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml       | 2 +-
 .../devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml         | 2 +-
 .../devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml  | 2 +-
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml            | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
index 60dc27834e1d..b078009ed509 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
@@ -8,7 +8,7 @@ $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 title: Qualcomm QMP USB3 DP PHY controller
 
 maintainers:
-  - Manu Gautam <mgautam@codeaurora.org>
+  - Wesley Cheng <quic_wcheng@quicinc.com>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
index 0ab3dad3f121..d68ab49345b8 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
@@ -8,7 +8,7 @@ $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 title: Qualcomm QUSB2 phy controller
 
 maintainers:
-  - Manu Gautam <mgautam@codeaurora.org>
+  - Wesley Cheng <quic_wcheng@quicinc.com>
 
 description:
   QUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
index 1ce251de0855..7a0e6a9854da 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
@@ -7,7 +7,7 @@ $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 title: Qualcomm Synopsys Femto High-Speed USB PHY V2
 
 maintainers:
-  - Wesley Cheng <wcheng@codeaurora.org>
+  - Wesley Cheng <quic_wcheng@quicinc.com>
 
 description: |
   Qualcomm High-Speed USB PHY
diff --git a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
index 12ed98c28aaa..dbe78cd4adba 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: The Qualcomm PMIC VBUS output regulator driver
 
 maintainers:
-  - Wesley Cheng <wcheng@codeaurora.org>
+  - Wesley Cheng <quic_wcheng@quicinc.com>
 
 description: |
   This regulator driver controls the VBUS output by the Qualcomm PMIC.  This
diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index e336fe2e03cc..749e1963ddbb 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm SuperSpeed DWC3 USB SoC controller
 
 maintainers:
-  - Manu Gautam <mgautam@codeaurora.org>
+  - Wesley Cheng <quic_wcheng@quicinc.com>
 
 properties:
   compatible:
