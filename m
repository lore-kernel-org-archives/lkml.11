Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF88C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 09:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbiEYJhV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 05:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237722AbiEYJhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:37:12 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0876EA454
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 02:37:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VEN0eTg_1653471423;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VEN0eTg_1653471423)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 May 2022 17:37:07 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amdgpu: make program_imu_rlc_ram static
Date:   Wed, 25 May 2022 17:37:02 +0800
Message-Id: <20220525093702.57166-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is not used outside of imu_v11_0.c, so marks it
static.

Fixes the following w1 warning:

drivers/gpu/drm/amd/amdgpu/imu_v11_0.c:302:6: warning: no previous
prototype for ‘program_imu_rlc_ram’ [-Wmissing-prototypes].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index 5d2dfeff8fe5..d63d3f2b8a16 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -299,7 +299,7 @@ static const struct imu_rlc_ram_golden imu_rlc_ram_golden_11_0_2[] =
 	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCPG_PSP_DEBUG, CPG_PSP_DEBUG__GPA_OVERRIDE_MASK, 0)
 };
 
-void program_imu_rlc_ram(struct amdgpu_device *adev,
+static void program_imu_rlc_ram(struct amdgpu_device *adev,
 				const struct imu_rlc_ram_golden *regs,
 				const u32 array_size)
 {
-- 
2.20.1.7.g153144c

