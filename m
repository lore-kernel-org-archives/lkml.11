Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D07C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Apr 2022 08:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiDPIQX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Apr 2022 04:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiDPIQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:16:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E533D49F2F
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 01:13:50 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KgQvH1KjMzXxvH;
        Sat, 16 Apr 2022 16:13:47 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 16 Apr
 2022 16:13:48 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <minchan@kernel.org>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <hughd@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm/madvise: fix potential pte_unmap_unlock pte error
Date:   Sat, 16 Apr 2022 16:14:16 +0800
Message-ID: <20220416081416.23304-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't assume pte_offset_map_lock will return same orig_pte value. So
it's necessary to reacquire the orig_pte or pte_unmap_unlock will unmap
the stale pte.

Fixes: 9c276cc65a58 ("mm: introduce MADV_COLD")
Fixes: 854e9ed09ded ("mm: support madvise(MADV_FREE)")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/madvise.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index ec03a76244b7..4d6592488b51 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -437,12 +437,12 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			if (split_huge_page(page)) {
 				unlock_page(page);
 				put_page(page);
-				pte_offset_map_lock(mm, pmd, addr, &ptl);
+				orig_pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 				break;
 			}
 			unlock_page(page);
 			put_page(page);
-			pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+			orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 			pte--;
 			addr -= PAGE_SIZE;
 			continue;
@@ -653,12 +653,12 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			if (split_huge_page(page)) {
 				unlock_page(page);
 				put_page(page);
-				pte_offset_map_lock(mm, pmd, addr, &ptl);
+				orig_pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 				goto out;
 			}
 			unlock_page(page);
 			put_page(page);
-			pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+			orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 			pte--;
 			addr -= PAGE_SIZE;
 			continue;
-- 
2.23.0

