Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDAFC25B0E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 03:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345184AbiHSD25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 23:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344915AbiHSD2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 23:28:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE08CEE2C
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 20:28:35 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M86bw2K4lznTcd;
        Fri, 19 Aug 2022 11:26:20 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 11:28:33 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 11:28:33 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/2] mm: memory-failure: kill __soft_offline_page()
Date:   Fri, 19 Aug 2022 11:34:02 +0800
Message-ID: <20220819033402.156519-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220819033402.156519-1-wangkefeng.wang@huawei.com>
References: <20220819033402.156519-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Squash the __soft_offline_page() into soft_offline_in_use_page() and
kill __soft_offline_page().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory-failure.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 1a7d6548ccb2..5b368124956d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2432,11 +2432,11 @@ static bool isolate_page(struct page *page, struct list_head *pagelist)
 }
 
 /*
- * __soft_offline_page handles hugetlb-pages and non-hugetlb pages.
+ * soft_offline_in_use_page handles hugetlb-pages and non-hugetlb pages.
  * If the page is a non-dirty unmapped page-cache page, it simply invalidates.
  * If the page is mapped, it migrates the contents over.
  */
-static int __soft_offline_page(struct page *page)
+static int soft_offline_in_use_page(struct page *page)
 {
 	long ret = 0;
 	unsigned long pfn = page_to_pfn(page);
@@ -2449,6 +2449,13 @@ static int __soft_offline_page(struct page *page)
 		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
 	};
 
+	if (!huge && PageTransHuge(hpage)) {
+		if (try_to_split_thp_page(page)) {
+			pr_info("soft offline: %#lx: thp split failed\n", pfn);
+			return -EBUSY;
+		}
+	}
+
 	lock_page(page);
 	if (!PageHuge(page))
 		wait_on_page_writeback(page);
@@ -2498,19 +2505,6 @@ static int __soft_offline_page(struct page *page)
 	return ret;
 }
 
-static int soft_offline_in_use_page(struct page *page)
-{
-	struct page *hpage = compound_head(page);
-
-	if (!PageHuge(page) && PageTransHuge(hpage))
-		if (try_to_split_thp_page(page) < 0) {
-			pr_info("soft offline: %#lx: thp split failed\n",
-				page_to_pfn(page));
-			return -EBUSY;
-		}
-	return __soft_offline_page(page);
-}
-
 static void put_ref_page(struct page *page)
 {
 	if (page)
-- 
2.35.3

