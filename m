Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A30C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 15:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380361AbiBHPed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 10:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357075AbiBHPeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:34:31 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D913C061579;
        Tue,  8 Feb 2022 07:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644334471; x=1675870471;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=EXYG8k+MxXH2YD2Vp5IRmopJjJXrnw1g9nldIjqOPpA=;
  b=izMJNPeR287lR5KeX8g2X3q21QIafR75w/pWyWF1LALjze/7jIJ1aNYq
   jNfCQBYqp06zOBqgMDNFjbPtfUqqGymUV/O7l71UXayv+xRdHiCTDI+qR
   OdKVqmZVI4PYl7Qku5u+/slzLSgp+bHJp0cSzj2E92jIgRINbUl7lAKPj
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 08 Feb 2022 07:34:31 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 07:34:30 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 07:34:30 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 07:34:26 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v2 0/3] Add lpass pin control support for audio on sc7280 based targets
Date:   Tue, 8 Feb 2022 21:04:11 +0530
Message-ID: <1644334454-16719-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to add lpass pin control support for Audio over I2S,
wcd codec and digital mics.

This patch set depends on:
	-- https://patchwork.kernel.org/project/alsa-devel/patch/1638891339-21806-3-git-send-email-quic_srivasam@quicinc.com/

Changes Since V1:
    -- Merge pinmux and pinconf properties in amp_en and wcd pin reset node.
    -- Split common i2s pin control nodes to functionality specific nodes.
    -- Move board specific properties to board specific dtsi file.
    -- Update dmic pin control node name.

Srinivasa Rao Mandadapu (3):
  arm64: dts: qcom: sc7280: Add pinmux for I2S speaker and Headset
  arm64: dts: qcom: sc7280: add lpass lpi pin controller node
  arm64: dts: qcom: sc7280: Add wcd9380 pinmux

 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 205 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     |  40 ++++++
 2 files changed, 245 insertions(+)

-- 
2.7.4

