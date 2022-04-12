Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0933C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 19:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351182AbiDLTlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 15:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiDLTkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:40:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CD92F396
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:38:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id 8986A1F419AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649792314;
        bh=GrofPaVaAIh/vGpNqrDMDcYhEYMfkIf09BP3sK/sbsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kI1hU9Asv2e1sq6tDoucznk5+wlEMkMTBplx1amLaHmRFyxwtv3mvSjFYB6WF9ybw
         KPqpflOqD0TK/zgXsgqFYRo6roIRgMQWyCo6fDmnkWPdp1KrcfIUf4Mgos/Y9xFeKU
         ti00qLSAmGitT0NNg5OdWKZ0ua8B4qwWRRFzHK9U/jKWIPqxYsDLAeCFmUMwse8glA
         HkAdSRCSTTCTxw65A1hh1jdHDWenO8oLDwtc+MWQOglXh/t8d73r4t+5npHgJXFcr2
         wezKyEVDjBJf1jsEGkAWnlYujgwjBd9TJMaFu3l6DsKWt4MLtNtfjpMPXadPuUWPi5
         HWEkmQ9zdCp5Q==
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
Subject: [PATCH v3 2/5] drm/i915: sanitize mem_flags for stolen buffers
Date:   Tue, 12 Apr 2022 19:38:13 +0000
Message-Id: <20220412193817.2098308-3-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220412193817.2098308-1-bob.beckett@collabora.com>
References: <20220412193817.2098308-1-bob.beckett@collabora.com>
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

