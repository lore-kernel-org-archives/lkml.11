Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D16CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jan 2022 13:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242589AbiARNlY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jan 2022 08:41:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37198 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242424AbiARNlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:41:17 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 950F51F43F4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642513276;
        bh=IPtBzMiKepEmzjvtX9sO6tEJL6k0DuE+x1vV5p8WYvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WIzFqSVDaIt7gohiINlfy6Mgyaj46ala6Hdgnd9yNMpBnOYHg6uZQJIbwyC1vL7oP
         vhNmMf2oylYAyhmDbMaflelPUCI8iv310tQ9wjTZKsOJOp84ZoQ9UJAKl5CmA25+Rf
         HkxZKXl7icfZGc82z+CQiAElg2k+XhQF2EDofbb09/lE7g0SK/Vkl/EMB2nQny/8rL
         YrnaMlGBuiw69QHt5wEVIMwxh2CaHe/CwO7MyMzZf5k0vXGzfSSm9KYWC4qWRaEZO5
         YLhr1neFX+N49nkfRCldq98afbc55Zy4V41fGX6Uhi9ilLg3XZEgTkHXJ1iAybdopz
         Lyui61qx0K8rQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/2] drm: mediatek: mtk_drm_crtc: Use kmalloc in mtk_drm_crtc_duplicate_state
Date:   Tue, 18 Jan 2022 14:37:59 +0100
Message-Id: <20220118133759.112458-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118133759.112458-1-angelogioacchino.delregno@collabora.com>
References: <20220118133759.112458-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize mtk_drm_crtc_duplicate_state() by switching from kzalloc() to
kmalloc(): the only variable of this struct that gets checked in other
functions is `pending_config`, but if that's set to false, then all of
the remaining variables will only ever be set, but not read - so, also
set `pending_config` to false.
This saves us some small overhead.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 09fc9ad02c7a..f536a0a927e4 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -185,7 +185,7 @@ static struct drm_crtc_state *mtk_drm_crtc_duplicate_state(struct drm_crtc *crtc
 {
 	struct mtk_crtc_state *state;
 
-	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	state = kmalloc(sizeof(*state), GFP_KERNEL);
 	if (!state)
 		return NULL;
 
@@ -193,6 +193,7 @@ static struct drm_crtc_state *mtk_drm_crtc_duplicate_state(struct drm_crtc *crtc
 
 	WARN_ON(state->base.crtc != crtc);
 	state->base.crtc = crtc;
+	state->pending_config = false;
 
 	return &state->base;
 }
-- 
2.33.1

