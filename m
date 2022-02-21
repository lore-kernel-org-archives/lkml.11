Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DD7C4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 05:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344458AbiBUFXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 00:23:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344401AbiBUFXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:23:34 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A49FF7B;
        Sun, 20 Feb 2022 21:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645420992; x=1676956992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/upK0A0rflnjDZY7Ohlb4ns1NlD1J1g8hyys+JiFpCk=;
  b=Ut5uVQnqdR008kZeeb44eIuM49yvNSapMdUcaDODBOij+Lyvc2eJOMtZ
   dh5CWIMxQQrZovzgQr7U3S/1DYS4qb8ZrZtcmRvNVYahTIdgynxO4ueTj
   uRxt0RBNxE5IjF2t1fUMqSA/aDSxruDf4XmNyNCkhdXbaRI2JClKf7xGT
   w=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 20 Feb 2022 21:23:11 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 20 Feb 2022 21:23:08 -0800
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Feb 2022 10:52:56 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 593E546C3; Mon, 21 Feb 2022 10:52:55 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 6/7] ARM: dts: qcom: sdx65: Add support for APCS block
Date:   Mon, 21 Feb 2022 10:52:32 +0530
Message-Id: <1645420953-21176-7-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645420953-21176-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1645420953-21176-1-git-send-email-quic_rohiagar@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The APCS block on SDX65 acts as a mailbox controller and also provides
clock output for the Cortex A7 CPU.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 0219445..b02d598 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -133,6 +133,15 @@
 			#clock-cells = <0>;
 		};
 
+		apcs: mailbox@17810000 {
+			compatible = "qcom,sdx65-apcs-gcc", "syscon";
+			reg = <0x17810000 0x2000>;
+			#mbox-cells = <1>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&a7pll>, <&gcc GPLL0>;
+			clock-names = "ref", "pll", "aux";
+			#clock-cells = <0>;
+		};
+
 		timer@17820000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.7.4

