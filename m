Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3944FC433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 20:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbiERUYU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 16:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242524AbiERUYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:24:17 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDA72469DC;
        Wed, 18 May 2022 13:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652905456; x=1684441456;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=LKucHnSVE5Vnuk0DrUdSsCLARrJ4f522LxKAEPpDS9Y=;
  b=X5Af32Lrc+wE0+vkduLg2CwcV/4BRJS5cOSzskCG9uRShACYVafvCEtU
   57aT8hFPYe+xj4u/r6nH+3pG76eXs6nuRrDEMNvRflTVHCH9/txF47gpZ
   mRnihmDr/jeQcWr3oOA598n6xZ6f+2L+XdTVxtzNE/nHHT+lwPNMbyDxU
   E=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 May 2022 13:24:16 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 13:24:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 13:24:15 -0700
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 13:24:14 -0700
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
Subject: [PATCH v3 0/3] eDP/DP Phy vdda realted function
Date:   Wed, 18 May 2022 13:24:01 -0700
Message-ID: <1652905444-10130-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) add regulator_set_load() to eDP phy
2) add regulator_set_load() to DP phy
3) remove vdda related function out of eDP/DP controller

Kuogee Hsieh (3):
  phy/qualcomm: add regulator_set_load to edp phy
  phy/qualcomm: add regulator_set_load to dp phy
  drm/msm/dp: delete vdda regulator related functions from eDP/DP
    controller

 drivers/gpu/drm/msm/dp/dp_parser.c  | 14 ------
 drivers/gpu/drm/msm/dp/dp_parser.h  |  6 ---
 drivers/gpu/drm/msm/dp/dp_power.c   | 95 +------------------------------------
 drivers/phy/qualcomm/phy-qcom-edp.c | 10 +++-
 drivers/phy/qualcomm/phy-qcom-qmp.c | 12 +++++
 5 files changed, 23 insertions(+), 114 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

