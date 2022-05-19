Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEEFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 07:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbiESHn0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 03:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbiESHnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:43:14 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666EFAE263
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:43:04 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L3hXt70QNzCsjD;
        Thu, 19 May 2022 15:38:06 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 15:43:02 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 15:43:02 +0800
From:   keliu <liuke94@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH 1/2] drivers/perf: Directly use ida_alloc()/free()
Date:   Thu, 19 May 2022 08:01:26 +0000
Message-ID: <20220519080127.147030-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index b1b2a55de77f..8e058e08fe81 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -611,7 +611,7 @@ static int ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
 		.dev = dev,
 	};
 
-	pmu->id = ida_simple_get(&ddr_ida, 0, 0, GFP_KERNEL);
+	pmu->id = ida_alloc(&ddr_ida, GFP_KERNEL);
 	return pmu->id;
 }
 
@@ -765,7 +765,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 cpuhp_instance_err:
 	cpuhp_remove_multi_state(pmu->cpuhp_state);
 cpuhp_state_err:
-	ida_simple_remove(&ddr_ida, pmu->id);
+	ida_free(&ddr_ida, pmu->id);
 	dev_warn(&pdev->dev, "i.MX8 DDR Perf PMU failed (%d), disabled\n", ret);
 	return ret;
 }
@@ -779,7 +779,7 @@ static int ddr_perf_remove(struct platform_device *pdev)
 
 	perf_pmu_unregister(&pmu->pmu);
 
-	ida_simple_remove(&ddr_ida, pmu->id);
+	ida_free(&ddr_ida, pmu->id);
 	return 0;
 }
 
-- 
2.25.1

