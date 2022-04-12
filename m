Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB6FC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 15:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356959AbiDLPV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 11:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355806AbiDLPVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:21:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A12F5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:19:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id 77FE01F44909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649776739;
        bh=GrofPaVaAIh/vGpNqrDMDcYhEYMfkIf09BP3sK/sbsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l16RXCAWZ2wE+/K5GAoKEQePqYBubGdxR1nlh1DFB1CeO6ePMaDn9+EsS/IMZDHMn
         SGe5cbSEVOoZ/TpLD8tV4vMSMb7r1R3ManQqkC3YtiuFx8BlPnZXYRWnExy8JHT7uM
         EP4qJWq1f5t4dj9mhXAf2T/iUY2SJvE6ZDB+zEi6oEZAnaY2DZy6ucdaBIi2X+5wLo
         YEV4yKkbFDqQj+cqpaNj03FL9sJVOB+ueHAy+J54P9xWS6rqW1uG0k+PY0X3kHHt8u
         6aMa8RqKwGWj59D3Lfxj4Xo44a7udQTxNeSCutlOv5XxsGNdYMstxBfCvP7WserWdG
         r8GWM7oEyTWag==
From:   Robert Beckett <bob.beckett@collabora.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Robert Beckett <bob.beckett@collabora.com>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] drm/i915: sanitize mem_flags for stolen buffers
Date:   Tue, 12 Apr 2022 15:18:35 +0000
Message-Id: <20220412151838.1298956-3-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220412151838.1298956-1-bob.beckett@collabora.com>
References: <20220412151838.1298956-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stolen regions are not page backed or considered iomem.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
index 358f8a1a30ce..9fe8132de3b2 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
@@ -122,8 +122,9 @@ void i915_ttm_adjust_gem_after_move(struct drm_i915_gem_object *obj)
 
 	obj->mem_flags &= ~(I915_BO_FLAG_STRUCT_PAGE | I915_BO_FLAG_IOMEM);
 
-	obj->mem_flags |= i915_ttm_cpu_maps_iomem(bo->resource) ? I915_BO_FLAG_IOMEM :
-		I915_BO_FLAG_STRUCT_PAGE;
+	if (obj->mm.region->id != INTEL_REGION_STOLEN_SMEM)
+		obj->mem_flags |= i915_ttm_cpu_maps_iomem(bo->resource) ? I915_BO_FLAG_IOMEM :
+			I915_BO_FLAG_STRUCT_PAGE;
 
 	cache_level = i915_ttm_cache_level(to_i915(bo->base.dev), bo->resource,
 					   bo->ttm);
-- 
2.25.1

