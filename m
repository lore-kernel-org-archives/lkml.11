Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FF5C352AA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 20:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347317AbiEPT5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 15:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347049AbiEPTvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:51:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6EF2F3;
        Mon, 16 May 2022 12:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACF6660A1C;
        Mon, 16 May 2022 19:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B414AC385AA;
        Mon, 16 May 2022 19:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652730412;
        bh=ZY7r6g2FfkeLnQCs4ZNZ/uMW7ITBX/uqL8DkAAxNV/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dV8cbEWylOI8KUphbznskEaEtq2/j/9Mgnx3DupxdytXHBIkgzheATatPB8tadN8N
         UA7xhQpjdjvDSh8nFG4nIODcihNT5DbryGvREKzsaEDWC/huyjRfMxURgLWh6qgd2K
         JCGftmJyuJLE9V0fteDNAvqGIVY2+sQ9nAimylY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zack Rusin <zackr@vmware.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Martin Krastev <krastevm@vmware.com>,
        Maaz Mombasawala <mombasawalam@vmware.com>
Subject: [PATCH 5.10 57/66] drm/vmwgfx: Initialize drm_mode_fb_cmd2
Date:   Mon, 16 May 2022 21:36:57 +0200
Message-Id: <20220516193621.059771631@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516193619.400083785@linuxfoundation.org>
References: <20220516193619.400083785@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zack Rusin <zackr@vmware.com>

commit 3059d9b9f6aa433a55b9d0d21b566396d5497c33 upstream.

Transition to drm_mode_fb_cmd2 from drm_mode_fb_cmd left the structure
unitialized. drm_mode_fb_cmd2 adds a few additional members, e.g. flags
and modifiers which were never initialized. Garbage in those members
can cause random failures during the bringup of the fbcon.

Initializing the structure fixes random blank screens after bootup due
to flags/modifiers mismatches during the fbcon bring up.

Fixes: dabdcdc9822a ("drm/vmwgfx: Switch to mode_cmd2")
Signed-off-by: Zack Rusin <zackr@vmware.com>
Cc: Daniel Vetter <daniel.vetter@intel.com>
Cc: <stable@vger.kernel.org> # v4.10+
Reviewed-by: Martin Krastev <krastevm@vmware.com>
Reviewed-by: Maaz Mombasawala <mombasawalam@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20220302152426.885214-7-zack@kde.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
@@ -498,7 +498,7 @@ static int vmw_fb_kms_detach(struct vmw_
 
 static int vmw_fb_kms_framebuffer(struct fb_info *info)
 {
-	struct drm_mode_fb_cmd2 mode_cmd;
+	struct drm_mode_fb_cmd2 mode_cmd = {0};
 	struct vmw_fb_par *par = info->par;
 	struct fb_var_screeninfo *var = &info->var;
 	struct drm_framebuffer *cur_fb;


