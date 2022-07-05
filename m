Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3559CCA47F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 16:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiGEQ3c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 12:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiGEQ33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:29:29 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9D418382;
        Tue,  5 Jul 2022 09:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657038568; x=1688574568;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=nhjQFTOM7tP5gqGtT+73ZdeFjuAbda/CdSnEwGfblNk=;
  b=egHY2KzuxjsJ9BTmc5bJxsAMTMrkyd9K9gabqX3kq0sR7utYFxHSp70C
   fkxoqEZyNTrMbjibBcdINlf/sY+hYUS46MPAv0vBOvoCL1xmJjDoXxyC1
   an7L6KKPzC9sUyf4uFePX6wxmo4JowsnA0zULfzV0+VOMioF9jQ7KW5Pl
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Jul 2022 09:29:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 09:29:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 09:29:27 -0700
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 09:29:26 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v16 0/3] eDP/DP Phy vdda realted function
Date:   Tue, 5 Jul 2022 09:29:13 -0700
Message-ID: <1657038556-2231-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0) rebase on https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tree
1) add regulator_set_load() to eDP phy
2) add regulator_set_load() to DP phy
3) remove vdda related function out of eDP/DP controller

Kuogee Hsieh (3):
  phy: qcom-edp: add regulator_set_load to edp phy
  phy: qcom-qmp: add regulator_set_load to dp phy
  drm/msm/dp: delete vdda regulator related functions from eDP/DP
    controller

 drivers/gpu/drm/msm/dp/dp_parser.c        | 14 -----
 drivers/gpu/drm/msm/dp/dp_parser.h        |  8 ---
 drivers/gpu/drm/msm/dp/dp_power.c         | 95 +------------------------------
 drivers/phy/qualcomm/phy-qcom-edp.c       | 12 ++++
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 41 ++++++++++---
 5 files changed, 46 insertions(+), 124 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

