Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B38C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 08:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345589AbiCUI7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 04:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345512AbiCUI6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:58:20 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F30E57485;
        Mon, 21 Mar 2022 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647853016; x=1679389016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=M4kVC0r/rfY1s2TKqLyYnRyMBohGE64J9AJFvf+O4KQ=;
  b=IJMX+KdTy25+V0wM9k1IOIUbUKOWf0+8Pud5IGWpB/g/Uw8+vgu63uBK
   2SxUFTUzTNVSptd8NxuifDTjnGFys2VN12QvJIQNA6SkSL7FlnH0+wv+f
   kULr5/gjG5TJTNfRxT7bBcKtBmGo3Dfax04bBRtUW25yZRXVuIsNVT6uV
   M=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 21 Mar 2022 01:56:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 01:56:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 01:56:55 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 01:56:50 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rohitkr@codeaurora.org>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <alsa-devel@alsa-project.org>, <krzysztof.kozlowski@canonical.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH 3/3] ASoC: dt-bindings: lpass-cpu: Update clocks and power domain names for sc7280 platform
Date:   Mon, 21 Mar 2022 14:26:21 +0530
Message-ID: <1647852981-27895-4-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647852981-27895-1-git-send-email-quic_srivasam@quicinc.com>
References: <1647852981-27895-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update required clock-names used for MI2S primary path, VA macro's
codec memory path and HDMI path in sc7280 based platforms.
Update power domain names required for sc7280 platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml       | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
index 2c81efb..e9a5330 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
@@ -38,8 +38,8 @@ properties:
     maxItems: 7
 
   clock-names:
-    minItems: 3
-    maxItems: 7
+    minItems: 1
+    maxItems: 10
 
   interrupts:
     minItems: 2
@@ -62,6 +62,9 @@ properties:
   power-domains:
     maxItems: 1
 
+  power-domain-names:
+    maxItems: 1
+
   '#sound-dai-cells':
     const: 1
 
@@ -192,15 +195,19 @@ allOf:
           oneOf:
             - items:   #for I2S
                 - const: aon_cc_audio_hm_h
+                - const: audio_cc_ext_mclk0
                 - const: core_cc_sysnoc_mport_core
+                - const: core_cc_ext_if0_ibit
                 - const: core_cc_ext_if1_ibit
             - items:   #for Soundwire
                 - const: aon_cc_audio_hm_h
+                - const: audio_cc_codec_mem
                 - const: audio_cc_codec_mem0
                 - const: audio_cc_codec_mem1
                 - const: audio_cc_codec_mem2
+                - const: aon_cc_va_mem0
             - items:   #for HDMI
-                - const: aon_cc_audio_hm_h
+                - const: core_cc_sysnoc_mport_core
 
         reg-names:
           anyOf:
@@ -228,6 +235,10 @@ allOf:
                 - const: lpass-irq-hdmi
                 - const: lpass-irq-vaif
                 - const: lpass-irq-rxtxif
+        power-domain-names:
+          allOf:
+            - items:
+                - const: lcx
 
       required:
         - iommus
-- 
2.7.4

