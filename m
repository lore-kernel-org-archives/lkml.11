Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0505C4167E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 12:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352945AbiDLMIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 08:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352957AbiDLMDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:03:45 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA187D6;
        Tue, 12 Apr 2022 04:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649761439; x=1681297439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=qOf4Essn/sKdi29v8yTKqm2ReRXAKUxF5Ksbl/DCHTA=;
  b=QKLpYxhb0Ev0lkn9Wmbcimjwzm7Q5q0/7DBHrf+NtCUe/FonORGdnHNb
   Rrg4knOkE8lrOhUzBFcC6gGr+mXOAYGMxA3YEn5AECvSXiPqsQ/2Kn4GK
   QpimYw0eYNHd5JFYicJ0xVdGAvmlL5ETAWx1HZv+zo9kaoM2wp59bEslc
   Q=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 12 Apr 2022 04:03:59 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Apr 2022 04:03:56 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 12 Apr 2022 16:33:42 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id E6C6F3AC2; Tue, 12 Apr 2022 16:33:40 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 2/4] dt-bindings: usb: qcom,dwc3: Add binding for SDX65
Date:   Tue, 12 Apr 2022 16:33:32 +0530
Message-Id: <1649761414-19217-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649761414-19217-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1649761414-19217-1-git-send-email-quic_rohiagar@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for SDX65 USB controller based on
Qcom designware IP.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index ce252db..2d73b03 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,sdm660-dwc3
           - qcom,sdm845-dwc3
           - qcom,sdx55-dwc3
+          - qcom,sdx65-dwc3
           - qcom,sm4250-dwc3
           - qcom,sm6115-dwc3
           - qcom,sm6350-dwc3
-- 
2.7.4

