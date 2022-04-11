Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815EAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 11:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344020AbiDKLhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 07:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238890AbiDKLhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:37:01 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA9013DF9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:34:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V9nhU4j_1649676883;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V9nhU4j_1649676883)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Apr 2022 19:34:44 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: migrate: Simplify the refcount validation when migrating hugetlb mapping
Date:   Mon, 11 Apr 2022 19:34:30 +0800
Message-Id: <eb2fbbeaef2b1714097b9dec457426d682ee0635.1649676424.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to validate the hugetlb page's refcount before trying
to freeze the hugetlb page's expected refcount, instead we can just
rely on the page_ref_freeze() to simplify the validation.

Moreover we are always under the page lock when migrating the hugetlb
page mapping, which means nowhere else can remove it from the page cache,
so we can remove the xas_load() validation under the i_pages lock.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 mm/migrate.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index a3d8c2b..b267827 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -477,11 +477,6 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 
 	xas_lock_irq(&xas);
 	expected_count = 2 + page_has_private(page);
-	if (page_count(page) != expected_count || xas_load(&xas) != page) {
-		xas_unlock_irq(&xas);
-		return -EAGAIN;
-	}
-
 	if (!page_ref_freeze(page, expected_count)) {
 		xas_unlock_irq(&xas);
 		return -EAGAIN;
-- 
1.8.3.1

