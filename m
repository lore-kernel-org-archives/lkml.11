Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB43C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Apr 2022 11:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiD0LGD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Apr 2022 07:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiD0LDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:03:32 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACA911E19E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:52:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VBTIjXj_1651056734;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VBTIjXj_1651056734)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Apr 2022 18:52:15 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     almasrymina@google.com, songmuchun@bytedance.com,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] mm: rmap: Move the cache flushing to the correct place for hugetlb PMD sharing
Date:   Wed, 27 Apr 2022 18:52:06 +0800
Message-Id: <4f7ae6dfdc838ab71e1655188b657c032ff1f28f.1651056365.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
References: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
References: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cache level flush will always be first when changing an existing
virtual–>physical mapping to a new value, since this allows us to
properly handle systems whose caches are strict and require a
virtual–>physical translation to exist for a virtual address. So we
should move the cache flushing before huge_pmd_unshare().

As Muchun pointed out[1], now the architectures whose supporting hugetlb
PMD sharing have no cache flush issues in practice. But I think we
should still follow the cache/TLB flushing rules when changing a valid
virtual address mapping in case of potential issues in future.

[1] https://lore.kernel.org/all/YmT%2F%2FhuUbFX+KHcy@FVFYT0MHHV2J.usts.net/
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/rmap.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 61e63db..4f0d115 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1535,15 +1535,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 * do this outside rmap routines.
 			 */
 			VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
+			/*
+			 * huge_pmd_unshare may unmap an entire PMD page.
+			 * There is no way of knowing exactly which PMDs may
+			 * be cached for this mm, so we must flush them all.
+			 * start/end were already adjusted above to cover this
+			 * range.
+			 */
+			flush_cache_range(vma, range.start, range.end);
+
 			if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
-				/*
-				 * huge_pmd_unshare unmapped an entire PMD
-				 * page.  There is no way of knowing exactly
-				 * which PMDs may be cached for this mm, so
-				 * we must flush them all.  start/end were
-				 * already adjusted above to cover this range.
-				 */
-				flush_cache_range(vma, range.start, range.end);
 				flush_tlb_range(vma, range.start, range.end);
 				mmu_notifier_invalidate_range(mm, range.start,
 							      range.end);
@@ -1560,13 +1561,14 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				page_vma_mapped_walk_done(&pvmw);
 				break;
 			}
+		} else {
+			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
 		}
 
 		/*
 		 * Nuke the page table entry. When having to clear
 		 * PageAnonExclusive(), we always have to flush.
 		 */
-		flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
 		if (should_defer_flush(mm, flags) && !anon_exclusive) {
 			/*
 			 * We clear the PTE but do not flush so potentially
@@ -1890,15 +1892,16 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			 * do this outside rmap routines.
 			 */
 			VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
+			/*
+			 * huge_pmd_unshare may unmap an entire PMD page.
+			 * There is no way of knowing exactly which PMDs may
+			 * be cached for this mm, so we must flush them all.
+			 * start/end were already adjusted above to cover this
+			 * range.
+			 */
+			flush_cache_range(vma, range.start, range.end);
+
 			if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
-				/*
-				 * huge_pmd_unshare unmapped an entire PMD
-				 * page.  There is no way of knowing exactly
-				 * which PMDs may be cached for this mm, so
-				 * we must flush them all.  start/end were
-				 * already adjusted above to cover this range.
-				 */
-				flush_cache_range(vma, range.start, range.end);
 				flush_tlb_range(vma, range.start, range.end);
 				mmu_notifier_invalidate_range(mm, range.start,
 							      range.end);
@@ -1915,10 +1918,11 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				page_vma_mapped_walk_done(&pvmw);
 				break;
 			}
+		} else {
+			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
 		}
 
 		/* Nuke the page table entry. */
-		flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
 		pteval = ptep_clear_flush(vma, address, pvmw.pte);
 
 		/* Set the dirty flag on the folio now the pte is gone. */
-- 
1.8.3.1

