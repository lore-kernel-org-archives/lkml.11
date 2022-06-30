Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A103ECCA473
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 20:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbiF3UIK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbiF3UIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:08:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816F945074
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:07:59 -0700 (PDT)
Received: from dimapc.. (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6E55A6601979;
        Thu, 30 Jun 2022 21:07:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656619678;
        bh=ppiHU1nHxnlqhseAkxfgAUsmo7TgwderWDB16dgdP1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHH9j1FRucsL7URkdnVA9GbGKzz1VbmywQGV+6YXZ16z56JVWUG05J71sRt5/+AWm
         ct4eEUaFkVD81VdD0SyP0h5tOAdUR7+k/heSAYezF+CtRGmKAe1E/omLNVBVMsUI8K
         iGoDGoJi79E8GFRkJh1UZXp79M7JNIaGVYroqC/qgBscNyrjkKqK8g6Qzb6gxq1P+q
         KrbQ3oTT8wRttqJuitjKQrtN2zY/iHFL2ZjHksIENROJkOH4fXPBF7l82PIW0majmr
         ta2MwYWRC5fK1XMr3Jn8Cxgi8AZLC1PRqDns5CDgyF1A9jQEFS07KVdMFqpSHHvT9P
         TMRqZL5lEvwBA==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com
Subject: [PATCH v7 5/9] drm/virtio: Use appropriate atomic state in virtio_gpu_plane_cleanup_fb()
Date:   Thu, 30 Jun 2022 23:07:22 +0300
Message-Id: <20220630200726.1884320-6-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
References: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make virtio_gpu_plane_cleanup_fb() to clean the state which DRM core
wants to clean up and not the current plane's state. Normally the older
atomic state is cleaned up, but the newer state could also be cleaned up
in case of aborted commits.

Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 6d3cc9e238a4..7148f3813d8b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -266,14 +266,14 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
 }
 
 static void virtio_gpu_plane_cleanup_fb(struct drm_plane *plane,
-					struct drm_plane_state *old_state)
+					struct drm_plane_state *state)
 {
 	struct virtio_gpu_framebuffer *vgfb;
 
-	if (!plane->state->fb)
+	if (!state->fb)
 		return;
 
-	vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
+	vgfb = to_virtio_gpu_framebuffer(state->fb);
 	if (vgfb->fence) {
 		dma_fence_put(&vgfb->fence->f);
 		vgfb->fence = NULL;
-- 
2.36.1

