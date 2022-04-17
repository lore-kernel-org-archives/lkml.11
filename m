Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B1AC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Apr 2022 22:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbiDQWkj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Apr 2022 18:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbiDQWkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 18:40:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D69017060
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 15:37:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 5248A1F40EAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650235064;
        bh=rykbT46970dnwG8XD3/7UFJ4mDKmg/KtVkYLQH0qBew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oPg0HT0thRSQzIa+PIXu6dflLcXf9zuLjyoieAJBynHGL+oQMRB6utM+a5pMj/f4g
         Rme1KrWqiTCbTIFSyglqaZ4MGOs8ynq78J4of14vb9NGpMywp6DLLtLsqIxZbG0w5J
         rz0AGjJSJMSCr/E8PSbCUc/krtAD/MtXqq9OErI2HxwbFK/iZoSP251oDpJgNJH61d
         oqoaq+Oz0ZnlUmW/4Am+Wvlu3dDg6WN5KIfV/iOXOFUnYAoO0/j2ay34s3y+rztWwe
         t2jVYwuWWE19m14k4P7gzGN5P/SQQJHUtByonbn1mB6/hv+B3ILsW7fPat30cx641s
         o80sV30HJIX7A==
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
Subject: [PATCH v4 09/15] drm/shmem-helper: Correct doc-comment of drm_gem_shmem_get_sg_table()
Date:   Mon, 18 Apr 2022 01:37:01 +0300
Message-Id: <20220417223707.157113-10-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220417223707.157113-1-dmitry.osipenko@collabora.com>
References: <20220417223707.157113-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_gem_shmem_get_sg_table() never returns NULL on error, but a ERR_PTR.
Correct the doc comment which says that it returns NULL on error.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 8ad0e02991ca..30ee46348a99 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -662,7 +662,7 @@ EXPORT_SYMBOL(drm_gem_shmem_print_info);
  * drm_gem_shmem_get_pages_sgt() instead.
  *
  * Returns:
- * A pointer to the scatter/gather table of pinned pages or NULL on failure.
+ * A pointer to the scatter/gather table of pinned pages or errno on failure.
  */
 struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem)
 {
@@ -688,7 +688,8 @@ EXPORT_SYMBOL_GPL(drm_gem_shmem_get_sg_table);
  * drm_gem_shmem_get_sg_table() should not be directly called by drivers.
  *
  * Returns:
- * A pointer to the scatter/gather table of pinned pages or errno on failure.
+ * A pointer to the scatter/gather table of pinned pages ERR_PTR()-encoded
+ * error code on failure.
  */
 struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem)
 {
-- 
2.35.1

