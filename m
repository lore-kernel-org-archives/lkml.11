Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C1EC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 11:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiGLLdY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 07:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGLLdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:33:22 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A855F3055E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wEU2lTn9Et2NuCEAD/mh5qm1lTrzHU1EEy9+K85JA9Q=; b=NjkuiZBoiv7GYDCOZcqDj1LzSW
        4uXGSLWVxvl/PhM4mAGxyB+nznXEVFWK9noxhnajgWwCVxtRbzqAx6Z+Uuk14nY06ehEs9J6zSsHI
        /d9XZLwp6OtLe8ohk35iiVu3WjimV9GBWAJmzIkeW1ycOtb/paeIZ6Z7n6m5nSzFF/rUmCAzu4mhZ
        YfFMTTAbqOeqwt51vOn9XwlZr71YQ+rj6hPicpwDjb/zrVPIuDDA1PhmdW+zN5Zyc8HxaTOgDwVSu
        5IXOY6fwCvwgIUOoahZ30E4lNNnKqMzRtunRuUYPoTfctoDC50VfkRtrf0+Ahwh46Sn1fdTCztl1c
        t5+gCvJQ==;
Received: from [165.90.126.25] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oBE8U-00DMlP-Kb; Tue, 12 Jul 2022 13:33:02 +0200
From:   Melissa Wen <mwen@igalia.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     Sungjoon.Kim@amd.com, kernel-dev@igalia.com,
        Melissa Wen <mwen@igalia.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: correct check of coverage blend mode
Date:   Tue, 12 Jul 2022 10:32:39 -0100
Message-Id: <20220712113239.132905-1-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the value of per_pixel_alpha to decide whether the Coverage pixel
blend mode is applicable or not.

Fixes: 76818cdd11a2 ("drm/amd/display: add Coverage blend mode for overlay plane")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index de1c139ae279..25cb833b267c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5486,7 +5486,7 @@ fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
 			}
 		}
 
-		if (per_pixel_alpha && plane_state->pixel_blend_mode == DRM_MODE_BLEND_COVERAGE)
+		if (*per_pixel_alpha && plane_state->pixel_blend_mode == DRM_MODE_BLEND_COVERAGE)
 			*pre_multiplied_alpha = false;
 	}
 
-- 
2.35.1

