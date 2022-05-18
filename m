Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC85C4332F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 16:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbiERQnZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 12:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbiERQnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:43:18 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149F7666A8;
        Wed, 18 May 2022 09:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652892197; x=1684428197;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=vpJBvaAzfTSz9HeKnhqXj19U+zL5jsMKCL7ahIWzW9I=;
  b=uuAQQiGB5WOQr5/xsndVlabbNsCQaszWk5hSpMib5O4ysEfiVcjOivQY
   6QqZ7vzRzLx3n3gYigBZ34sMGISkhn3vbJ2FkOURycLTgAbqeX327oAlh
   cDRQXBJss3OhrDgz0QricTNsFezziMnF+yIjolABiGEdXykhsnlhOWyPx
   I=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 May 2022 09:43:16 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 09:43:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 09:43:16 -0700
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 09:43:15 -0700
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
Subject: [PATCH v2 0/2] eDP/DP Phy vdda realted function
Date:   Wed, 18 May 2022 09:43:04 -0700
Message-ID: <1652892186-22346-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) add regulator_set_load() to eDP/DP phy
2) remove vdda related function out of eDP/DP controller

Kuogee Hsieh (2):
  phy/qcom: add regulator_set_load to edp/dp phy
  drm/msm/dp: delete vdda regulator related functions from eDP/DP
    controller

 drivers/gpu/drm/msm/dp/dp_parser.c  | 14 ------
 drivers/gpu/drm/msm/dp/dp_parser.h  |  6 ---
 drivers/gpu/drm/msm/dp/dp_power.c   | 95 +------------------------------------
 drivers/phy/qualcomm/phy-qcom-edp.c | 25 ++++++++--
 drivers/phy/qualcomm/phy-qcom-qmp.c | 13 +++++
 5 files changed, 36 insertions(+), 117 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

