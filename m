Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD71C433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 14:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385548AbiEBOTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 10:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385646AbiEBOTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:19:01 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88CC13EB1;
        Mon,  2 May 2022 07:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651500932; x=1683036932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=yTX41JeraCfRTBjir39mA80cBsGj5BQ5Wv3IptkAcz0=;
  b=iBgwut29F8PS3+mmIrxPRUEMapnzLDUT1FXsEeSyjAYoFKsRUepTc0d9
   F3JRFq6vFzMZzlYw2wCh8B3iwHz/85IoGVqGM4LMCvB2cOmaSxA8qyLlc
   q80b8335NO9WyXK2fKOZXxKpmysx1ibyas3Sw2ssa5ps962kSyiu8ra8h
   c=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 May 2022 07:15:31 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 07:15:11 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 2 May 2022 07:15:10 -0700
Received: from kaushalk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 2 May 2022 07:15:07 -0700
From:   Kaushal Kumar <quic_kaushalk@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <manivannan.sadhasivam@linaro.org>,
        "Kaushal Kumar" <quic_kaushalk@quicinc.com>
Subject: [PATCH v2 4/4] ARM: dts: qcom: sdx65-mtp: Enable QPIC NAND support
Date:   Mon, 2 May 2022 07:14:38 -0700
Message-ID: <1651500878-10244-5-git-send-email-quic_kaushalk@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651500878-10244-1-git-send-email-quic_kaushalk@quicinc.com>
References: <1651500878-10244-1-git-send-email-quic_kaushalk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable QPIC NAND devicetree node for Qualcomm SDX65-MTP board.

Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index 153ad2a..b0027c1 100644
--- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
@@ -249,6 +249,21 @@
 	status = "ok";
 };
 
+&qpic_nand {
+	status = "ok";
+
+	nand@0 {
+		reg = <0>;
+
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+		nand-bus-width = <8>;
+		/* ico and efs2 partitions are secured */
+		secure-regions = /bits/ 64 <0x500000 0x500000
+					    0xa00000 0xb00000>;
+	};
+};
+
 &usb {
 	status = "okay";
 };
-- 
2.7.4

