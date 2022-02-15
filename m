Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED06C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 08:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbiBOIyl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 03:54:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbiBOIyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:54:35 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC71114744;
        Tue, 15 Feb 2022 00:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644915265; x=1676451265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=IQLLmXo7wc1pvR6GTwJC5Pf/8ioCBbT9unCBYh8+ORI=;
  b=DrFg/MtLSfZuyEQ0rDW3RzkeSXldACJP5YjsHBRCXII3VP6stNttF3Mk
   51UuWSwDbD9RJxrz7t1ZU4Z3IUt9ifgOopdMkY6CKPeTfceLL2FO+e0V1
   Wp9TGLuTc24e2HY8O/XgvILv3RO/+LeuRgpUzQTwACTSfShUEHo4Hwie0
   o=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 15 Feb 2022 00:54:25 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 00:54:24 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 00:54:24 -0800
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 15 Feb 2022 00:54:19 -0800
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V6 2/6] dt-bindings: mfd: pm8008: Add regulators node
Date:   Tue, 15 Feb 2022 14:23:47 +0530
Message-ID: <1644915231-7308-3-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644915231-7308-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1644915231-7308-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulators node and their supply nodes. Add separate compatible
"qcom,pm8008-regulators" to differentiate between pm8008 infra
and pm8008 regulators mfd devices.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in V2:
 - As per Rob's comments changed "pm8008[a-z]?-regulator" to
   "^pm8008[a-z]?-regulators".

Changes in V3:
 - Fixed bot errors.
 - As per stephen's comments, changed "^pm8008[a-z]?-regulators$" to
   "regulators".

Changes in V4:
 - Changed compatible string to "qcom,pm8008-regulators"

Changes in V5:
 - Remove compatible for regulators node.
 - Move supply nodes of the regulators to chip level.

Changes in V6:
 - No changes.

 .../devicetree/bindings/mfd/qcom,pm8008.yaml       | 49 +++++++++++++++++++---
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
index ec3138c..1ec43f7 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
@@ -16,7 +16,9 @@ description: |
 
 properties:
   compatible:
-    const: qcom,pm8008
+    enum:
+      - qcom,pm8008
+      - qcom,pm8008-regulators
 
   reg:
     description:
@@ -44,6 +46,25 @@ properties:
   "#size-cells":
     const: 0
 
+  vdd_l1_l2-supply:
+    description: Input supply phandle of ldo1 and ldo2 regulators.
+
+  vdd_l3_l4-supply:
+    description: Input supply phandle of ldo3 and ldo4 regulators.
+
+  vdd_l5-supply:
+    description: Input supply phandle of ldo5 regulator.
+
+  vdd_l6-supply:
+    description: Input supply phandle of ldo6 regulator.
+
+  vdd_l7-supply:
+    description: Input supply phandle of ldo7 regulator.
+
+  regulators:
+    type: object
+    $ref: "../regulator/qcom,pm8008-regulator.yaml#"
+
 patternProperties:
   "^gpio@[0-9a-f]+$":
     type: object
@@ -88,10 +109,8 @@ patternProperties:
 required:
   - compatible
   - reg
-  - interrupts
   - "#address-cells"
   - "#size-cells"
-  - "#interrupt-cells"
 
 additionalProperties: false
 
@@ -102,7 +121,7 @@ examples:
     qupv3_se13_i2c {
       #address-cells = <1>;
       #size-cells = <0>;
-      pm8008i@8 {
+      pm8008_infra: pm8008@8 {
         compatible = "qcom,pm8008";
         reg = <0x8>;
         #address-cells = <1>;
@@ -123,6 +142,26 @@ examples:
           #interrupt-cells = <2>;
         };
       };
-    };
 
+      pm8008_regulators: pm8008@9 {
+        compatible = "qcom,pm8008";
+        reg = <0x9>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        vdd_l1_l2-supply = <&vreg_s8b_1p2>;
+        vdd_l3_l4-supply = <&vreg_s1b_1p8>;
+        vdd_l5-supply = <&vreg_bob>;
+        vdd_l6-supply = <&vreg_bob>;
+        vdd_l7-supply = <&vreg_bob>;
+
+        regulators {
+          pm8008_l1: ldo1 {
+            regulator-name = "pm8008_l1";
+            regulator-min-microvolt = <950000>;
+            regulator-max-microvolt = <1300000>;
+          };
+        };
+      };
+    };
 ...
-- 
2.7.4

