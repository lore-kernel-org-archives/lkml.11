Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA97C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 09:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344247AbiDKJOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 05:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236641AbiDKJOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:14:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AA23F8A0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:12:10 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KcNN76dFHzFpk9;
        Mon, 11 Apr 2022 17:09:43 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 17:12:07 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 17:12:06 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <vijayb@linux.microsoft.com>, <f.fainelli@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 3/3] arm64: mm: Cleanup useless parameters in zone_sizes_init()
Date:   Mon, 11 Apr 2022 17:24:55 +0800
Message-ID: <20220411092455.1461-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220411092455.1461-1-wangkefeng.wang@huawei.com>
References: <20220411092455.1461-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directly use max_pfn for max and no one use min, kill them.

Reviewed-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/mm/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 18b0031eadd0..788413fc2ecf 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -181,7 +181,7 @@ static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
 	return min(zone_mask, memblock_end_of_DRAM() - 1) + 1;
 }
 
-static void __init zone_sizes_init(unsigned long min, unsigned long max)
+static void __init zone_sizes_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
 #ifdef CONFIG_ZONE_DMA
@@ -199,7 +199,7 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 #ifdef CONFIG_ZONE_DMA32
 	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(max_zone_phys(32));
 #endif
-	max_zone_pfns[ZONE_NORMAL] = max;
+	max_zone_pfns[ZONE_NORMAL] = max_pfn;
 
 	free_area_init(max_zone_pfns);
 }
@@ -400,7 +400,7 @@ void __init bootmem_init(void)
 	 * done after the fixed reservations
 	 */
 	sparse_init();
-	zone_sizes_init(min, max);
+	zone_sizes_init();
 
 	/*
 	 * Reserve the CMA area after arm64_dma_phys_limit was initialised.
-- 
2.26.2

