Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B76C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 12:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347108AbiCUME5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 08:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiCUMEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:04:53 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84562659B;
        Mon, 21 Mar 2022 05:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647864208; x=1679400208;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=LBjKxMXHUPA0MBLtDXm+CGwGiORiHOghh88r4RgnKf4=;
  b=Rpk2og1HUisF7EYuLK3jv9y8f3yAcZmRii/inxBY9cDaPfztBLypD9nl
   19jmJXFEPULiz4zbl/3jVkrViLLgU3ylgPKlnsZCP8eh2Sx0my37xSW/q
   Mvu+FzxtFXQTAD91HzvIlQhXpw9r4/Q1ygf7pvJjK0imeWLbVeatzzifw
   g=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Mar 2022 05:03:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 05:03:27 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 05:03:27 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 05:03:23 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v5 0/3] Add lpass pin control support for audio on sc7280 based targets
Date:   Mon, 21 Mar 2022 17:29:16 +0530
Message-ID: <1647863959-3289-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to add lpass pin control support for Audio over I2S,
wcd codec and digital mics.
This patch set depends on:
	-- Lpass-lpi pinctrl patches [https://patchwork.kernel.org/project/alsa-devel/list/?series=623951&archive=both&state=*]

Changes Since V4:
    -- Add primary and secondary I2S pinmux nodes for herobrine specific targets.
Changes Since V3:
    -- Add pinctrl nodes for wcd codec reset and CTIA/OMTP headset selection.
Changes Since V2:
    -- Move lpass pin control node to main dtsi file.
    -- Sort nodes alphabetically.
    -- Remove redundant wcd reset gpio nodes.
    -- Remove redundant input-enable field in dmic pin control nodes.
    -- Update amp_en node. 
    -- Fix typo errors.
    -- Modify node names.
    -- Create patches on latest kernel.    
Changes Since V1:
    -- Merge pinmux and pinconf properties in amp_en and wcd pin reset node.
    -- Split common i2s pin control nodes to functionality specific nodes.
    -- Move board specific properties to board specific dtsi file.
    -- Update dmic pin control node name.
Srinivasa Rao Mandadapu (3):
  arm64: dts: qcom: sc7280: Add pinctrl for wcd938x codec reset and
    CTIA/OMTP headset selection
  arm64: dts: qcom: sc7280: Add pinmux for I2S speaker and Headset
  arm64: dts: qcom: sc7280: add lpass lpi pin controller node

 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  34 +++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       |  43 ++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi           | 188 +++++++++++++++++++++++++
 3 files changed, 265 insertions(+)

-- 
2.7.4

