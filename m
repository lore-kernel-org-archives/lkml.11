Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408F3CCA485
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 08:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbiFMILn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbiFMILK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:11:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AA01E3EA;
        Mon, 13 Jun 2022 01:11:08 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LM4395M1Nz1K9Q9;
        Mon, 13 Jun 2022 16:09:09 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 16:11:04 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 16:11:03 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        "John Donnelly" <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH 3/5] arm64: kdump: Remove some redundant checks in map_mem()
Date:   Mon, 13 Jun 2022 16:09:30 +0800
Message-ID: <20220613080932.663-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220613080932.663-1-thunder.leizhen@huawei.com>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64_memblock_init()
	if (!IS_ENABLED(CONFIG_ZONE_DMA/DMA32))
		reserve_crashkernel()
			//initialize crashk_res when
			//"crashkernel=" is correctly specified
paging_init()
	map_mem()

As shown in the above pseudo code, the crashk_res.end can only be
initialized to non-zero when both "!IS_ENABLED(CONFIG_ZONE_DMA/DMA32)"
and crash_mem_map are true. So some checks in map_mem() can be adjusted
or optimized.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/mm/mmu.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 626ec32873c6c36..6028a5757e4eae2 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -529,12 +529,12 @@ static void __init map_mem(pgd_t *pgdp)
 
 #ifdef CONFIG_KEXEC_CORE
 	if (crash_mem_map) {
-		if (IS_ENABLED(CONFIG_ZONE_DMA) ||
-		    IS_ENABLED(CONFIG_ZONE_DMA32))
-			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
-		else if (crashk_res.end)
+		if (crashk_res.end)
 			memblock_mark_nomap(crashk_res.start,
 			    resource_size(&crashk_res));
+		else if (IS_ENABLED(CONFIG_ZONE_DMA) ||
+			 IS_ENABLED(CONFIG_ZONE_DMA32))
+			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 	}
 #endif
 
@@ -571,16 +571,13 @@ static void __init map_mem(pgd_t *pgdp)
 	 * through /sys/kernel/kexec_crash_size interface.
 	 */
 #ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map &&
-	    !IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) {
-		if (crashk_res.end) {
-			__map_memblock(pgdp, crashk_res.start,
-				       crashk_res.end + 1,
-				       PAGE_KERNEL,
-				       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
-			memblock_clear_nomap(crashk_res.start,
-					     resource_size(&crashk_res));
-		}
+	if (crashk_res.end) {
+		__map_memblock(pgdp, crashk_res.start,
+			       crashk_res.end + 1,
+			       PAGE_KERNEL,
+			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
+		memblock_clear_nomap(crashk_res.start,
+				     resource_size(&crashk_res));
 	}
 #endif
 }
-- 
2.25.1

