Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E464C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 08:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiEWI56 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 04:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiEWI5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:57:55 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9D224F0A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:57:49 -0700 (PDT)
Received: from kwepemi100011.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L6B6y390YzDqMK;
        Mon, 23 May 2022 16:57:46 +0800 (CST)
Received: from kwepemm600018.china.huawei.com (7.193.23.140) by
 kwepemi100011.china.huawei.com (7.221.188.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 16:57:47 +0800
Received: from huawei.com (10.174.176.88) by kwepemm600018.china.huawei.com
 (7.193.23.140) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 16:57:47 +0800
From:   gaochao <gaochao49@huawei.com>
To:     <thierry.reding@gmail.com>, <sam@ravnborg.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>
CC:     <dianders@chromium.org>, <seanpaul@chromium.org>,
        <zhengbin13@huawei.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drm/panel: Fix build error when CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=y && CONFIG_DRM_DISPLAY_HELPER=m
Date:   Mon, 23 May 2022 16:57:45 +0800
Message-ID: <20220523085745.276-1-gaochao49@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600018.china.huawei.com (7.193.23.140)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=y && CONFIG_DRM_DISPLAY_HELPER=m,
bulding fails:

drivers/gpu/drm/panel/panel-samsung-atna33xc20.o: In function `atana33xc20_probe':
panel-samsung-atna33xc20.c:(.text+0x744): undefined reference to
 `drm_panel_dp_aux_backlight'
make: *** [vmlinux] Error 1

Let CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 select DRM_DISPLAY_DP_HELPER and
CONFIG_DRM_DISPLAY_HELPER to fix this error.

Fixes: 32ce3b320343 ("drm/panel: atna33xc20: Introduce the Samsung ATNA33XC20 panel")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: gaochao <gaochao49@huawei.com>
---
 drivers/gpu/drm/panel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 38799effd00a..4f1f004b3c54 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -438,6 +438,8 @@ config DRM_PANEL_SAMSUNG_ATNA33XC20
 	depends on OF
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on PM
+	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_HELPER
 	select DRM_DP_AUX_BUS
 	help
 	  DRM panel driver for the Samsung ATNA33XC20 panel. This panel can't
--
2.17.1

