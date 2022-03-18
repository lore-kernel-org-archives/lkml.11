Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDD4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 09:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbiCRJp5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 05:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiCRJpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:45:54 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C511286F77
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:44:36 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KKfBz5m8jz9sg4;
        Fri, 18 Mar 2022 17:40:43 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 17:44:34 +0800
Received: from huawei.com (10.175.112.125) by dggpemm500018.china.huawei.com
 (7.185.36.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 17:44:34 +0800
From:   Yue Zou <zouyue3@huawei.com>
To:     <stuyoder@gmail.com>, <laurentiu.tudor@nxp.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] bus: fsl-mc: simplify DPMCP version check
Date:   Fri, 18 Mar 2022 10:03:44 +0000
Message-ID: <20220318100344.4030432-1-zouyue3@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The minimum supported DPMCP version is 3.0, and the second
half of version check is always false due to the limited range
of minor version's unsigned data type. Just remove the second
check to simplify the condition.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yue Zou <zouyue3@huawei.com>
---
 drivers/bus/fsl-mc/mc-io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
index 95b10a6cf307..f6a8b3b9ba3c 100644
--- a/drivers/bus/fsl-mc/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -193,9 +193,7 @@ int __must_check fsl_mc_portal_allocate(struct fsl_mc_device *mc_dev,
 	error = -EINVAL;
 	dpmcp_dev = resource->data;
 
-	if (dpmcp_dev->obj_desc.ver_major < DPMCP_MIN_VER_MAJOR ||
-	    (dpmcp_dev->obj_desc.ver_major == DPMCP_MIN_VER_MAJOR &&
-	     dpmcp_dev->obj_desc.ver_minor < DPMCP_MIN_VER_MINOR)) {
+	if (dpmcp_dev->obj_desc.ver_major < DPMCP_MIN_VER_MAJOR) {
 		dev_err(&dpmcp_dev->dev,
 			"ERROR: Version %d.%d of DPMCP not supported.\n",
 			dpmcp_dev->obj_desc.ver_major,
-- 
2.18.0.huawei.25

