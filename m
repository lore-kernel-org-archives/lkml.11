Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85912C433FE
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Apr 2022 22:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiDQWkM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Apr 2022 18:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiDQWkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 18:40:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F0217054
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 15:37:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id CF5AD1F40EAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650235049;
        bh=wczZ5iN2wkFP7L3LjYkS8mg7jidJdoFxxHCwNVCzNBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KQxBh9VnkNFyViiSMyZoARIdz0dWSt92DPFlfvHgkOPS/m9PhC1Bf/+Es17Jb5NVM
         t3nUSfDknsJpE2aHgLFYIIuYB0ev9vcbC1VWOQea+kX74MubPnGEXPFT62Pv2ye91c
         W41KEFx3T5DX2kvXWyk4W6Xd12acKUPl0lnk+fPxeRorZfsr5Br6fCo3VnuNZhUsPt
         8gskDBwv6q7JCa+5F6AUElJgAmYlyXCuNZkFbvc7eH5cKwHc5zHaEPGbByEqx7cvO4
         msWchXzEcI0+CCAb0sPqRanH+Y2GmeDrxnV+AekdzNW2vw90kUIvOF29STbNERPXjG
         r01/MF9VtUVdg==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v4 01/15] drm/virtio: Correct drm_gem_shmem_get_sg_table() error handling
Date:   Mon, 18 Apr 2022 01:36:53 +0300
Message-Id: <20220417223707.157113-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220417223707.157113-1-dmitry.osipenko@collabora.com>
References: <20220417223707.157113-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_gem_shmem_get_sg_table() never ever returned NULL on error. Correct
the error handling to avoid crash on OOM.

Cc: stable@vger.kernel.org
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index f293e6ad52da..3d0c8d4d1c20 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -168,9 +168,11 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
 	 * since virtio_gpu doesn't support dma-buf import from other devices.
 	 */
 	shmem->pages = drm_gem_shmem_get_sg_table(&bo->base);
-	if (!shmem->pages) {
+	ret = PTR_ERR_OR_ZERO(shmem->pages);
+	if (ret) {
 		drm_gem_shmem_unpin(&bo->base);
-		return -EINVAL;
+		shmem->pages = NULL;
+		return ret;
 	}
 
 	if (use_dma_api) {
-- 
2.35.1

