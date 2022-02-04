Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48650C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Feb 2022 20:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbiBDUCz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Feb 2022 15:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbiBDT7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92FCC061749
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Qp/7CV756EjRflFbilGAM2PWJ4Vh7vDEGJ1jBhnMB60=; b=FEl7wj2ny9VKEO6nnjsFB7DhPI
        c+Mtk+lRI+R1Ued1Wy+ESTXo7863L3btIBoNRphLP+Jw3wmpRiGei36BTGQEUedkSBsLV8sDQqzup
        +1AcDx3RPnCrmPNY2liHAnjVeaaVJL0raWdHL84Ov4kNe5M7AQ7V3d5+DMWqXD8x+YF3G/0+8mW7W
        QJZQ/FzI87aBXaPOPGWAG6YQHklqGPiAFzF3n/hz3ay048DaOyX080qLq2+SNNDMH7nLzsADFY+TZ
        eyWeCBPdr0YOV6gweWxCX7oMOGXcLktHpKXLA91GGuPPEBXWY+5GVpQYaGyWF+o4Fv9V/5DnXS09Y
        AjygAdOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jW-007LmZ-SK; Fri, 04 Feb 2022 19:59:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 34/75] mm/vmscan: Turn page_check_dirty_writeback() into folio_check_dirty_writeback()
Date:   Fri,  4 Feb 2022 19:58:11 +0000
Message-Id: <20220204195852.1751729-35-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204195852.1751729-1-willy@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saves a few calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmscan.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 15cbfae0d8ec..e8c5855bc38d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1430,7 +1430,7 @@ static enum page_references page_check_references(struct page *page,
 }
 
 /* Check if a page is dirty or under writeback */
-static void page_check_dirty_writeback(struct page *page,
+static void folio_check_dirty_writeback(struct folio *folio,
 				       bool *dirty, bool *writeback)
 {
 	struct address_space *mapping;
@@ -1439,24 +1439,24 @@ static void page_check_dirty_writeback(struct page *page,
 	 * Anonymous pages are not handled by flushers and must be written
 	 * from reclaim context. Do not stall reclaim based on them
 	 */
-	if (!page_is_file_lru(page) ||
-	    (PageAnon(page) && !PageSwapBacked(page))) {
+	if (!folio_is_file_lru(folio) ||
+	    (folio_test_anon(folio) && !folio_test_swapbacked(folio))) {
 		*dirty = false;
 		*writeback = false;
 		return;
 	}
 
-	/* By default assume that the page flags are accurate */
-	*dirty = PageDirty(page);
-	*writeback = PageWriteback(page);
+	/* By default assume that the folio flags are accurate */
+	*dirty = folio_test_dirty(folio);
+	*writeback = folio_test_writeback(folio);
 
 	/* Verify dirty/writeback state if the filesystem supports it */
-	if (!page_has_private(page))
+	if (!folio_test_private(folio))
 		return;
 
-	mapping = page_mapping(page);
+	mapping = folio_mapping(folio);
 	if (mapping && mapping->a_ops->is_dirty_writeback)
-		mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
+		mapping->a_ops->is_dirty_writeback(&folio->page, dirty, writeback);
 }
 
 static struct page *alloc_demote_page(struct page *page, unsigned long node)
@@ -1565,7 +1565,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		 * reclaim_congested. kswapd will stall and start writing
 		 * pages if the tail of the LRU is all dirty unqueued pages.
 		 */
-		page_check_dirty_writeback(page, &dirty, &writeback);
+		folio_check_dirty_writeback(folio, &dirty, &writeback);
 		if (dirty || writeback)
 			stat->nr_dirty++;
 
-- 
2.34.1

