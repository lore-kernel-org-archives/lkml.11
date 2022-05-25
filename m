Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2455C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 08:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbiEYInN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 04:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiEYInL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:43:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4012459A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:43:09 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L7Pgz4fv7zgY8l;
        Wed, 25 May 2022 16:42:07 +0800 (CST)
Received: from huawei.com (10.67.174.157) by kwepemi500014.china.huawei.com
 (7.221.188.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 16:43:07 +0800
From:   Li Zhengyu <lizhengyu3@huawei.com>
To:     <alexander.shishkin@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] intel_th: Remove unused variable
Date:   Wed, 25 May 2022 16:41:29 +0800
Message-ID: <20220525084129.105609-1-lizhengyu3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.157]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a753bfcfdb1f ("intel_th: Make the switch allocate its subdevices")
factored out intel_th_subdevice_alloc() from intel_th_populate(), (!req)
is always true. When (!req) is been removed, variable 'req' is unused.

Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
---
After commit a753bfcfdb1f, whether intel_th_request_hub_module() has been 
called or not, it will always been called when (subdev->type == INTEL_TH_SWITCH) 
is true. I'm not sure if it's fine.

 drivers/hwtracing/intel_th/core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 7e753a75d23b..59885b05220e 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -618,7 +618,6 @@ intel_th_subdevice_alloc(struct intel_th *th,
 {
 	struct intel_th_device *thdev;
 	struct resource res[3];
-	unsigned int req = 0;
 	int r, err;
 
 	thdev = intel_th_device_alloc(th, subdev->type, subdev->name,
@@ -686,11 +685,8 @@ intel_th_subdevice_alloc(struct intel_th *th,
 		goto fail_free_res;
 
 	/* need switch driver to be loaded to enumerate the rest */
-	if (subdev->type == INTEL_TH_SWITCH && !req) {
-		err = intel_th_request_hub_module(th);
-		if (!err)
-			req++;
-	}
+	if (subdev->type == INTEL_TH_SWITCH)
+		intel_th_request_hub_module(th);
 
 	return thdev;
 
-- 
2.17.1

