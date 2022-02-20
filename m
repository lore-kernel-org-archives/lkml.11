Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601A5C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Feb 2022 22:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245168AbiBTWbL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Feb 2022 17:31:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244533AbiBTWbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 17:31:05 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD324B871;
        Sun, 20 Feb 2022 14:30:43 -0800 (PST)
Received: from localhost.localdomain (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 0ED12C6D5A;
        Sun, 20 Feb 2022 22:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645396242; bh=OKXxgRFsXOpr2FPUaX4QNjWA+N8erkfnFKPqK8ueCMo=;
        h=From:To:Cc:Subject:Date;
        b=HbnRNE72DtEmUTK0PlO1INwXm78DROVMgCgI2HgbIWYhxQgqBzhHC91xFq4gBkgTu
         9Jy5OiYiYLoHNuRnoH09hAU5LfjcSZDnZUjxSGFb14Ej0zzGxOAYRTBuzt5LtV36uX
         Ip4z8dy4qP/zGUMtUTsYWBB9dfuMyQWBGTZQ1PA4=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: power: rpmpd: Add MSM8226 to rpmpd binding
Date:   Sun, 20 Feb 2022 23:30:01 +0100
Message-Id: <20220220223004.507739-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible and constants for the power domains exposed by the
MSM8226 RPM.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 include/dt-bindings/power/qcom-rpmpd.h                  | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index f48bc41d81ec..940e97b565bf 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - qcom,mdm9607-rpmpd
+      - qcom,msm8226-rpmpd
       - qcom,msm8916-rpmpd
       - qcom,msm8939-rpmpd
       - qcom,msm8953-rpmpd
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index edfc1ff2acb3..c002cc6ddf55 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -139,6 +139,11 @@
 #define MDM9607_VDDMX_AO	4
 #define MDM9607_VDDMX_VFL	5
 
+/* MSM8226 Power Domain Indexes */
+#define MSM8226_VDDCX		0
+#define MSM8226_VDDCX_AO	1
+#define MSM8226_VDDCX_VFC	2
+
 /* MSM8939 Power Domains */
 #define MSM8939_VDDMDCX		0
 #define MSM8939_VDDMDCX_AO	1
-- 
2.35.1

