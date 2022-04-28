Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E04C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Apr 2022 20:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350278AbiD1UPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Apr 2022 16:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350178AbiD1UPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 16:15:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A77BAB83
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:12:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id 6CEF41F45C28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651176733;
        bh=OFZJNy5wYWNqNEPg/dD6oQZwof/EPOJOolCUKpef6b4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZC6Kdv02ijN89ohNJR9iZST0Aw3erEe2ug6OlSm26b1Jka+GF/mAhhmNuid7Wrrc8
         K3/fS36inyr3nhAhLdUk71fCR7Uk3JFqR90mtVJy6+s+gC6g0zlHHEeOwIu8HNHlb6
         vsB50VZaKT0vcyUmbMhJ7T753h1VcYWxmjpNtluFzgYNBI5n1YSP/q1o+vSFCJvbrt
         /7MdY550zJ8AldOKxT1SzeFJ/6rgjyOrFR6wLUQLKwQXooyvnDX7MdrKnrBWt87mj5
         PqMevoxI0Jca5EmZImzlqRckTb+24DEKSr0/Xftw8a83f0xkMuZlHtZ6FEhKg8gMiD
         czd0fwVVhxqUg==
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
Subject: [PATCH v5 2/6] drm/i915: sanitize mem_flags for stolen buffers
Date:   Thu, 28 Apr 2022 20:11:21 +0000
Message-Id: <20220428201125.412896-3-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220428201125.412896-1-bob.beckett@collabora.com>
References: <20220428201125.412896-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stolen regions are not page backed or considered iomem.
Prevent flags indicating such.
This correctly prevents stolen buffers from attempting to directly map
them.

See i915_gem_object_has_struct_page() and i915_gem_object_has_iomem()
usage for where it would break otherwise.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
index 358f8a1a30ce..48046cfd8c4b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
@@ -14,6 +14,7 @@
 #include "gem/i915_gem_region.h"
 #include "gem/i915_gem_ttm.h"
 #include "gem/i915_gem_ttm_move.h"
+#include "gem/i915_gem_stolen.h"
 
 #include "gt/intel_engine_pm.h"
 #include "gt/intel_gt.h"
@@ -122,8 +123,9 @@ void i915_ttm_adjust_gem_after_move(struct drm_i915_gem_object *obj)
 
 	obj->mem_flags &= ~(I915_BO_FLAG_STRUCT_PAGE | I915_BO_FLAG_IOMEM);
 
-	obj->mem_flags |= i915_ttm_cpu_maps_iomem(bo->resource) ? I915_BO_FLAG_IOMEM :
-		I915_BO_FLAG_STRUCT_PAGE;
+	if (!i915_gem_object_is_stolen(obj))
+		obj->mem_flags |= i915_ttm_cpu_maps_iomem(bo->resource) ? I915_BO_FLAG_IOMEM :
+			I915_BO_FLAG_STRUCT_PAGE;
 
 	cache_level = i915_ttm_cache_level(to_i915(bo->base.dev), bo->resource,
 					   bo->ttm);
-- 
2.25.1

