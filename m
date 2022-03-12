Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B4FC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 06:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiCLGgB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Mar 2022 01:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiCLGf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 01:35:57 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB07C12E745
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 22:34:52 -0800 (PST)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KFtJz5LhLzBrjh;
        Sat, 12 Mar 2022 14:32:51 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 12 Mar
 2022 14:34:49 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <javierm@redhat.com>,
        <yuehaibing@huawei.com>, <maxime@cerno.tech>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drm/solomon: Make DRM_SSD130X depends on MMU
Date:   Sat, 12 Mar 2022 14:34:37 +0800
Message-ID: <20220312063437.19160-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
  Depends on [n]: HAS_IOMEM [=y] && DRM [=m] && MMU [=n]
  Selected by [m]:
  - DRM_SSD130X [=m] && HAS_IOMEM [=y] && DRM [=m]

DRM_GEM_SHMEM_HELPER depends on MMU, DRM_SSD130X should also depends on MMU.

Fixes: a61732e80867 ("drm: Add driver for Solomon SSD130x OLED displays")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/solomon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/solomon/Kconfig b/drivers/gpu/drm/solomon/Kconfig
index 5861c3ab7c45..6230369505c9 100644
--- a/drivers/gpu/drm/solomon/Kconfig
+++ b/drivers/gpu/drm/solomon/Kconfig
@@ -1,6 +1,6 @@
 config DRM_SSD130X
 	tristate "DRM support for Solomon SSD130x OLED displays"
-	depends on DRM
+	depends on DRM && MMU
 	select BACKLIGHT_CLASS_DEVICE
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
-- 
2.17.1

