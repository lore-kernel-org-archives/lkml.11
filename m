Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B17C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 16:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348594AbiC3QGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 12:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348568AbiC3QGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:06:12 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB63C238D18;
        Wed, 30 Mar 2022 09:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648656263; x=1680192263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=7veokiquAVpHpjsy/ez/QdJmUJA8oXSsaunhV32sDhI=;
  b=lbUe/Ek+TA72my1Al3jL4n+UgjOWmUEWukNXBaFK+2otS7XalHwsIzQp
   eRpYsT7K6KpApLQJzvFxLjLiX5cVWKAzMGPSoSKiMPzFCNEM+wWp0XKSN
   d2mY4T9/IS0OqUD40DTJASLNKxpx9KvdTMYzT+2zGSLqfiCJ7OKbWDsqA
   c=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 30 Mar 2022 09:04:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 09:04:22 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 09:04:22 -0700
Received: from sbillaka-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 09:04:16 -0700
From:   Sankeerth Billakanti <quic_sbillaka@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <robdclark@gmail.com>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <quic_kalyant@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <dianders@chromium.org>,
        <quic_khsieh@quicinc.com>, <bjorn.andersson@linaro.org>,
        <sean@poorly.run>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dmitry.baryshkov@linaro.org>, <quic_vproddut@quicinc.com>,
        <quic_aravindh@quicinc.com>
Subject: [PATCH v6 8/8] drm/msm/dp: Handle eDP mode_valid differently from dp
Date:   Wed, 30 Mar 2022 21:32:59 +0530
Message-ID: <1648656179-10347-9-git-send-email-quic_sbillaka@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel-edp driver modes needs to be validated differently from DP
because the link capabilities are not available for EDP by that time.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 8bafdd0..f9c7d9a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1003,6 +1003,12 @@ enum drm_mode_status dp_bridge_mode_valid(struct drm_bridge *bridge,
 		return -EINVAL;
 	}
 
+	if (dp->connector_type == DRM_MODE_CONNECTOR_eDP) {
+		if (mode_pclk_khz > DP_MAX_PIXEL_CLK_KHZ)
+			return MODE_CLOCK_HIGH;
+		return MODE_OK;
+	}
+
 	if ((dp->max_pclk_khz <= 0) ||
 			(dp->max_pclk_khz > DP_MAX_PIXEL_CLK_KHZ) ||
 			(mode->clock > dp->max_pclk_khz))
-- 
2.7.4

