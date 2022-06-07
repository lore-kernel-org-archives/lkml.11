Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA23C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 22:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383600AbiFGWMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 18:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378725AbiFGVJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:09:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC6D213E43;
        Tue,  7 Jun 2022 11:51:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A95BB822C0;
        Tue,  7 Jun 2022 18:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBB4C385A2;
        Tue,  7 Jun 2022 18:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654627862;
        bh=ooRjUvmGJzzu/siEDXfgX0wur8PrGZ7/pd2kHQ/UvyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EBk4j5UmYfj/W4AuAlj2t2riqr/z4rfZJLrs9jWz4fZEk8on5MbpcQ/AveJOsT/E5
         +/FtsI/UNz+0Q6R1ChtlgSBCyg7B3cmB8AUX3C0ag1C+gKumExsWVHXiY/qy1RBZJ1
         0Vhoq7j1nOxSw1K6RP6+PGgBCKlduIPXkpPnNuLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 121/879] drm/msm/dpu: Clean up CRC debug logs
Date:   Tue,  7 Jun 2022 18:53:59 +0200
Message-Id: <20220607165006.213077149@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607165002.659942637@linuxfoundation.org>
References: <20220607165002.659942637@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jessica Zhang <quic_jesszhan@quicinc.com>

[ Upstream commit 3ce8bdca394fc606b55e7c5ed779d171aaae5d09 ]

Currently, dpu_hw_lm_collect_misr returns EINVAL if CRC is disabled.
This causes a lot of spam in the DRM debug logs as it's called for every
vblank.

Instead of returning EINVAL when CRC is disabled in
dpu_hw_lm_collect_misr, let's return ENODATA and add an extra ENODATA check
before the debug log in dpu_crtc_get_crc.

Changes since V1:
- Added reported-by and suggested-by tags

Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Suggested-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Tested-by: Jessica Zhang <quic_jesszhan@quicinc.com> # RB5  (qrb5165)
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/484274/
Link: https://lore.kernel.org/r/20220430005210.339-1-quic_jesszhan@quicinc.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  | 3 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 7763558ef566..16ba9f9b9a78 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -204,7 +204,8 @@ static int dpu_crtc_get_crc(struct drm_crtc *crtc)
 		rc = m->hw_lm->ops.collect_misr(m->hw_lm, &crcs[i]);
 
 		if (rc) {
-			DRM_DEBUG_DRIVER("MISR read failed\n");
+			if (rc != -ENODATA)
+				DRM_DEBUG_DRIVER("MISR read failed\n");
 			return rc;
 		}
 	}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
index 86363c0ec834..462f5082099e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
@@ -138,7 +138,7 @@ static int dpu_hw_lm_collect_misr(struct dpu_hw_mixer *ctx, u32 *misr_value)
 	ctrl = DPU_REG_READ(c, LM_MISR_CTRL);
 
 	if (!(ctrl & LM_MISR_CTRL_ENABLE))
-		return -EINVAL;
+		return -ENODATA;
 
 	if (!(ctrl & LM_MISR_CTRL_STATUS))
 		return -EINVAL;
-- 
2.35.1



