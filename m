Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56278C4332F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 09:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbiCDJgH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 04:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237288AbiCDJft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:35:49 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FC7180238
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:35:02 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4K92fh0ZHZz9sYS;
        Fri,  4 Mar 2022 17:31:24 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Mar
 2022 17:34:59 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <willy@infradead.org>, <ying.huang@intel.com>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <ave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 03/16] mm/migration: remove unneeded local variable page_lru
Date:   Fri, 4 Mar 2022 17:33:56 +0800
Message-ID: <20220304093409.25829-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220304093409.25829-1-linmiaohe@huawei.com>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use page_is_file_lru() directly to help account the isolated
pages to simplify the code a bit as same as local variable follflags.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/migrate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index bc1867a5706c..da5a81052468 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1609,7 +1609,6 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 {
 	struct vm_area_struct *vma;
 	struct page *page;
-	unsigned int follflags;
 	int err;
 
 	mmap_read_lock(mm);
@@ -1619,8 +1618,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 		goto out;
 
 	/* FOLL_DUMP to ignore special (like zero) pages */
-	follflags = FOLL_GET | FOLL_DUMP;
-	page = follow_page(vma, addr, follflags);
+	page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
 
 	err = PTR_ERR(page);
 	if (IS_ERR(page))
@@ -2033,7 +2031,6 @@ static struct page *alloc_misplaced_dst_page_thp(struct page *page,
 
 static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 {
-	int page_lru;
 	int nr_pages = thp_nr_pages(page);
 	int order = compound_order(page);
 
@@ -2060,8 +2057,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 	if (isolate_lru_page(page))
 		return 0;
 
-	page_lru = page_is_file_lru(page);
-	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_lru,
+	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_is_file_lru(page),
 			    nr_pages);
 
 	/*
-- 
2.23.0

