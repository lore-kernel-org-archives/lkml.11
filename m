Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC6DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 18:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244419AbiBQSgw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 13:36:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244540AbiBQSgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:36:04 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6308636D;
        Thu, 17 Feb 2022 10:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645122948; x=1676658948;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=4qJ8f3DvdzFtL6Kce/L1Hvdc1BFgt84LMQDjlrKs/3Q=;
  b=lpnYY1CnLynhKZDCOXHoreR00k4geSCiwFoavu/kAc/yPON8DuyO42jm
   j9FoL88DiwMJhhp5SCnvnrcTvsdHSBhM2VPxt7zJvzabsYlHY3GI99HbF
   +FcLTr3ZsFfNIC9v0n+DS9L3jdoqKqplbWg7TNY7FqT8+nB44DZ3KGNsB
   U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Feb 2022 10:35:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 10:35:40 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 17 Feb 2022 10:35:40 -0800
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 17 Feb 2022 10:35:39 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <vkoul@kernel.org>,
        <daniel@ffwll.ch>, <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/3] drm/msm/dp: replace DRM_DEBUG_DP with drm_dbg_dp
Date:   Thu, 17 Feb 2022 10:35:27 -0800
Message-ID: <1645122930-23863-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since DRM_DEBUG_DP is deprecated in favor of drm_dbg_dp(NULL, ...),
replace all DRM_DEBUG_DP with drm_dbg_dp().

Kuogee Hsieh (3):
  drm/msm/dp: add connector type to enhance debug messages
  drm/msm/dp: enhance debug info related to dp phy
  drm/msm/dp:  replace DRM_DEBUG_DP marco with drm_dbg_dp

 drivers/gpu/drm/msm/dp/dp_audio.c   |  50 ++++++++++-----
 drivers/gpu/drm/msm/dp/dp_catalog.c |  35 +++++-----
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 124 +++++++++++++++++++-----------------
 drivers/gpu/drm/msm/dp/dp_display.c | 103 +++++++++++++++++++++---------
 drivers/gpu/drm/msm/dp/dp_drm.c     |   4 +-
 drivers/gpu/drm/msm/dp/dp_link.c    | 103 ++++++++++++++++++------------
 drivers/gpu/drm/msm/dp/dp_panel.c   |  47 ++++++++------
 drivers/gpu/drm/msm/dp/dp_parser.c  |   2 -
 drivers/gpu/drm/msm/dp/dp_power.c   |  25 ++++++--
 9 files changed, 302 insertions(+), 191 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

