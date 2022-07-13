Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA72C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jul 2022 08:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiGMIMg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jul 2022 04:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiGMIMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134A8E95E8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A20B2619D6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE501C3411E;
        Wed, 13 Jul 2022 08:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=jsZox1/hS+Rp3roCl4CQZXK0GfImJ8rOe0DamxNA7YA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BqpZ6D1y4nYBKKFKDkDRktPZB0oi7scya5HlbvCHEM6NrHTIrFwgtrhmohbaUIASf
         E0srcJoOLQO43CMmQu/KtHr69R7lprThRt8aCU/Iam08rQKEYl8OZuMFFJH/i2Q/OW
         guM/xLpHMoD2Zc4RYGeY/KjNYH3KqCVi6Wm8nHtf/hOVC6ax2M5YbRZ6CZWhyY14an
         vDSy/BBXQgPXYBWRetWN0EJh6rCJeu+bp99OfzkGT7w+uYV63HYvFkMjKpIhV19H7v
         dthp5V8oCzAC5bpiTmhUemfoHZ0IEzl2sswqix5YadwAGEBxmwFKeSHXGynZ5hygey
         UotWi6sQAK3VA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTx-004ztO-Kf;
        Wed, 13 Jul 2022 09:12:29 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Juha-Pekka=20Heikkil=C3=A4?= 
        <juha-pekka.heikkila@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/39] drm/i915: intel_fb: fix a kernel-doc issue with Sphinx
Date:   Wed, 13 Jul 2022 09:12:04 +0100
Message-Id: <5647d7b6ffe47f53b90342e4ad881d4d4e6b005b.1657699522.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657699522.git.mchehab@kernel.org>
References: <cover.1657699522.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't use %foo[<something>] as this produces a bad markup.
Use instead, the emphasis markup directly.

Fix this issue:
	Documentation/gpu/i915:136: ./drivers/gpu/drm/i915/display/intel_fb.c:280: WARNING: Inline strong start-string without end-string.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/display/intel_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i915/display/intel_fb.c
index b191915ab351..fe72c75a9c79 100644
--- a/drivers/gpu/drm/i915/display/intel_fb.c
+++ b/drivers/gpu/drm/i915/display/intel_fb.c
@@ -276,7 +276,7 @@ lookup_format_info(const struct drm_format_info formats[],
  * @cmd: FB add command structure
  *
  * Returns:
- * Returns the format information for @cmd->pixel_format specific to @cmd->modifier[0],
+ * Returns the format information for @cmd->pixel_format specific to **cmd->modifier[0]**,
  * or %NULL if the modifier doesn't override the format.
  */
 const struct drm_format_info *
-- 
2.36.1

