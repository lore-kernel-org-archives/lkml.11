Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C02EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 08:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348711AbiBHIC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiBHIC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:02:56 -0500
X-Greylist: delayed 17256 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 00:02:55 PST
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36516C0401EF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:02:55 -0800 (PST)
X-QQ-mid: bizesmtp33t1644307361t10mqirs
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 08 Feb 2022 16:02:37 +0800 (CST)
X-QQ-SSF: 00400000002000B0H000B00A0000000
X-QQ-FEAT: zD6y7hNAcUB0CO7eAtJeOBqOod74zZzxKc9Z5p7I4/HrPepLCfJzCWjdo72xF
        gQZlUSwaOM05cGmmj58PWwdBNEHju8GTAvTUnuOAqnawnSBQQMYzyUeUjy3u8Hc/rfjzBcL
        Ee66Z2FskkgLFReyfCgL4+rMBCxm9KMZrSNk8hvZ41FhZQ0j+bVPh9UTUNy/FWBVE2dgxje
        07ap/9lyPyQnGQFbHOEiOb5F3/yQNStKnYkbzIXteJpKJpLHB8R7et1eU0JMjAFmmes8im8
        uMqPeuvzCr6NOSWvkzw4/qtkAi8WX0oufIDctkJTwwcZOOY9Ao6bTUOu/VSREoQ2ZhODd8y
        FN2DwSkR/lqc2673+vk6htik4RUikaU+zjxdwhR
X-QQ-GoodBg: 2
From:   zhanglianjie <zhanglianjie@uniontech.com>
To:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        PanXinhui <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhanglianjie <zhanglianjie@uniontech.com>
Subject: [PATCH v3 2/2] drm/radeon/uvd: Fix forgotten unmap buffer objects
Date:   Tue,  8 Feb 2022 16:02:35 +0800
Message-Id: <20220208080235.26349-1-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
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



