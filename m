Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C89C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 22:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350378AbiDKWDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 18:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350395AbiDKWCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:02:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE6ABC5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 15:00:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 36C7E1F43C7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649714429;
        bh=1ir1kXOoDBYMTq2gw1c/hNFv88UQm29tKUM6x3KBBGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rq9PS5kCEv+DC4Qzk/V8M7LTxLVNjUw6NtCNHBxIicMLSquM3gmFjfJ50UFUObwSR
         phhOp/VgAHafTnQ2Gt8W2HOQ9NO3QwSAmxu6pMAmTb7lJaJ/hb+GBGH7cw0qhRtOML
         iRpgWEVaWkEPXR3boR8YIMc8RDx0AC4ls7D98mIO39U5aEZPe4zkldxImrOQyjOTOr
         eNmnv2Q1Z1SYvHOw2py931IbsvaBgk09u0HBXv0vPk4jeowvGaZAnidfg54kRnRc7R
         vX1cvRPURWlCUw+RuJvXGa3tlFEosHaH6eaAi5fFcX8zmTWWZANfChOdd3KKQORbDs
         qHt4IAJtAu5QQ==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v3 08/15] drm/virtio: Use dev_is_pci()
Date:   Tue, 12 Apr 2022 00:59:30 +0300
Message-Id: <20220411215937.281655-9-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411215937.281655-1-dmitry.osipenko@collabora.com>
References: <20220411215937.281655-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common dev_is_pci() helper to replace the strcmp("pci") used by driver.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 0141b7df97ec..0035affc3e59 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -87,7 +87,7 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
 		return PTR_ERR(dev);
 	vdev->priv = dev;
 
-	if (!strcmp(vdev->dev.parent->bus->name, "pci")) {
+	if (dev_is_pci(vdev->dev.parent)) {
 		ret = virtio_gpu_pci_quirk(dev);
 		if (ret)
 			goto err_free;
-- 
2.35.1

