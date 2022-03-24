Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D35C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 11:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347848AbiCXLi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 07:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiCXLi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:38:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B2AA66FA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:37:25 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KPNQF6qnszBrb3;
        Thu, 24 Mar 2022 19:33:25 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 24 Mar
 2022 19:37:22 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <andrzej.hajda@intel.com>, <narmstrong@baylibre.com>,
        <robert.foss@linaro.org>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <tangyizhou@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH -next] drm/bridge: it6505: Fix build error without DRM_DP_HELPER
Date:   Thu, 24 Mar 2022 19:52:21 +0800
Message-ID: <20220324115221.1676625-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If DRM_DP_HELPER is not set, bulding fails:

ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_link_training_work':
ite-it6505.c:(.text+0x50d8): undefined reference to `drm_dp_dpcd_write'
ld: ite-it6505.c:(.text+0x51c4): undefined reference to `drm_dp_link_train_clock_recovery_delay'
ld: ite-it6505.c:(.text+0x51d7): undefined reference to `drm_dp_dpcd_read_link_status'
ld: ite-it6505.c:(.text+0x51ec): undefined reference to `drm_dp_clock_recovery_ok'
ld: ite-it6505.c:(.text+0x5387): undefined reference to `drm_dp_get_adjust_request_voltage'
ld: ite-it6505.c:(.text+0x539d): undefined reference to `drm_dp_get_adjust_request_pre_emphasis'
ld: ite-it6505.c:(.text+0x5548): undefined reference to `drm_dp_link_train_channel_eq_delay'
ld: ite-it6505.c:(.text+0x555b): undefined reference to `drm_dp_dpcd_read_link_status'
ld: ite-it6505.c:(.text+0x5570): undefined reference to `drm_dp_clock_recovery_ok'
ld: ite-it6505.c:(.text+0x558d): undefined reference to `drm_dp_channel_eq_ok'
ld: ite-it6505.c:(.text+0x55da): undefined reference to `drm_dp_get_adjust_request_voltage'
ld: ite-it6505.c:(.text+0x55f2): undefined reference to `drm_dp_get_adjust_request_pre_emphasis'
ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_bridge_detect':
ite-it6505.c:(.text+0x59f1): undefined reference to `drm_dp_dpcd_read'
ld: ite-it6505.c:(.text+0x5a16): undefined reference to `drm_dp_bw_code_to_link_rate'
ld: ite-it6505.c:(.text+0x5a87): undefined reference to `drm_dp_dpcd_read'
ld: ite-it6505.c:(.text+0x5ac1): undefined reference to `drm_dp_dpcd_write'
ld: ite-it6505.c:(.text+0x5d43): undefined reference to `drm_dp_link_rate_to_bw_code'

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 007e5a282f67..2145b08f9534 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -78,6 +78,7 @@ config DRM_ITE_IT6505
         tristate "ITE IT6505 DisplayPort bridge"
         depends on OF
         select DRM_KMS_HELPER
+        select DRM_DP_HELPER
         select EXTCON
         help
           ITE IT6505 DisplayPort bridge chip driver.
--
2.31.1

