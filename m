Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C29C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 22:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454014AbiDEWhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 18:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391267AbiDEPeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:34:13 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5404FC4D;
        Tue,  5 Apr 2022 06:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649166109; x=1680702109;
  h=from:to:cc:subject:date:message-id;
  bh=n/LaXP9MDFd1wNqtjihKRMVq+Y8jFqhWp4guYXGha6E=;
  b=iZxEug3AHTeWe1TkuVuON+D+vg/wfImcPOrEmzUUdZbX3ZVmMBu4dXr+
   tKkERh0VtZmEg8fi7tR1XcfjTB+ubLsZZGNbfJVNP99nnYKmRaqpzcZw9
   74GFQ0wQqWCTfNjh/I6RopioX42ugZOsmNwD4iu4IPvDEYgzjRXn2nvL0
   s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 05 Apr 2022 06:41:49 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Apr 2022 06:41:48 -0700
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg02-blr.qualcomm.com with ESMTP; 05 Apr 2022 19:11:34 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 94F25551E; Tue,  5 Apr 2022 19:11:33 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dmitry.baryshkov@linaro.org, dianders@chromium.org,
        quic_kalyant@quicinc.com
Subject: [PATCH v7 0/2] Add inline rotation support for sc7280
Date:   Tue,  5 Apr 2022 19:11:29 +0530
Message-Id: <1649166091-18032-1-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in RFC:
- Rebase changes to the latest code base.
- Append rotation config variables with v2 and
remove unused variables.(Dmitry)
- Move pixel_ext setup separately from scaler3 config.(Dmitry)
- Add 270 degree rotation to supported rotation list.(Dmitry)

Changes in V2:
- Remove unused macros and fix indentation.
- Add check if 90 rotation is supported and
add supported rotations to rot_cfg.

Changes in V3:
- Fix indentation.
- Move rot_supported to sspp capabilities. (Dmitry)
- Config pixel_ext based on src_h/src_w directly. (Dmitry)
- Misc changes.

Changes in V4:
- Pass boolean value to sspp blk based on supported rotations for each hw.

Changes in V5:
- Update boolean value to true/false and add it for qcm2290.

Changes in V6:
- Add changes that are missed as part of v5.
- Add dpu_find_format inline function to find valid format. (Dmitry)

Changes in V7:
- Move dpu_find_format inline function to separate commit. (Dmitry)
- Remove rot_cfg from SSPP_BLK and use DPU_SSPP_INLINE_ROTATION caps
to append supported rotations. (Dmitry)
- Misc Changes.

Co-developed-by: Kalyan Thota <quic_kalyant@quicinc.com>
Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>

Vinod Polimera (2):
  drm/msm/disp/dpu1: add inline function to validate format support
  drm/msm/disp/dpu1: add inline rotation support for sc7280

 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.h    |  22 ++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 173 +++++++++++++++----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |  16 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c      | 139 +++++++++++++++-----
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h      |   2 +
 5 files changed, 251 insertions(+), 101 deletions(-)

-- 
2.7.4

