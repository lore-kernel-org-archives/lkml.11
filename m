Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7AAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 08:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiEXIiB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 04:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiEXIhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:37:54 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3927E1DE
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:37:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VEHJJLh_1653381467;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VEHJJLh_1653381467)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 May 2022 16:37:50 +0800
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
Subject: [PATCH 1/2] drm/i915/gvt: Fix kernel-doc
Date:   Tue, 24 May 2022 16:37:33 +0800
Message-Id: <20220524083733.67148-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220524083733.67148-1-jiapeng.chong@linux.alibaba.com>
References: <20220524083733.67148-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following W=1 kernel warnings:

drivers/gpu/drm/i915/gvt/handlers.c:3066: warning: expecting prototype
for intel_t_default_mmio_write(). Prototype was for
intel_vgpu_default_mmio_write() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/i915/gvt/handlers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/gvt/handlers.c
index beea5895e499..9c8dde079cb4 100644
--- a/drivers/gpu/drm/i915/gvt/handlers.c
+++ b/drivers/gpu/drm/i915/gvt/handlers.c
@@ -3052,7 +3052,7 @@ int intel_vgpu_default_mmio_read(struct intel_vgpu *vgpu, unsigned int offset,
 }
 
 /**
- * intel_t_default_mmio_write - default MMIO write handler
+ * intel_vgpu_default_mmio_write() - default MMIO write handler
  * @vgpu: a vGPU
  * @offset: access offset
  * @p_data: write data buffer
-- 
2.20.1.7.g153144c

