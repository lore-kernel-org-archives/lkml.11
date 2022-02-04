Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03457C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Feb 2022 20:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbiBDUCb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Feb 2022 15:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbiBDT7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AE4C0613F5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=H+jlw4ue9QjQz5TCNSRpgDvnDtE889iCzjsXByGd4u8=; b=GuBfxuzooSqM5ZW4K7+hqLdHTW
        NnxA0DNphTowyrCXMe3zTuIFp55vQHZPjdJikSVqYLP6plwJNKt9mK3D+7H01Miuwf2IwNZ6wd8vp
        wVdKVw619Cp+EHOi7WSVU8n/zwcGVm1s10hGnAwqPYt9sXCUaDAKDSQyiPxejioqBJJntaTGTNtP0
        T2d5NuhAqgjD/S3Vmg3kMUKh794eXYzX3rLysGc/TvNQLMJ2MpQz3bfgq1WPUYUveLgw59U3kSEBN
        ThvxpKmP97W4iCAsg91IqBm7jgSlProJkp+xDcj9dJYkatYmKDx13hzZQxC2Ou+XYtROk/26PTrKc
        b2KLbBxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jV-007Llx-OJ; Fri, 04 Feb 2022 19:59:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 23/75] mm/gup: Convert gup_huge_pud() to use a folio
Date:   Fri,  4 Feb 2022 19:58:00 +0000
Message-Id: <20220204195852.1751729-24-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204195852.1751729-1-willy@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new folio-based APIs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/gup.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ca8262392ce3..6d7a2ba6790b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2544,7 +2544,8 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 			unsigned long end, unsigned int flags,
 			struct page **pages, int *nr)
 {
-	struct page *head, *page;
+	struct page *page;
+	struct folio *folio;
 	int refs;
 
 	if (!pud_access_permitted(orig, flags & FOLL_WRITE))
@@ -2560,17 +2561,17 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	page = nth_page(pud_page(orig), (addr & ~PUD_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	head = try_grab_compound_head(pud_page(orig), refs, flags);
-	if (!head)
+	folio = try_grab_folio(page, refs, flags);
+	if (!folio)
 		return 0;
 
 	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
-		put_compound_head(head, refs, flags);
+		gup_put_folio(folio, refs, flags);
 		return 0;
 	}
 
 	*nr += refs;
-	SetPageReferenced(head);
+	folio_set_referenced(folio);
 	return 1;
 }
 
-- 
2.34.1

