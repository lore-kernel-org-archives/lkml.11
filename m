Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A742C3525B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 12:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353232AbiDLMIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 08:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352953AbiDLMDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:03:45 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40BCA8;
        Tue, 12 Apr 2022 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649761437; x=1681297437;
  h=from:to:cc:subject:date:message-id;
  bh=IEb/4Bd/+YAAPeeC3/B2s4kLNJ67E5GwZ3xGVOtVrv0=;
  b=icIvgHPk9vZvKaxSdoRyTRPcbn2nxDvpYW0NRbml5mS5uj6lLzBGtbZy
   I72r3w5GBfsunHvJLD15pVCJ2qT2u/aII4wJKcejrjkIbCsYLLiON0QSn
   iLLmZij+Q5jV7LZBkhFyHMPgVMJNMqf6ZO2ne/vPhNBsPG5a3ixVXnovN
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 12 Apr 2022 04:03:57 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Apr 2022 04:03:54 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 12 Apr 2022 16:33:41 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id E6C7B3AA3; Tue, 12 Apr 2022 16:33:39 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/4] Devicetree updates for Interconnect, USB3 and PHY support
Date:   Tue, 12 Apr 2022 16:33:30 +0530
Message-Id: <1649761414-19217-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds the devicetree nodes to support the interconnect, USB3 and PHY support.

Thanks,
Rohit.

Rohit Agarwal (4):
  ARM: dts: qcom: sdx65: Add interconnect nodes
  dt-bindings: usb: qcom,dwc3: Add binding for SDX65
  ARM: dts: qcom: sdx65: Add USB3 and PHY support
  ARM: dts: qcom: sdx65-mtp: Enable USB3 and PHY support

 .../devicetree/bindings/usb/qcom,dwc3.yaml         |   1 +
 arch/arm/boot/dts/qcom-sdx65-mtp.dts               |  29 +++++-
 arch/arm/boot/dts/qcom-sdx65.dtsi                  | 108 +++++++++++++++++++++
 3 files changed, 134 insertions(+), 4 deletions(-)

-- 
2.7.4

