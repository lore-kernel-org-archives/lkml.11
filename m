Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4E9ECAAD4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 01:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiIABp7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 21:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiIABp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:45:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0415D659E6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:45:54 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MJ3jw2Cl1zHnbJ;
        Thu,  1 Sep 2022 09:44:04 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 09:45:52 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 09:45:51 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: remove BUG_ON() in __isolate_free_page()
Date:   Thu, 1 Sep 2022 09:50:43 +0800
Message-ID: <20220901015043.189276-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unneed comment and blank, adjust the variable, and the most
important is to delete BUG_ON(). The page passed is always buddy
page into __isolate_free_page() from compaction, page_isolation
and page_reporting, and the caller also check the return, BUG_ON()
is a too drastic measure, remove it.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/page_alloc.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9f2e250c2589..7ad0c7b14ad2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3600,16 +3600,11 @@ EXPORT_SYMBOL_GPL(split_page);
 
 int __isolate_free_page(struct page *page, unsigned int order)
 {
-	unsigned long watermark;
-	struct zone *zone;
-	int mt;
-
-	BUG_ON(!PageBuddy(page));
-
-	zone = page_zone(page);
-	mt = get_pageblock_migratetype(page);
+	struct zone *zone = page_zone(page);
+	int mt = get_pageblock_migratetype(page);
 
 	if (!is_migrate_isolate(mt)) {
+		unsigned long watermark;
 		/*
 		 * Obey watermarks as if the page was being allocated. We can
 		 * emulate a high-order watermark check with a raised order-0
@@ -3623,8 +3618,6 @@ int __isolate_free_page(struct page *page, unsigned int order)
 		__mod_zone_freepage_state(zone, -(1UL << order), mt);
 	}
 
-	/* Remove page from free list */
-
 	del_page_from_free_list(page, zone, order);
 
 	/*
@@ -3645,7 +3638,6 @@ int __isolate_free_page(struct page *page, unsigned int order)
 		}
 	}
 
-
 	return 1UL << order;
 }
 
-- 
2.35.3

