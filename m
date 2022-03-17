Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558EDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 09:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiCQJtA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 05:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiCQJs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:48:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C2E1D8332
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:47:35 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KK2Ly2Nx7z921l;
        Thu, 17 Mar 2022 17:45:30 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 17:47:31 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <andrzej.hajda@intel.com>, <narmstrong@baylibre.com>,
        <robert.foss@linaro.org>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <hermes.wu@ite.com.tw>, <allen.chen@ite.com.tw>,
        <angelogioacchino.delregno@collabora.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/bridge: it6505: Fix build error
Date:   Thu, 17 Mar 2022 17:47:24 +0800
Message-ID: <20220317094724.25972-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If DRM_ITE_IT6505 is y but DRM_DP_HELPER is m, building failed:

drivers/gpu/drm/bridge/ite-it6505.o: In function `it6505_i2c_remove':
ite-it6505.c:(.text+0x35c): undefined reference to `drm_dp_aux_unregister'
drivers/gpu/drm/bridge/ite-it6505.o: In function `it6505_dpcd_read':
ite-it6505.c:(.text+0x420): undefined reference to `drm_dp_dpcd_read'
drivers/gpu/drm/bridge/ite-it6505.o: In function `it6505_get_dpcd':
ite-it6505.c:(.text+0x4a4): undefined reference to `drm_dp_dpcd_read'
drivers/gpu/drm/bridge/ite-it6505.o: In function `it6505_dpcd_write':
ite-it6505.c:(.text+0x52c): undefined reference to `drm_dp_dpcd_write'

Select DRM_DP_HELPER for DRM_ITE_IT6505 to fix this.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index c86f5be4dfe0..1b8721a7a6df 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -78,6 +78,7 @@ config DRM_DISPLAY_CONNECTOR
 config DRM_ITE_IT6505
         tristate "ITE IT6505 DisplayPort bridge"
         depends on OF
+	select DRM_DP_HELPER
         select DRM_KMS_HELPER
         select EXTCON
         help
-- 
2.17.1

