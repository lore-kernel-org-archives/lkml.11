Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12466C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jan 2022 07:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiAMHLl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jan 2022 02:11:41 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:49978 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230301AbiAMHLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 02:11:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V1im.pj_1642057896;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V1im.pj_1642057896)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jan 2022 15:11:37 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     airlied@linux.ie, Guchun.Chen@amd.com
Cc:     daniel@ffwll.ch, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/2 v2] drm/amdgpu: clean up some inconsistent indenting
Date:   Thu, 13 Jan 2022 15:11:32 +0800
Message-Id: <20220113071132.70647-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220113071132.70647-1-yang.lee@linux.alibaba.com>
References: <20220113071132.70647-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:3504 amdgpu_device_init()
warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1716
amdgpu_ras_error_status_query() warn: if statement not indented
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1058 amdgpu_ras_error_inject()
warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 33388041c354..64d6c0af4c76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3499,7 +3499,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->notifier_lock);
 	mutex_init(&adev->pm.stable_pstate_ctx_lock);
 
-	 amdgpu_device_init_apu_flags(adev);
+	amdgpu_device_init_apu_flags(adev);
 
 	r = amdgpu_device_check_arguments(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ff9bd5a844fe..6d84749698c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1055,8 +1055,10 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 		.address = info->address,
 		.value = info->value,
 	};
-    int ret = -EINVAL;
-    struct amdgpu_ras_block_object* block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, info->head.sub_block_index);
+	int ret = -EINVAL;
+	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev,
+							info->head.block,
+							info->head.sub_block_index);
 
 	if (!obj)
 		return -EINVAL;
@@ -1714,7 +1716,7 @@ static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
 	}
 
 	if (block_obj->hw_ops->query_ras_error_status)
-	block_obj->hw_ops->query_ras_error_status(adev);
+		block_obj->hw_ops->query_ras_error_status(adev);
 
 }
 
-- 
2.20.1.7.g153144c

