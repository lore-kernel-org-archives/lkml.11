Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894AFC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 12:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243381AbiDNMdk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 08:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243371AbiDNMdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:33:33 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7B1340F2;
        Thu, 14 Apr 2022 05:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649939466; x=1681475466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=mol9L4z7TxFFL5K9se+ZnR6/rfEU2d6sk/+M8yAFBRU=;
  b=C1tVC4QLLQwoA+LL//tkQm7mxAZtAW55m+dr8X0Bkm1RcsuML4lwR/hQ
   rqWLWsTw6ZwrUC5gwK09UL3teC7UZbGS4dzOQIF5u63y6asZdatJRTyNh
   CSuozmYCi160Az/OK2l7p+/oytYACX+ehXt4o3w35nmV674/4SJOhFGi7
   A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Apr 2022 05:31:06 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 05:31:06 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 05:31:05 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 05:31:01 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V10 3/9] dt-bindings: mfd: pm8008: Add regulators
Date:   Thu, 14 Apr 2022 18:00:12 +0530
Message-ID: <1649939418-19861-4-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulators for pm8008 with example.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
Changes in V10:
 - Add regulators under main mfd node as in DT.

 Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
index 3312784..060cc35 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
@@ -44,6 +44,9 @@ properties:
   "#size-cells":
     const: 0
 
+  regulators:
+    $ref: "/schemas/regulator/qcom,pm8008-regulators.yaml#"
+
   reset-gpios:
     maxItems: 1
 
@@ -129,6 +132,20 @@ examples:
           interrupt-controller;
           #interrupt-cells = <2>;
         };
+
+        regulators {
+          vdd_l1_l2-supply = <&vreg_s8b_1p2>;
+          vdd_l3_l4-supply = <&vreg_s1b_1p8>;
+          vdd_l5-supply = <&vreg_bob>;
+          vdd_l6-supply = <&vreg_bob>;
+          vdd_l7-supply = <&vreg_bob>;
+
+          ldo1 {
+            regulator-name = "pm8008_l1";
+            regulator-min-microvolt = <950000>;
+            regulator-max-microvolt = <1300000>;
+          };
+        };
       };
     };
 
-- 
2.7.4

