Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCC5C4321E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353097AbiDEMW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 08:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245011AbiDEIxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:53:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF82CD9;
        Tue,  5 Apr 2022 01:49:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C06161504;
        Tue,  5 Apr 2022 08:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366FDC385A1;
        Tue,  5 Apr 2022 08:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148559;
        bh=LVVgoah1FFD2uGXo9sEwOMtgTBJf1uME5I17THO9hX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QZNRkvo9lq/lMRO9eoehU1CzNe+YsZZJroLhcqcZpQRfXvEqurwCC3tBIa7oP0vnk
         ATQaQnsa9BT+1S3lTEgqOGiF6AFnGwhq7saaLMlpvKI+sxNOiW4JLBp7xUzHdReP3/
         pHCJ9pY8WXtg3V2eyunqWMfYTVztORt6Zncg295g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0400/1017] drm/meson: Fix error handling when afbcd.ops->init fails
Date:   Tue,  5 Apr 2022 09:21:53 +0200
Message-Id: <20220405070406.159335692@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit fa747d75f65d1b1cbc3f4691fa67b695e8a399c8 ]

When afbcd.ops->init fails we need to free the struct drm_device. Also
all errors which come after afbcd.ops->init was successful need to exit
the AFBCD, just like meson_drv_unbind() does.

Fixes: d1b5e41e13a7e9 ("drm/meson: Add AFBCD module driver")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20211230235515.1627522-3-martin.blumenstingl@googlemail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/meson/meson_drv.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 45bfe9451db8..c98525d60df5 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -302,42 +302,42 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	if (priv->afbcd.ops) {
 		ret = priv->afbcd.ops->init(priv);
 		if (ret)
-			return ret;
+			goto free_drm;
 	}
 
 	/* Encoder Initialization */
 
 	ret = meson_venc_cvbs_create(priv);
 	if (ret)
-		goto free_drm;
+		goto exit_afbcd;
 
 	if (has_components) {
 		ret = component_bind_all(drm->dev, drm);
 		if (ret) {
 			dev_err(drm->dev, "Couldn't bind all components\n");
-			goto free_drm;
+			goto exit_afbcd;
 		}
 	}
 
 	ret = meson_encoder_hdmi_init(priv);
 	if (ret)
-		goto free_drm;
+		goto exit_afbcd;
 
 	ret = meson_plane_create(priv);
 	if (ret)
-		goto free_drm;
+		goto exit_afbcd;
 
 	ret = meson_overlay_create(priv);
 	if (ret)
-		goto free_drm;
+		goto exit_afbcd;
 
 	ret = meson_crtc_create(priv);
 	if (ret)
-		goto free_drm;
+		goto exit_afbcd;
 
 	ret = request_irq(priv->vsync_irq, meson_irq, 0, drm->driver->name, drm);
 	if (ret)
-		goto free_drm;
+		goto exit_afbcd;
 
 	drm_mode_config_reset(drm);
 
@@ -355,6 +355,9 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 
 uninstall_irq:
 	free_irq(priv->vsync_irq, drm);
+exit_afbcd:
+	if (priv->afbcd.ops)
+		priv->afbcd.ops->exit(priv);
 free_drm:
 	drm_dev_put(drm);
 
-- 
2.34.1



