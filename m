Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFC1C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 11:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbiF3LLd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 07:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiF3LL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:11:29 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F9045061
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:11:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VHrqagJ_1656587484;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VHrqagJ_1656587484)
          by smtp.aliyun-inc.com;
          Thu, 30 Jun 2022 19:11:25 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     rppt@linux.ibm.com, willy@infradead.org,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 1/3] mm: Factor out the pagetable pages account into new helper function
Date:   Thu, 30 Jun 2022 19:11:14 +0800
Message-Id: <9c527d4d2eb1f457306e575ce16c6acdd8141e02.1656586863.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
References: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
References: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the pagetable pages account into new helper functions to avoid
duplicated code. Meanwhile these helper functions also will be used to
account pagetable pages which do not need split pagetale lock.

Meanwhile convert to use mod_lruvec_page_state() in case of non-order-0
page table allocation.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/mm.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a2270e3..3be6d2c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2353,20 +2353,30 @@ static inline void pgtable_init(void)
 	pgtable_cache_init();
 }
 
+static inline void pgtable_page_inc(struct page *page)
+{
+	__SetPageTable(page);
+	mod_lruvec_page_state(page, NR_PAGETABLE, compound_nr(page));
+}
+
+static inline void pgtable_page_dec(struct page *page)
+{
+	__ClearPageTable(page);
+	mod_lruvec_page_state(page, NR_PAGETABLE, -compound_nr(page));
+}
+
 static inline bool pgtable_pte_page_ctor(struct page *page)
 {
 	if (!ptlock_init(page))
 		return false;
-	__SetPageTable(page);
-	inc_lruvec_page_state(page, NR_PAGETABLE);
+	pgtable_page_inc(page);
 	return true;
 }
 
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
 	ptlock_free(page);
-	__ClearPageTable(page);
-	dec_lruvec_page_state(page, NR_PAGETABLE);
+	pgtable_page_dec(page);
 }
 
 #define pte_offset_map_lock(mm, pmd, address, ptlp)	\
@@ -2452,16 +2462,14 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 {
 	if (!pmd_ptlock_init(page))
 		return false;
-	__SetPageTable(page);
-	inc_lruvec_page_state(page, NR_PAGETABLE);
+	pgtable_page_inc(page);
 	return true;
 }
 
 static inline void pgtable_pmd_page_dtor(struct page *page)
 {
 	pmd_ptlock_free(page);
-	__ClearPageTable(page);
-	dec_lruvec_page_state(page, NR_PAGETABLE);
+	pgtable_page_dec(page);
 }
 
 /*
-- 
1.8.3.1

