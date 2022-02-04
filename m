Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186BBC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Feb 2022 20:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbiBDUEy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Feb 2022 15:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbiBDUCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:02:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA8AC061762
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lvXYfUK4uxaq9EJmybHOLtM9xC/VzkMqzDT6RcEHXUU=; b=wTrV3Juc2XZPFMIUtSFKc+zf8v
        ZFZn2K6SZgdMMhyZoDtAHIVLGdYZtUikpHGAe8zmLPDx1Ws8nKIUBTRgHIE41Kv0dFP1fTiVu7k8H
        SJuiYtnHwYRiQETq7UW5GARue2e/FnxSNNs8nsqNfY8br9cfb3nWLBmbruRSMgJg2C7xMGmVb1meP
        E5ymOeK7FbcA248CsOcspI+bEhzkQ5/Bp3Fw5yfr4AmZ1JLy01AWYK5+04yupjU7WyanTvZpTYrnY
        ns1Tn41Jywu1Yj3BYsyq3eb4cT1pvfCe0JqL046RLeYcMe0fkflglS89jyqKoz6WRUle4GfYszYq+
        eOS8+8SA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jU-007LlJ-Br; Fri, 04 Feb 2022 19:59:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 09/75] mm/gup: Handle page split race more efficiently
Date:   Fri,  4 Feb 2022 19:57:46 +0000
Message-Id: <20220204195852.1751729-10-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204195852.1751729-1-willy@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we hit the page split race, the current code returns NULL which will
presumably trigger a retry under the mmap_lock.  This isn't necessary;
we can just retry the compound_head() lookup.  This is a very minor
optimisation of an unlikely path, but conceptually it matches (eg)
the page cache RCU-protected lookup.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/gup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index fa75b71820a2..923a0d44203c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -68,7 +68,10 @@ static void put_page_refs(struct page *page, int refs)
  */
 static inline struct page *try_get_compound_head(struct page *page, int refs)
 {
-	struct page *head = compound_head(page);
+	struct page *head;
+
+retry:
+	head = compound_head(page);
 
 	if (WARN_ON_ONCE(page_ref_count(head) < 0))
 		return NULL;
@@ -86,7 +89,7 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
 	 */
 	if (unlikely(compound_head(page) != head)) {
 		put_page_refs(head, refs);
-		return NULL;
+		goto retry;
 	}
 
 	return head;
-- 
2.34.1

