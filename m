Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDF3C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 07:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiFBHfk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 03:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiFBHfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:35:31 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85F638DA1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:35:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VF9ffSI_1654155321;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VF9ffSI_1654155321)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jun 2022 15:35:27 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     zhenyuw@linux.intel.com
Cc:     zhi.a.wang@intel.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/i915/gvt: Fix kernel-doc
Date:   Thu,  2 Jun 2022 15:35:19 +0800
Message-Id: <20220602073519.22363-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following W=1 kernel warnings:

drivers/gpu/drm/i915/gvt/aperture_gm.c:308: warning: expecting prototype
for inte_gvt_free_vgpu_resource(). Prototype was for
intel_vgpu_free_resource() instead.

drivers/gpu/drm/i915/gvt/aperture_gm.c:344: warning: expecting prototype
for intel_alloc_vgpu_resource(). Prototype was for
intel_vgpu_alloc_resource() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/i915/gvt/aperture_gm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/aperture_gm.c b/drivers/gpu/drm/i915/gvt/aperture_gm.c
index 557f3314291a..3b81a6d35a7b 100644
--- a/drivers/gpu/drm/i915/gvt/aperture_gm.c
+++ b/drivers/gpu/drm/i915/gvt/aperture_gm.c
@@ -298,7 +298,7 @@ static int alloc_resource(struct intel_vgpu *vgpu,
 }
 
 /**
- * inte_gvt_free_vgpu_resource - free HW resource owned by a vGPU
+ * intel_vgpu_free_resource() - free HW resource owned by a vGPU
  * @vgpu: a vGPU
  *
  * This function is used to free the HW resource owned by a vGPU.
@@ -328,7 +328,7 @@ void intel_vgpu_reset_resource(struct intel_vgpu *vgpu)
 }
 
 /**
- * intel_alloc_vgpu_resource - allocate HW resource for a vGPU
+ * intel_vgpu_alloc_resource() - allocate HW resource for a vGPU
  * @vgpu: vGPU
  * @param: vGPU creation params
  *
-- 
2.20.1.7.g153144c

