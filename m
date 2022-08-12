Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC58C00140
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Aug 2022 11:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbiHLLbu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Aug 2022 07:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiHLLbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 07:31:48 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA6EADCCE
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 04:31:47 -0700 (PDT)
Received: from andrey-lpc.intra.ispras.ru (unknown [93.175.1.152])
        by mail.ispras.ru (Postfix) with ESMTPSA id 1767F40737BA;
        Fri, 12 Aug 2022 11:31:43 +0000 (UTC)
From:   Andrey Strachuk <strochuk@ispras.ru>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Andrey Strachuk <strochuk@ispras.ru>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH v3] drm/fb-helper: add virtual screen size check to drm_fb_helper_check_var()
Date:   Fri, 12 Aug 2022 14:30:07 +0300
Message-Id: <20220812113007.224880-1-strochuk@ispras.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that virtual screen size is not less than physical screen one.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
---
 drivers/gpu/drm/drm_fb_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 2d4cee6a10ff..ea07c97bc5a9 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1355,6 +1355,12 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 	    (drm_format_info_block_height(fb->format, 0) > 1))
 		return -EINVAL;
 
+	/* make sure that virtual resolution >= physical resolution */
+	if (var->xres_virtual < var->xres)
+		var->xres_virtual = var->xres;
+	if (var->yres_virtual < var->yres)
+		var->yres_virtual = var->yres;
+
 	/*
 	 * Changes struct fb_var_screeninfo are currently not pushed back
 	 * to KMS, hence fail if different settings are requested.
-- 
2.25.1

