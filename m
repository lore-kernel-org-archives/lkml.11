Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D21C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 08:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348963AbiBHIPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346563AbiBHIPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:15:32 -0500
X-Greylist: delayed 17989 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 00:15:30 PST
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662A7C0401F4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:15:29 -0800 (PST)
X-QQ-mid: bizesmtp42t1644308115tsb4qzql
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 08 Feb 2022 16:14:48 +0800 (CST)
X-QQ-SSF: 01400000002000B0H000C00A0000000
X-QQ-FEAT: hR9GyqeohSjJ8poqEfqqfnQTm/zs80/Vvjqy3T/4wc9YCPiMLqXp+q7NtT8gq
        rBF86DoPBxWUSHh6M7tGkbrjEV4exoR3cDiP+Fgqnvjt7QYXsJhFmDrNC+5/blVoVT6j2mr
        q6rdCYI5tCYGFAUFA5vzkdrIyLJ3oeVWdq2BEVrlzvhcPjuw3wthJqKfGBCRsBCMWYA2K6s
        sTpCm9fIx/jWgLCSiSHL/FvnWMP83g6UDg5ugiohu+Qs1hYW6T/0i0qE3SAAkkH02Y6jk7W
        fMeALM6EAU3sLiFqF8tApujMI2Kv1Ridm4xcWinHPeONPg+8ek3CYgFKkA/PJTfvCKy3iS1
        5n7VLvRzEMOx2A4YD+xxVB06Qkazk9bdE7ybf/qqYf014oxXAs=
X-QQ-GoodBg: 2
From:   zhanglianjie <zhanglianjie@uniontech.com>
To:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        PanXinhui <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhanglianjie <zhanglianjie@uniontech.com>
Subject: [PATCH v4 2/2] drm/radeon/uvd: Fix forgotten unmap buffer objects
Date:   Tue,  8 Feb 2022 16:14:43 +0800
Message-Id: <20220208081443.28210-1-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

after the buffer object is successfully mapped, call radeon_bo_kunmap before the function returns.

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
Reviewed-by: Christian König <christian.koenig@amd.com>

diff --git a/drivers/gpu/drm/radeon/radeon_uvd.c b/drivers/gpu/drm/radeon/radeon_uvd.c
index 377f9cdb5b53..0558d928d98d 100644
--- a/drivers/gpu/drm/radeon/radeon_uvd.c
+++ b/drivers/gpu/drm/radeon/radeon_uvd.c
@@ -497,6 +497,7 @@ static int radeon_uvd_cs_msg(struct radeon_cs_parser *p, struct radeon_bo *bo,
 	handle = msg[2];

 	if (handle == 0) {
+		radeon_bo_kunmap(bo);
 		DRM_ERROR("Invalid UVD handle!\n");
 		return -EINVAL;
 	}
@@ -559,12 +560,10 @@ static int radeon_uvd_cs_msg(struct radeon_cs_parser *p, struct radeon_bo *bo,
 		return 0;

 	default:
-
 		DRM_ERROR("Illegal UVD message type (%d)!\n", msg_type);
-		return -EINVAL;
 	}

-	BUG();
+	radeon_bo_kunmap(bo);
 	return -EINVAL;
 }

--
2.20.1



