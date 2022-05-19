Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AE4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 17:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242146AbiESR2P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 13:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242575AbiESRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:25:36 -0400
Received: from mail.wantyapps.xyz (unknown [IPv6:2001:19f0:5:305f:5400:3ff:fe88:abd4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512A4A88AA
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:25:24 -0700 (PDT)
Received: from localhost (bzq-79-183-83-88.red.bezeqint.net [79.183.83.88])
        by mail.wantyapps.xyz (Postfix) with ESMTPSA id 41DC57D654;
        Thu, 19 May 2022 17:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wantyapps.xyz;
        s=mail; t=1652981122;
        bh=bwIKlOGYkL2L4Ao4onVXBZ5fa9b9XMy3wOyD2HdryOQ=;
        h=From:To:Cc:Subject:Date:From;
        b=oQUhwKS+DczDCMjN3HbYDbECzhCixVy+OoQ5gWsypv1yLI2z+K/H/Thbk8xn8nEbF
         45G8ezHEH3zy0jk9t3w76n96o7YtAM4cCOiorLVmsK+U7/HPTdxDb4YS2b1Scgdl8s
         SkHbRRdGryTQORDrCUDksuCfncEgXMCl9gXskbpENN4v5auzz1TrWZh5FCersqOZS6
         Q0W8NWdHL9sdiGX3MIVmIHlacYbJ09fcAM3aMIcNyKqnHSsqmeJ5SODukMgRhlBxYX
         6t+GvpZVoCCSkqwTWTOdfX2ZiX6s/IalCK+9+UlaaHZ8H1vY01bMvajC27p5Qsi1Eq
         fH1XgkGos0Vxw==
From:   Uri Arev <me@wantyapps.xyz>
Cc:     Uri Arev <me@wantyapps.xyz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Len Baker <len.baker@gmx.com>, Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Srivathsa Dara <srivathsa729.8@gmail.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: fix checkpatch.pl struct should normally be const
Date:   Thu, 19 May 2022 20:25:01 +0300
Message-Id: <20220519172503.10821-1-me@wantyapps.xyz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simple patch fixes a checkpatch.pl warning in `fbtft/fbtft-core.c`.

Reported by Checkpatch:
WARNING: struct fb_ops should normally be const

Signed-off-by: Uri Arev <me@wantyapps.xyz>
---
 drivers/staging/fbtft/fbtft-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 9c4d797e7ae4..9ff2b8230caf 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -539,7 +539,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 {
 	struct fb_info *info;
 	struct fbtft_par *par;
-	struct fb_ops *fbops = NULL;
+	const struct fb_ops *fbops = NULL;
 	struct fb_deferred_io *fbdefio = NULL;
 	u8 *vmem = NULL;
 	void *txbuf = NULL;
@@ -614,7 +614,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	if (!vmem)
 		goto alloc_fail;
 
-	fbops = devm_kzalloc(dev, sizeof(struct fb_ops), GFP_KERNEL);
+	const fbops = devm_kzalloc(dev, sizeof(struct fb_ops), GFP_KERNEL);
 	if (!fbops)
 		goto alloc_fail;
 
-- 
2.36.1

