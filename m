Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F99C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 01:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiCCBxM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 20:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiCCBxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:53:08 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DCF32065
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:52:20 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V64pKc2_1646272336;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V64pKc2_1646272336)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Mar 2022 09:52:17 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     airlied@linux.ie
Cc:     daniel@ffwll.ch, Xinhui.Pan@amd.com, christian.koenig@amd.com,
        alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/amdgpu: clean up some inconsistent indenting
Date:   Thu,  3 Mar 2022 09:52:15 +0800
Message-Id: <20220303015215.92536-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:
drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:413 amdgpu_get_xgmi_hive()
warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 91817a31f3e1..4ff6e06babca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -410,14 +410,14 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 	 */
 	if (adev->reset_domain->type != XGMI_HIVE) {
 		hive->reset_domain = amdgpu_reset_create_reset_domain(XGMI_HIVE, "amdgpu-reset-hive");
-			if (!hive->reset_domain) {
-				dev_err(adev->dev, "XGMI: failed initializing reset domain for xgmi hive\n");
-				ret = -ENOMEM;
-				kobject_put(&hive->kobj);
-				kfree(hive);
-				hive = NULL;
-				goto pro_end;
-			}
+		if (!hive->reset_domain) {
+			dev_err(adev->dev, "XGMI: failed initializing reset domain for xgmi hive\n");
+			ret = -ENOMEM;
+			kobject_put(&hive->kobj);
+			kfree(hive);
+			hive = NULL;
+			goto pro_end;
+		}
 	} else {
 		amdgpu_reset_get_reset_domain(adev->reset_domain);
 		hive->reset_domain = adev->reset_domain;
-- 
2.20.1.7.g153144c

