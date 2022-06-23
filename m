Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C92AC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 13:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiFWNzI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 09:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiFWNzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:55:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9BA34674
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:55:04 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LTMCg2Mk4zdfd2;
        Thu, 23 Jun 2022 21:53:19 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 21:55:02 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 23 Jun
 2022 21:55:01 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     <paul.kocialkowski@bootlin.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <mripard@kernel.org>
Subject: [PATCH -next] drm/logicvc: Fix error return code in logicvc_layer_init()
Date:   Thu, 23 Jun 2022 22:05:07 +0800
Message-ID: <20220623140507.626062-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix error return code when logicvc_layer_formats_lookup() fails.

Fixes: efeeaefe9be5 ("drm: Add support for the LogiCVC display controller")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/gpu/drm/logicvc/logicvc_layer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.c b/drivers/gpu/drm/logicvc/logicvc_layer.c
index fbebe966f93a..54b5931d879f 100644
--- a/drivers/gpu/drm/logicvc/logicvc_layer.c
+++ b/drivers/gpu/drm/logicvc/logicvc_layer.c
@@ -489,6 +489,7 @@ static int logicvc_layer_init(struct logicvc_drm *logicvc,
 
 	formats = logicvc_layer_formats_lookup(layer);
 	if (!formats) {
+		ret = -EINVAL;
 		drm_err(drm_dev, "Failed to lookup formats for layer #%d\n",
 			index);
 		goto error;
-- 
2.25.1

