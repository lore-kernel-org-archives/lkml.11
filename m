Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC75C43217
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 14:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378450AbiBUOwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:52:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378419AbiBUOwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:52:25 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A6D13D70;
        Mon, 21 Feb 2022 06:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645455122; x=1676991122;
  h=from:to:cc:subject:date:message-id;
  bh=0r70U4Ls0HL3+dHw7RRmyaZy44+ZP9FEugYbM/LwvYU=;
  b=wT/DnJ4JrG9uxvsNDHKnfYR24S4zlE+ekx2Lv10vuWK23PdvPAR+yEYW
   b7BzyjIfwgvnhNu9qDUfTb9tGLPKHxfpe/SrFIAOA2sGw2OYxaDaJCq2t
   pxo7mDeLbI5Jl8H0/EOzZcZe/eisQHd5fOvbxmg1JEh072fTvKvjyjpHC
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 21 Feb 2022 06:52:01 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Feb 2022 06:51:59 -0800
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Feb 2022 20:21:32 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id AAA7E5392; Mon, 21 Feb 2022 20:21:31 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        robdclark@gmail.com, seanpaul@chromium.org, swboyd@chromium.org,
        dianders@chromium.org, krzysztof.kozlowski@canonical.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        quic_kalyant@quicinc.com, quic_sbillaka@quicinc.com,
        quic_vproddut@quicinc.com
Subject: [PATCH v2 0/4] Add PSR support for eDP
Date:   Mon, 21 Feb 2022 20:21:22 +0530
Message-Id: <1645455086-9359-1-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***

Vinod Polimera (4):
  drm/msm/dp: Add basic PSR support for eDP
  drm/bridge: use atomic enable/disable for bridge callbacks
  drm/msm/disp/dpu1: use atomic enable/disable callbacks for encoder
    functions
  drm/msm/disp/dpu1: add PSR support for eDP interface in dpu driver

 drivers/gpu/drm/bridge/panel.c              | 102 ++++++++++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  31 ++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  40 ++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |   2 +-
 drivers/gpu/drm/msm/dp/dp_catalog.c         |  81 +++++++++++++
 drivers/gpu/drm/msm/dp/dp_catalog.h         |   4 +
 drivers/gpu/drm/msm/dp/dp_ctrl.c            |  63 ++++++++++
 drivers/gpu/drm/msm/dp/dp_ctrl.h            |   3 +
 drivers/gpu/drm/msm/dp/dp_display.c         |  14 +++
 drivers/gpu/drm/msm/dp/dp_display.h         |   1 +
 drivers/gpu/drm/msm/dp/dp_drm.c             | 177 +++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/dp/dp_link.c            |  22 ++++
 drivers/gpu/drm/msm/dp/dp_panel.c           |  21 ++++
 drivers/gpu/drm/msm/dp/dp_panel.h           |   6 +
 drivers/gpu/drm/msm/dp/dp_reg.h             |  19 +++
 drivers/gpu/drm/msm/msm_drv.h               |   6 +
 16 files changed, 568 insertions(+), 24 deletions(-)

-- 
2.7.4

