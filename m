Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F915C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 16:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377158AbiFPQTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 12:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbiFPQTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:19:35 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D928B32EFC;
        Thu, 16 Jun 2022 09:19:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VGaoYUb_1655396370;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VGaoYUb_1655396370)
          by smtp.aliyun-inc.com;
          Fri, 17 Jun 2022 00:19:30 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     akpm@linux-foundation.org, ziy@nvidia.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org,
        guoren@kernel.org
Cc:     huanyi.xj@alibaba-inc.com, guohanjun@huawei.com,
        zjb194813@alibaba-inc.com, tianhu.hh@alibaba-inc.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH 4.9] mm: page_alloc: validate buddy page before using
Date:   Fri, 17 Jun 2022 00:19:28 +0800
Message-Id: <20220616161928.3565294-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 787af64d05cd ("mm: page_alloc: validate buddy before check its migratetype.")
fixes a bug in 1dd214b8f21c and there is a similar bug in d9dddbf55667 that
can be fixed in a similar way too.

In addition, for RISC-V arch the first 2MB RAM could be reserved for opensbi,
so it would have pfn_base=512 and mem_map began with 512th PFN when
CONFIG_FLATMEM=y.
But __find_buddy_pfn algorithm thinks the start pfn 0, it could get 0 pfn or
less than the pfn_base value. We need page_is_buddy() to verify the buddy to
prevent accessing an invalid buddy.

Fixes: d9dddbf55667 ("mm/page_alloc: prevent merging between isolated and other pageblocks")
Cc: stable@vger.kernel.org
Reported-by: zjb194813@alibaba-inc.com
Reported-by: tianhu.hh@alibaba-inc.com
Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a6e682569e5b..1c423faa4b62 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -864,6 +864,9 @@ static inline void __free_one_page(struct page *page,
 
 			buddy_idx = __find_buddy_index(page_idx, order);
 			buddy = page + (buddy_idx - page_idx);
+
+			if (!page_is_buddy(page, buddy, order))
+				goto done_merging;
 			buddy_mt = get_pageblock_migratetype(buddy);
 
 			if (migratetype != buddy_mt
-- 
2.17.1

