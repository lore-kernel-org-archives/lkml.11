Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01FEC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 02:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357643AbiCYCFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 22:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbiCYCFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:05:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BC26579A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 19:03:34 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KPlhQ2tjHzfZg5;
        Fri, 25 Mar 2022 10:01:58 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 10:03:32 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <emma@anholt.net>, <mripard@kernel.org>, <maxime@cerno.tech>,
        <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>, <tangyizhou@huawei.com>
Subject: [PATCH v2 -next] drm/vc4: Fix build error when CONFIG_DRM_VC4=y && CONFIG_RASPBERRYPI_FIRMWARE=m
Date:   Fri, 25 Mar 2022 10:18:31 +0800
Message-ID: <20220325021831.2812735-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DRM_VC4=y, CONFIG_RASPBERRYPI_FIRMWARE=m, CONFIG_COMPILE_TEST=n,
bulding fails:

drivers/gpu/drm/vc4/vc4_drv.o: In function `vc4_drm_bind':
vc4_drv.c:(.text+0x320): undefined reference to `rpi_firmware_get'
vc4_drv.c:(.text+0x320): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `rpi_firmware_get'
vc4_drv.c:(.text+0x34c): undefined reference to `rpi_firmware_property'
vc4_drv.c:(.text+0x34c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `rpi_firmware_property'
vc4_drv.c:(.text+0x354): undefined reference to `rpi_firmware_put'
vc4_drv.c:(.text+0x354): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `rpi_firmware_put'

Make DRM_VC4 depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST to fix this.

Fixes: c406ad5e4a85 ("drm/vc4: Notify the firmware when DRM is in charge")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
v2: follow Maxime's advise, add RASPBERRYPI_FIRMWARE as an additional depends
 drivers/gpu/drm/vc4/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
index de3424fed2fc..92d74ba7c449 100644
--- a/drivers/gpu/drm/vc4/Kconfig
+++ b/drivers/gpu/drm/vc4/Kconfig
@@ -2,6 +2,7 @@
 config DRM_VC4
 	tristate "Broadcom VC4 Graphics"
 	depends on ARCH_BCM || ARCH_BCM2835 || COMPILE_TEST
+	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST
 	depends on DRM
 	depends on SND && SND_SOC
 	depends on COMMON_CLK
--
2.31.1

