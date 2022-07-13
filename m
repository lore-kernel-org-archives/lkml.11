Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2529FCCA483
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jul 2022 08:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiGMIOg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jul 2022 04:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbiGMIMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29347E95C6;
        Wed, 13 Jul 2022 01:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 392FE61AAF;
        Wed, 13 Jul 2022 08:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE29C36AEA;
        Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=D2LxZ78g6KDBC/CMbWumQNrCFMx8aT2KZzd7m3ganoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JFmyheZZzvR/p6NXxErVn4aN09V0ju3UJzqi1N0oOHCB4AyRh4XDggRsCGtrkvJIi
         9iG/XJ/uEC0KDoGZjheq/86bH3+LaCidlbLn1U/foMz32pc0qJqGe7dHdMdzbzHIyZ
         0hwJu5epQ/GF2dvrgMPwqGV/urrXj1DoaenWKdVnAefnDmZzioetL1tza91Dekm+Z6
         LUfxfk5OuAMk61zLbBovigzRYLHFjoCHlV749eTbVGhKWCx0qsH4MFzYimOZ8YvF8K
         lTweu9y+3I/TGLwvH5zfqRHUJzd3Ft5hDVivFo8NXQjCduBW+XCBqBW4yJp4gYkJXJ
         HlR0LPX/5fuhg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTx-004zuN-VO;
        Wed, 13 Jul 2022 09:12:29 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 32/39] docs: gpu: i915.rst: GVT: add more kernel-doc markups
Date:   Wed, 13 Jul 2022 09:12:20 +0100
Message-Id: <7711d6d694def4129e9c2d2c8d507e62d8cc1519.1657699522.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657699522.git.mchehab@kernel.org>
References: <cover.1657699522.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several documented GVT kAPI that aren't currently part
of the docs. Add them, as this allows identifying issues with
badly-formatted tags.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

 Documentation/gpu/i915.rst | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index 70f2f4826eba..3ee121a0ea62 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -58,6 +58,47 @@ Intel GVT-g Host Support(vGPU device model)
 .. kernel-doc:: drivers/gpu/drm/i915/intel_gvt.c
    :internal:
 
+Other Intel GVT-g interfaces
+----------------------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/gvt.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/aperture_gm.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/cfg_space.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/debugfs.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/display.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/edid.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/fb_decoder.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/firmware.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/gtt.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/handlers.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/interrupt.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/kvmgt.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/intel_gvt_mmio_table.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/mmio.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/mmio_context.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/opregion.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/page_track.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/scheduler.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/vgpu.c
+
 Workarounds
 -----------
 
-- 
2.36.1

