Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E790C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 11:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiBPLkw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 06:40:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiBPLks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:40:48 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31E56D4FD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:40:35 -0800 (PST)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JzGCG1wcFz8wl5;
        Wed, 16 Feb 2022 19:37:14 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 16 Feb
 2022 19:40:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <Xinhui.Pan@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Hawking.Zhang@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amdgpu: Remove unused function get_umc_v6_7_channel_index()
Date:   Wed, 16 Feb 2022 19:40:13 +0800
Message-ID: <20220216114013.15192-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is unused after commit 37ff945f804c ("drm/amdgpu: fix convert bad page retiremt")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index f5a1ba7db75a..00f87e3c6b0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -50,13 +50,6 @@ static inline uint32_t get_umc_v6_7_reg_offset(struct amdgpu_device *adev,
 	return adev->umc.channel_offs * ch_inst + UMC_V6_7_INST_DIST * umc_inst;
 }
 
-static inline uint32_t get_umc_v6_7_channel_index(struct amdgpu_device *adev,
-					      uint32_t umc_inst,
-					      uint32_t ch_inst)
-{
-	return adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
-}
-
 static void umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device *adev,
 						   uint32_t umc_inst, uint32_t ch_inst,
 						   unsigned long *error_count)
-- 
2.17.1

