Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5EFC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 10:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347731AbiHSKNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346395AbiHSKNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:13:10 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D319D9D56
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 03:13:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VMfbQOG_1660903985;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VMfbQOG_1660903985)
          by smtp.aliyun-inc.com;
          Fri, 19 Aug 2022 18:13:05 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm/gup: fix races when looking up a CONT-PTE size hugetlb page
Date:   Fri, 19 Aug 2022 18:12:56 +0800
Message-Id: <0f3df6604059011bf78a286c2cf5da5c4b41ccb1.1660902741.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1660902741.git.baolin.wang@linux.alibaba.com>
References: <cover.1660902741.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1660902741.git.baolin.wang@linux.alibaba.com>
References: <cover.1660902741.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some architectures (like ARM64), it can support CONT-PTE/PMD size
hugetlb, which means it can support not only PMD/PUD size hugetlb:
2M and 1G, but also CONT-PTE/PMD size: 64K and 32M if a 4K page size
specified.

When looking up a CONT-PTE size hugetlb page by follow_page(), it will
use pte_offset_map_lock() to get the pte lock for the CONT-PTE size
hugetlb in follow_page_pte(). However this pte lock is incorrect for
the CONT-PTE size hugetlb, since we should use mm->page_table_lock
by huge_pte_lockptr().

That means the pte entry of the CONT-PTE size hugetlb under current
pte lock is unstable in follow_page_pte(), we can continue to migrate
or poison the pte entry of the CONT-PTE size hugetlb, which can cause
some potential race issues, since the pte entry is unstable, and
following pte_xxx() validation is also incorrect in follow_page_pte(),
even though they are under the 'pte lock'.

To fix this issue, we should validate if it is a CONT-PTE size VMA
at first, and use huge_pte_lockptr() to get the correct pte lock
and get the pte value by huge_ptep_get() to make the pte entry stable
under the correct pte lock.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/gup.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 5aa7531..3b2fa86 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -534,8 +534,26 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	if (unlikely(pmd_bad(*pmd)))
 		return no_page_table(vma, flags);
 
-	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
-	pte = *ptep;
+	/*
+	 * Considering PTE level hugetlb, like continuous-PTE hugetlb on
+	 * ARM64 architecture.
+	 */
+	if (is_vm_hugetlb_page(vma)) {
+		struct hstate *hstate = hstate_vma(vma);
+		unsigned long size = huge_page_size(hstate);
+
+		ptep = huge_pte_offset(mm, address, size);
+		if (!ptep)
+			return no_page_table(vma, flags);
+
+		ptl = huge_pte_lockptr(hstate, mm, ptep);
+		spin_lock(ptl);
+		pte = huge_ptep_get(ptep);
+	} else {
+		ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
+		pte = *ptep;
+	}
+
 	if (!pte_present(pte)) {
 		swp_entry_t entry;
 		/*
-- 
1.8.3.1

