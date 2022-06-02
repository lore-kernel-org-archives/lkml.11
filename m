Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3BACCA47B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 05:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiFBFHQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 01:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiFBFHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 01:07:10 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D323DED3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 22:07:09 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654146428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7I9i+xId5N+xy5u1TX6EpcfxW61lTxslw160ZROaNiI=;
        b=d/YW6eqqfLVLB7Ax1v3MIG6kBqgh4p98XWoszP9C3FXa9s9oHFP6CVDFpGHJ5+5UX4m99r
        Y89/UUhMh0a97isHzTi97tAZnmq4kX4w5L/eFh8f571GzTgejiHbUglZ8VsKMjH4nhAiUm
        d+3HZlY4kma9EmkYrjNSpuFVd+VG5qo=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] mm,hwpoison: set PG_hwpoison for busy hugetlb pages
Date:   Thu,  2 Jun 2022 14:06:28 +0900
Message-Id: <20220602050631.771414-3-naoya.horiguchi@linux.dev>
In-Reply-To: <20220602050631.771414-1-naoya.horiguchi@linux.dev>
References: <20220602050631.771414-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

If memory_failure() fails to grab page refcount on a hugetlb page
because it's busy, it returns without setting PG_hwpoison on it.
This not only loses a chance of error containment, but breaks the rule
that action_result() should be called only when memory_failure() do
any of handling work (even if that's just setting PG_hwpoison).
This inconsistency could harm code maintainability.

So set PG_hwpoison and call hugetlb_set_page_hwpoison() for such a case.

Fixes: 405ce051236c ("mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()")
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/mm.h  | 1 +
 mm/memory-failure.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d446e834a3e5..04de0c3e4f9f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3187,6 +3187,7 @@ enum mf_flags {
 	MF_MUST_KILL = 1 << 2,
 	MF_SOFT_OFFLINE = 1 << 3,
 	MF_UNPOISON = 1 << 4,
+	MF_NO_RETRY = 1 << 5,
 };
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 056dbb2050f8..fe6a7961dc66 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1526,7 +1526,8 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 			count_increased = true;
 	} else {
 		ret = -EBUSY;
-		goto out;
+		if (!(flags & MF_NO_RETRY))
+			goto out;
 	}
 
 	if (TestSetPageHWPoison(head)) {
@@ -1556,7 +1557,6 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	struct page *p = pfn_to_page(pfn);
 	struct page *head;
 	unsigned long page_flags;
-	bool retry = true;
 
 	*hugetlb = 1;
 retry:
@@ -1572,8 +1572,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		}
 		return res;
 	} else if (res == -EBUSY) {
-		if (retry) {
-			retry = false;
+		if (!(flags & MF_NO_RETRY)) {
+			flags |= MF_NO_RETRY;
 			goto retry;
 		}
 		action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
-- 
2.25.1

