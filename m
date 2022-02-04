Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4217AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Feb 2022 20:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbiBDUB3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Feb 2022 15:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbiBDT7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B09C06174E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=AzouEe87CsHrOlz5lRWmw/qpbTgwgFiUall9RgwPTEY=; b=IU/1vPxIrZ5iK1dda6fsfPhSPr
        Kr1ElB1+QqS88UY/rmdfuYasDUH0tanagwRQItuSqyf8evtlPBm64ReevTLCotJVcydRWg6ehPTuI
        YYYsFuirs0s30u2QlZfbnMSCsHMTe8hkTYcTrP/KtdSGrG6CzlxlC0qd6mJFvcwwWz+YglBveVMej
        +KBbbxKueK7FhOGBTVc83itLTGgM92ZzRWl2lXE+ODdgsRMVJHB1FWxrP6NX/wz9XeHbrlLR2wfPV
        lt3UdLA/qj/ib32sGfhD+u2AAs6mpOAOWN6U8PZhFL9UcjaVnHzi/q1LdHpz18P0ZRrvfCpdYIFi+
        xZmIwuIw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jb-007Lqx-IQ; Fri, 04 Feb 2022 19:59:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 68/75] mm: Fix READ_ONLY_THP warning
Date:   Fri,  4 Feb 2022 19:58:45 +0000
Message-Id: <20220204195852.1751729-69-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204195852.1751729-1-willy@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These counters only exist if CONFIG_READ_ONLY_THP_FOR_FS is defined,
but we do not need to warn if the filesystem natively supports large
folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index dddd660da24f..39115f75962c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -212,7 +212,7 @@ static inline void filemap_nr_thps_inc(struct address_space *mapping)
 	if (!mapping_large_folio_support(mapping))
 		atomic_inc(&mapping->nr_thps);
 #else
-	WARN_ON_ONCE(1);
+	WARN_ON_ONCE(mapping_large_folio_support(mapping) == 0);
 #endif
 }
 
@@ -222,7 +222,7 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
 	if (!mapping_large_folio_support(mapping))
 		atomic_dec(&mapping->nr_thps);
 #else
-	WARN_ON_ONCE(1);
+	WARN_ON_ONCE(mapping_large_folio_support(mapping) == 0);
 #endif
 }
 
-- 
2.34.1

