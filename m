Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E276C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jul 2022 10:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbiGYKqE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jul 2022 06:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbiGYKqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:46:01 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED03313
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:46:00 -0700 (PDT)
Received: from alisa-ThinkPad-T440s.. (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id D00E440D403D;
        Mon, 25 Jul 2022 10:45:56 +0000 (UTC)
From:   Alisa Khabibrakhmanova <khabibrakhmanova@ispras.ru>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Alisa Khabibrakhmanova <khabibrakhmanova@ispras.ru>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] drm/via: Add new condition to via_dma_cleanup()
Date:   Mon, 25 Jul 2022 13:45:55 +0300
Message-Id: <20220725104555.124044-1-khabibrakhmanova@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer dev_priv->mmio, which was checked for NULL at via_do_init_map(),
is passed to via_do_cleanup_map() and is dereferenced there without check.

The patch adds the condition in via_dma_cleanup() which prevents potential NULL
pointer dereference.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 22f579c621e2 ("drm: Add via unichrome support")
Signed-off-by: Alisa Khabibrakhmanova <khabibrakhmanova@ispras.ru>
---
 drivers/gpu/drm/via/via_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/via/via_dma.c b/drivers/gpu/drm/via/via_dma.c
index 177b0499abf1..56bcbbf4ed54 100644
--- a/drivers/gpu/drm/via/via_dma.c
+++ b/drivers/gpu/drm/via/via_dma.c
@@ -164,7 +164,7 @@ int via_dma_cleanup(struct drm_device *dev)
 		drm_via_private_t *dev_priv =
 		    (drm_via_private_t *) dev->dev_private;
 
-		if (dev_priv->ring.virtual_start) {
+		if (dev_priv->ring.virtual_start && dev_priv->mmio) {
 			via_cmdbuf_reset(dev_priv);
 
 			drm_legacy_ioremapfree(&dev_priv->ring.map, dev);
-- 
2.34.1

