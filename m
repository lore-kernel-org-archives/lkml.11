Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCB5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 06:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351933AbiFNGat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 02:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352125AbiFNGaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:30:39 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EAB37A25
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:30:37 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LMdmj5W6tz1K9tw;
        Tue, 14 Jun 2022 14:28:37 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 14 Jun
 2022 14:30:33 +0800
From:   Peng Wu <wupeng58@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>, <wupeng58@huawei.com>
Subject: [PATCH] drm: logicvc: Add missing of_node_put() in logicvc_drm_config_parse()
Date:   Tue, 14 Jun 2022 06:24:56 +0000
Message-ID: <20220614062456.56189-1-wupeng58@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500023.china.huawei.com (7.221.188.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_child_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Signed-off-by: Peng Wu <wupeng58@huawei.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
---
 drivers/gpu/drm/logicvc/logicvc_drm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logicvc/logicvc_drm.c
index df1805cf0f95..73d51a8b693e 100644
--- a/drivers/gpu/drm/logicvc/logicvc_drm.c
+++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
@@ -136,8 +136,10 @@ static int logicvc_drm_config_parse(struct logicvc_drm *logicvc)
 	if (!config->layers_count) {
 		drm_err(drm_dev,
 			"Missing a non-optional layers children node\n");
+		of_node_put(layers_node);
 		return -EINVAL;
 	}
+	of_node_put(layers_node);
 
 	return 0;
 }
-- 
2.17.1

