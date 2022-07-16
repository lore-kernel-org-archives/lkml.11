Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4C7C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jul 2022 01:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiGPBvT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 21:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiGPBvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 21:51:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA99175BB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 18:51:16 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LlB1Y3TdFzVfhQ;
        Sat, 16 Jul 2022 09:47:29 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Jul 2022 09:51:13 +0800
Received: from zelda.huawei.com (10.175.103.14) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Jul 2022 09:51:12 +0800
From:   Wang Jingjin <wangjingjin1@huawei.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dave.stevenson@raspberrypi.com>
CC:     <maxime@cerno.tech>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <zhengbin13@huawei.com>,
        Wang Jingjin <wangjingjin1@huawei.com>
Subject: [PATCH -next] drm/vc4: Add explicit declaration of 'drmm_of_get_bridge'
Date:   Sat, 16 Jul 2022 10:07:41 +0800
Message-ID: <20220716020741.4124893-1-wangjingjin1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.14]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the error of implicit declaration of function 'drmm_of_get_bridge':

drivers/gpu/drm/vc4/vc4_dpi.c:278:11: error: implicit declaration of function ‘drmm_of_get_bridge’; did you mean ‘devm_drm_of_get_bridge’? [-Werror=implicit-function-declaration]
  bridge = drmm_of_get_bridge(drm, dev->of_node, 0, 0);

Fixes: 055af0235aef ("drm/vc4: dpi: Switch to drmm_of_get_bridge")
Signed-off-by: Wang Jingjin <wangjingjin1@huawei.com>
---
 include/drm/drm_bridge.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index dba5d81e3b4a..6b65b0dfb4fb 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -959,6 +959,14 @@ static inline struct drm_bridge *devm_drm_of_get_bridge(struct device *dev,
 {
 	return ERR_PTR(-ENODEV);
 }
+
+static inline struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
+						     struct device_node *node,
+						     u32 port,
+						     u32 endpoint)
+{
+	return ERR_PTR(-ENODEV);
+}
 #endif

 #endif
--
2.25.1

