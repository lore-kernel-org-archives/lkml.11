Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0468C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jul 2022 08:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbiGMIOS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jul 2022 04:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbiGMIMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66CAEA14E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B1B761A59
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44598C341E3;
        Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=zdFtR3cWoytYwm56KlG1FWdOeba0MwjJiuWd3av2Pxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R0ynHXK2YNdIX/lm4nws8+/JRYpub29hzCtdYGCPxeCBNWSEVBmDkpKjjY/u6rNgM
         5n82RDrrVp3Sp9qWnoHjQmVXxBWilcOhDVybbjPAsf0llJeZmh92Z+1cb4GnnbDzbr
         yk89Hrjkmq7zRJN9Ysih1075mszU3dWkzhGlTj+NYYkgH/tuUgX++e+HceUT85C7yc
         qO+ftM7roVoLpEp0MZqfKhCxRdMCVV7qSBkGf33PAwHc7He8/k6XXkOPFqaXHN3yQA
         o6ApRYabquIDvmv7OtRdpfYnMGNw+5V0NXL/qOS4F9iYiZQ40NJAKdB7IhlVHkNm68
         Hw/5w4HZLE6lA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTx-004zu3-Rg;
        Wed, 13 Jul 2022 09:12:29 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 26/39] drm/i915: i915_gem.c fix a kernel-doc issue
Date:   Wed, 13 Jul 2022 09:12:14 +0100
Message-Id: <3f512107b7c7c1bdbe3131b3a35d9cc34e29656d.1657699522.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657699522.git.mchehab@kernel.org>
References: <cover.1657699522.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent this Sphinx warning:

	Documentation/foo/i915:728: ./drivers/gpu/drm/i915/i915_gem.c:447: WARNING: Inline emphasis start-string without end-string.

By using @data to identify the data field, as expected by kernel-doc.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/i915_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 41e83d078a70..0ca4bb08ea78 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -444,7 +444,7 @@ i915_gem_gtt_pread(struct drm_i915_gem_object *obj,
  * @data: ioctl data blob
  * @file: drm file pointer
  *
- * On error, the contents of *data are undefined.
+ * On error, the contents of @data is undefined.
  */
 int
 i915_gem_pread_ioctl(struct drm_device *dev, void *data,
-- 
2.36.1

