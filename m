Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7905CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 14:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiCIOH3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 09:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiCIOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:07:27 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2962917CC74
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:06:27 -0800 (PST)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KDDV54sYWzdb2D;
        Wed,  9 Mar 2022 22:05:01 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 9 Mar
 2022 22:06:23 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <bbhushan2@marvell.com>,
        <bbudiredla@marvell.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] perf/marvell: cn10k Fix build error without CONFIG_OF
Date:   Wed, 9 Mar 2022 22:06:17 +0800
Message-ID: <20220309140617.33860-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/perf/marvell_cn10k_ddr_pmu.c:723:21: error: ‘cn10k_ddr_pmu_of_match’ undeclared here (not in a function); did you mean ‘cn10k_ddr_pmu_driver’?
    	 .of_match_table = cn10k_ddr_pmu_of_match,
      	                   ^~~~~~~~~~~~~~~~~~~~~~

Use of_match_ptr() to fix this.

Fixes: 7cf83e222bce ("perf/marvell: CN10k DDR performance monitor support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/perf/marvell_cn10k_ddr_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 7f3146e71f99..665b382a0ee3 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -720,7 +720,7 @@ MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
 static struct platform_driver cn10k_ddr_pmu_driver = {
 	.driver	= {
 		.name   = "cn10k-ddr-pmu",
-		.of_match_table = cn10k_ddr_pmu_of_match,
+		.of_match_table = of_match_ptr(cn10k_ddr_pmu_of_match),
 		.suppress_bind_attrs = true,
 	},
 	.probe		= cn10k_ddr_perf_probe,
-- 
2.17.1

