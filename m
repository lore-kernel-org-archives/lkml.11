Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249E6C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 18:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245653AbiFMSeS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240768AbiFMSeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:34:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C802BC9671
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:53:51 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LMDyG6wVxzRhyT;
        Mon, 13 Jun 2022 22:50:30 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 13 Jun
 2022 22:53:45 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <andrzej.hajda@intel.com>, <narmstrong@baylibre.com>,
        <robert.foss@linaro.org>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <angelogioacchino.delregno@collabora.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>, <gaochao49@huawei.com>
Subject: [PATCH -next] drm/bridge: it6505: Add missing CRYPTO_HASH dependency
Date:   Mon, 13 Jun 2022 23:06:53 +0800
Message-ID: <20220613150653.1310029-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses crypto hash functions so it needs to select CRYPTO_HASH.
This fixes build errors:

drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_hdcp_wait_ksv_list':
ite-it6505.c:(.text+0x4c26): undefined reference to `crypto_alloc_shash'
ite-it6505.c:(.text+0x4c6d): undefined reference to `crypto_shash_digest'
ite-it6505.c:(.text+0x4c7d): undefined reference to `crypto_destroy_tfm'
ite-it6505.c:(.text+0x4d69): undefined reference to `crypto_destroy_tfm'

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/gpu/drm/bridge/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 8ffd601e68f9..1afe99dac0ff 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -94,6 +94,8 @@ config DRM_ITE_IT6505
         select DRM_KMS_HELPER
         select DRM_DP_HELPER
         select EXTCON
+        select CRYPTO
+        select CRYPTO_HASH
         help
           ITE IT6505 DisplayPort bridge chip driver.

--
2.31.1

