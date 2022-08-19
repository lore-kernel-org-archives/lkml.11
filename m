Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1A0C25B0E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 09:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347993AbiHSJFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348014AbiHSJFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:05:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A77F23E7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:05:36 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M8G3C4tRZzlWPm;
        Fri, 19 Aug 2022 17:01:59 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 17:05:06 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 19 Aug
 2022 17:05:05 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next v2] bootmem: remove the vmemmap pages from kmemleak in put_page_bootmem
Date:   Fri, 19 Aug 2022 17:40:05 +0800
Message-ID: <20220819094005.2928241-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vmemmap pages is marked by kmemleak when allocated from memblock.
Remove it from kmemleak when free the page. Otherwise, when we reuse the
page, kmemleak may report such an error and then stop working.

 kmemleak: Cannot insert 0xffff98fb6eab3d40 into the object search tree (overlaps existing)
 kmemleak: Kernel memory leak detector disabled
 kmemleak: Object 0xffff98fb6be00000 (size 335544320):
 kmemleak:   comm "swapper", pid 0, jiffies 4294892296
 kmemleak:   min_count = 0
 kmemleak:   count = 0
 kmemleak:   flags = 0x1
 kmemleak:   checksum = 0
 kmemleak:   backtrace:

Fixes: f41f2ed43ca5 (mm: hugetlb: free the vmemmap pages associated with each HugeTLB page)
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/bootmem_info.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index f18a631e7479..b1efebfcf94b 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -12,6 +12,7 @@
 #include <linux/memblock.h>
 #include <linux/bootmem_info.h>
 #include <linux/memory_hotplug.h>
+#include <linux/kmemleak.h>
 
 void get_page_bootmem(unsigned long info, struct page *page, unsigned long type)
 {
@@ -33,6 +34,7 @@ void put_page_bootmem(struct page *page)
 		ClearPagePrivate(page);
 		set_page_private(page, 0);
 		INIT_LIST_HEAD(&page->lru);
+		kmemleak_free_part(page_to_virt(page), PAGE_SIZE);
 		free_reserved_page(page);
 	}
 }
-- 
2.25.1

