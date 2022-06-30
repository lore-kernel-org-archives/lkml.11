Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE00C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 20:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbiF3UBj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiF3UBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:01:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407954132B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:01:29 -0700 (PDT)
Received: from dimapc.. (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A1BAD660196E;
        Thu, 30 Jun 2022 21:01:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656619287;
        bh=bHY/wTGdwNWE0vfGLvjwkTXQsLLmekm4lElw1VQe+qg=;
        h=From:To:Cc:Subject:Date:From;
        b=C60CRvbq0hfB7n3bN1cYPypQwLwwD8bMj1QffeZcO3HLV02fCbeRi+MWt6G0RZjJA
         7USBZyoYH/ZEBIEUcl3QS5W+vxjgA8IhEXQJ7jABbKZYc2W7LcV6EO5fVn2am4M7VP
         OiHMPYJB0cqC+WSvFtGp/VNiiSsvVKkQQ2MwL0NBNKlT3ZPulCSZquXVfDSBa3AoKT
         jmhVOaQnltFq29FfqSKuNp1po4HqvUW3qMHxXXGJAx8zn6nOh05rSwo+2S25ffyA2K
         iA+2tycDexEXe3A9/wD8uFhSB5QWCKRmmpTXfvC5DfsrZ5EZMBDcsgf9hqOIfFREoh
         Pw/M4RjO27/xg==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com
Subject: [PATCH v7 0/2] DRM-SHMEM fixes
Date:   Thu, 30 Jun 2022 23:00:56 +0300
Message-Id: <20220630200058.1883506-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes two minor problems in the DRM-SHMEM helper.

Changelog:

v7: - Factored out DRM-SHMEM fixes from [1] since I'll be working on
      the dma-buf locking in a separate patchset now.

[1] https://lore.kernel.org/all/20220526235040.678984-1-dmitry.osipenko@collabora.com/

Dmitry Osipenko (2):
  drm/shmem-helper: Add missing vunmap on error
  drm/shmem-helper: Correct doc-comment of drm_gem_shmem_get_sg_table()

 drivers/gpu/drm/drm_gem_shmem_helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.36.1

