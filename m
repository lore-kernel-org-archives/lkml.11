Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BE1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 21:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbiBYVYE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 16:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiBYVYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:24:00 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898F2186205;
        Fri, 25 Feb 2022 13:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645824207; x=1677360207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HGj5prqFyvunWCykDRs+z0kDacjQonvU+uuSOCwS9Ks=;
  b=Zs0P+gGmGV3pWUPtAg4XpKmfmUnLuz79MRdbB9ZkVfgxytxQ2qbl2MwY
   ZVBw8lOfEFq6NTv1VVkf16t+jROdW0/QmtDRgjNdhTmvDh7w6KV/YbDtO
   rRC+YObYH0k6kMyHfIEaTsH6BmTeslHrxjX6uT+z8RsOZMjb9oTh5L6/S
   4=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Feb 2022 13:23:27 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 13:23:26 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 13:23:26 -0800
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 13:23:25 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <vkoul@kernel.org>,
        <daniel@ffwll.ch>, <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 1/4] drm/msm/dpu: adjust display_v_end for eDP and DP
Date:   Fri, 25 Feb 2022 13:23:09 -0800
Message-ID: <1645824192-29670-2-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645824192-29670-1-git-send-email-quic_khsieh@quicinc.com>
References: <1645824192-29670-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The “DP timing” requires the active region to be defined in the
bottom-right corner of the frame dimensions which is different
with DSI. Therefore both display_h_end and display_v_end need
to be adjusted accordingly. However current implementation has
only display_h_end adjusted.

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Fixes: fc3a69ec68d3 ("drm/msm/dpu: intf timing path for displayport")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 116e2b5..284f561 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -148,6 +148,7 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
 		active_v_end = active_v_start + (p->yres * hsync_period) - 1;
 
 		display_v_start += p->hsync_pulse_width + p->h_back_porch;
+		display_v_end   -= p->h_front_porch; 
 
 		active_hctl = (active_h_end << 16) | active_h_start;
 		display_hctl = active_hctl;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

