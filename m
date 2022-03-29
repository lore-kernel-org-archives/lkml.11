Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82493C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 13:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiC2N1h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbiC2N1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:27:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB201F42DB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:25:47 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KSVdf5wZszgY8f;
        Tue, 29 Mar 2022 21:24:06 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 29 Mar
 2022 21:25:44 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/8] mm/vmscan: remove unneeded can_split_huge_page check
Date:   Tue, 29 Mar 2022 21:26:13 +0800
Message-ID: <20220329132619.18689-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220329132619.18689-1-linmiaohe@huawei.com>
References: <20220329132619.18689-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

can_split_huge_page is introduced via commit b8f593cd0896 ("mm, THP, swap:
check whether THP can be split firstly") to avoid deleting the THP from
the swap cache and freeing the swap cluster when the THP cannot be split.
But since commit bd4c82c22c36 ("mm, THP, swap: delay splitting THP after
swapped out"), splitting THP is delayed until THP is swapped out. There's
no need to delete the THP from the swap cache and free the swap cluster
anymore. Thus we can remove this unneeded can_split_huge_page check now to
simplify the code logic.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmscan.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7c1a9713bfc9..09b452c4d256 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1691,9 +1691,6 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 				if (folio_maybe_dma_pinned(folio))
 					goto keep_locked;
 				if (PageTransHuge(page)) {
-					/* cannot split THP, skip it */
-					if (!can_split_folio(folio, NULL))
-						goto activate_locked;
 					/*
 					 * Split pages without a PMD map right
 					 * away. Chances are some or all of the
-- 
2.23.0

