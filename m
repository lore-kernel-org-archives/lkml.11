Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A088CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 01:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbiEKBKP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 21:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbiEKBKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:10:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CFA210BB9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:10:11 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KycCP71LWzCsY7;
        Wed, 11 May 2022 09:05:21 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 09:10:08 +0800
From:   Zhou Guanghui <zhouguanghui1@huawei.com>
To:     <akpm@linux-foundation.org>, <rppt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <xuqiang36@huawei.com>, <zhouguanghui1@huawei.com>
Subject: [PATCH] memblock: config the number of init memblock regions
Date:   Wed, 11 May 2022 01:05:30 +0000
Message-ID: <20220511010530.60962-1-zhouguanghui1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During early boot, the number of memblocks may exceed 128(some memory
areas are not reported to the kernel due to test failures. As a result,
contiguous memory is divided into multiple parts for reporting). If
the size of the init memblock regions is exceeded before the array size
can be resized, the excess memory will be lost.

Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
---
 mm/Kconfig    | 8 ++++++++
 mm/memblock.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 034d87953600..c6881802cccc 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -89,6 +89,14 @@ config SPARSEMEM_VMEMMAP
 	  pfn_to_page and page_to_pfn operations.  This is the most
 	  efficient option when sufficient kernel resources are available.
 
+config MEMBLOCK_INIT_REGIONS
+	int "Number of init memblock regions"
+	range 128 1024
+	default 128
+	help
+	  The number of init memblock regions which used to track "memory" and
+	  "reserved" memblocks during early boot.
+
 config HAVE_MEMBLOCK_PHYS_MAP
 	bool
 
diff --git a/mm/memblock.c b/mm/memblock.c
index e4f03a6e8e56..6893d26b750e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -22,7 +22,7 @@
 
 #include "internal.h"
 
-#define INIT_MEMBLOCK_REGIONS			128
+#define INIT_MEMBLOCK_REGIONS			CONFIG_MEMBLOCK_INIT_REGIONS
 #define INIT_PHYSMEM_REGIONS			4
 
 #ifndef INIT_MEMBLOCK_RESERVED_REGIONS
-- 
2.17.1

