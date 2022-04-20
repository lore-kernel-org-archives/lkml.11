Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB8AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Apr 2022 05:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354234AbiDTFbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 01:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiDTFbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 01:31:34 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1579F36319
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 22:28:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VAYbcYg_1650432513;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0VAYbcYg_1650432513)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Apr 2022 13:28:45 +0800
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shile Zhang <shile.zhang@linux.alibaba.com>
Subject: [PATCH] coresight: etm4x: return 0 instead of using local ret variable
Date:   Wed, 20 Apr 2022 13:28:31 +0800
Message-Id: <20220420052831.78566-1-shile.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.33.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The etm4_remove function (now it's rename to etm4_remove_dev) always
return 0, and it has been changed to void in commit 4fd269e74f2f
("amba: Make the remove callback return void"). But its weird that the
changes is gone in mainline. which is remained in 5.10.y branch.

Just backport the changes of etm4_remove_dev and return 0 directly in it's
caller function etm4_remove_platform_dev.

Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 7f416a12000e..141f8209a152 100644
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

