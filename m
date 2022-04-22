Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A9EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Apr 2022 02:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443261AbiDVCFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Apr 2022 22:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiDVCFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:05:43 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE26B4A92D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:02:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VAjaRr2_1650592960;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0VAjaRr2_1650592960)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Apr 2022 10:02:48 +0800
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shile Zhang <shile.zhang@linux.alibaba.com>
Subject: [PATCH v2] coresight: etm4x: return 0 instead of using local ret variable
Date:   Fri, 22 Apr 2022 10:02:39 +0800
Message-Id: <20220422020239.37186-1-shile.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.33.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function etm4_remove_dev() always return 0, and the former function
etm4_remove has been changed to void in commit 3fd269e74f2fe ("amba: Make
the remove callback return void"). But now its changed back to int type
for some reason, which is different to the stable branch linux-5.10.y.

Just let it return void and return 0 directly in it's caller function
etm4_remove_platform_dev.

Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
---
v2: re-work the commit log from Mathieu's suggestion.
v1: https://lore.kernel.org/linux-arm-kernel/20220421164217.GB1596562@p14s/T/
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 7f416a12000eb..141f8209a152a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -2104,7 +2104,7 @@ static void clear_etmdrvdata(void *info)
 	etmdrvdata[cpu] = NULL;
 }
 
-static int __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
+static void __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
 {
 	etm_perf_symlink(drvdata->csdev, false);
 	/*
@@ -2125,8 +2125,6 @@ static int __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
 
 	cscfg_unregister_csdev(drvdata->csdev);
 	coresight_unregister(drvdata->csdev);
-
-	return 0;
 }
 
 static void __exit etm4_remove_amba(struct amba_device *adev)
@@ -2139,13 +2137,14 @@ static void __exit etm4_remove_amba(struct amba_device *adev)
 
 static int __exit etm4_remove_platform_dev(struct platform_device *pdev)
 {
-	int ret = 0;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
 
 	if (drvdata)
-		ret = etm4_remove_dev(drvdata);
+		etm4_remove_dev(drvdata);
+
 	pm_runtime_disable(&pdev->dev);
-	return ret;
+
+	return 0;
 }
 
 static const struct amba_id etm4_ids[] = {
-- 
2.33.0.rc2

