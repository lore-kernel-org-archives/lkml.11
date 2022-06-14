Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9994EC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 09:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242036AbiFNJth (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 05:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238690AbiFNJt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:49:27 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AB843380;
        Tue, 14 Jun 2022 02:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655200167; x=1686736167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=3PDlypTZmQoAgBV4Z8FAvsXGc/EnowsIiwpAeG/wlNo=;
  b=WIFHCZMwfECwiVH5vVlkZV/DWZKLtHuJ9Vji61neN38eKVcPaoRC8E/X
   +zPa0yuLwJvT4/4CLEIqOjjt4uKNe3usqIgwPdD0qejJIZHok0ioibQzi
   hIp0Ricma0/Qi4pDTxBthUdhw+97F5zF9brLDYwSud8etMNkw/eOPefBJ
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 14 Jun 2022 02:49:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 02:49:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 02:49:12 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 14 Jun 2022 02:49:08 -0700
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
Subject: [PATCH V15 1/9] dt-bindings: mfd: pm8008: Add reset-gpios
Date:   Tue, 14 Jun 2022 15:18:23 +0530
Message-ID: <1655200111-18357-2-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655200111-18357-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1655200111-18357-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset-gpios property for pm8008.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in V15:
 - None.

Changes in V14:
 - None.

Changes in V13:
 - None.

 Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
index ec3138c..a89649c 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
@@ -44,6 +44,9 @@ properties:
   "#size-cells":
     const: 0
 
+  reset-gpios:
+    maxItems: 1
+
 patternProperties:
   "^gpio@[0-9a-f]+$":
     type: object
@@ -92,6 +95,7 @@ required:
   - "#address-cells"
   - "#size-cells"
   - "#interrupt-cells"
+  - reset-gpios
 
 additionalProperties: false
 
@@ -99,6 +103,7 @@ examples:
   - |
     #include <dt-bindings/mfd/qcom-pm8008.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
     qupv3_se13_i2c {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -113,6 +118,8 @@ examples:
         interrupt-parent = <&tlmm>;
         interrupts = <32 IRQ_TYPE_EDGE_RISING>;
 
+        reset-gpios = <&pm8350c_gpios 4 GPIO_ACTIVE_LOW>;
+
         pm8008_gpios: gpio@c000 {
           compatible = "qcom,pm8008-gpio", "qcom,spmi-gpio";
           reg = <0xc000>;
-- 
2.7.4

