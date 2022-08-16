Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D17CC32773
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 15:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbiHPPih (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 11:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiHPPiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:38:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D1D832C9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:37:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B2FC53447D;
        Tue, 16 Aug 2022 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660664221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gNfCdwnnFn6WP3zSQvQR767pRHdkMgh+nnbzkBNqUUA=;
        b=JG17ll6BKuFE9hr0n20eFMEvFWSibaXe3JbUEGaYTtFOFC/7jGWEx9RBnn2jDBgn8P7v+R
        uWOv6qeDsuygNZ8o82XNE9lwbUrplduSidwIohNQ0zq9UEZYE4iA0VqpBqCr/4KzaFOlrp
        QzwuCNJ25WwjeMUSMz1XwqWrH9DEcuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660664221;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gNfCdwnnFn6WP3zSQvQR767pRHdkMgh+nnbzkBNqUUA=;
        b=BadSQu/rfCPmy5DcjKCPhLuVrRXs34xpknAglG++9ZxYSavyGxEYFBd4wGfjP9TUxPmbu8
        EcgISNrb1eOei0DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BB66139B7;
        Tue, 16 Aug 2022 15:37:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cCpMGZ25+2LKJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 16 Aug 2022 15:37:01 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] drm/udl: Enable damage clipping
Date:   Tue, 16 Aug 2022 17:36:46 +0200
Message-Id: <20220816153655.27526-4-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220816153655.27526-1-tiwai@suse.de>
References: <20220816153655.27526-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Zimmermann <tzimmermann@suse.de>

Call drm_plane_enable_fb_damage_clips() and give userspace a chance
of minimizing the updated display area.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/udl/udl_modeset.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index df987644fb5d..187aba2d7825 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -484,6 +484,7 @@ int udl_modeset_init(struct drm_device *dev)
 					   format_count, NULL, connector);
 	if (ret)
 		return ret;
+	drm_plane_enable_fb_damage_clips(&udl->display_pipe.plane);
 
 	drm_mode_config_reset(dev);
 
-- 
2.35.3

