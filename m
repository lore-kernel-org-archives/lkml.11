Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB57C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 12:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbiDNMdf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 08:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243346AbiDNMd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:33:27 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68C12FE48;
        Thu, 14 Apr 2022 05:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649939462; x=1681475462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=XJIV+jBdnfLZCgjBHNlwQwCsTaYirvNMpAPl7NJYPY0=;
  b=Kzx87znmwKOfqew63AWniDk95KHbcRPDSjsLO0NFyvxaRzwfMxGTiNGl
   oLVyIUd/1GlXDI16SnTjs5RU43nN/cGdREe2qrx6czsybbvECLmmhJMhM
   72L7KS2PiG5MFf8cneool9BwSpHbAobhOY3yCew3zUenh0/IvXnMRH/6/
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Apr 2022 05:31:02 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 05:31:01 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 05:31:01 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 05:30:57 -0700
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
Subject: [PATCH V10 2/9] dt-bindings: regulator: pm8008: Add pm8008 regulator bindings
Date:   Thu, 14 Apr 2022 18:00:11 +0530
Message-ID: <1649939418-19861-3-git-send-email-quic_c_skakit@quicinc.com>
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

Add bindings for pm8008 regulators.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
Changes in V8:
 - This is split from pm8008.yaml binding.

Changes in V9:
  - Remove description for reg and drop unused phandle from example.

Changes in V10:
 - Regulators are added as a part of pm8008@8 device. Change bindings doc
   accordingly.

 .../bindings/regulator/qcom,pm8008-regulators.yaml | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,pm8008-regulators.yaml

diff --git a/Documentation/devicetree/bindings/regulator/qcom,pm8008-regulators.yaml b/Documentation/devicetree/bindings/regulator/qcom,pm8008-regulators.yaml
new file mode 100644
index 0000000..f56cdcc
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,pm8008-regulators.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/qcom,pm8008-regulators.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. PM8008 Regulator bindings
+
+maintainers:
+  - Satya Priya <quic_c_skakit@quicinc.com>
+
+description: |
+  Qualcomm Technologies, Inc. PM8008 is an I2C controlled PMIC
+  containing 7 LDO regulators. This binding specifies the PM8008
+  regulator peripherals of PM8008 device.
+
+properties:
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
+patternProperties:
+  "^ldo[1-7]$":
+    type: object
+    $ref: "/schemas/regulator/regulator.yaml#"
+    description: PM8008 regulator peripherals of PM8008 regulator device.
+
+additionalProperties: false
+...
-- 
2.7.4

