Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A92C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 13:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiEINSj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 09:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiEINSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:18:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A5D2A804F
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:14:10 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KxhST0WzczhZ3y;
        Mon,  9 May 2022 21:13:29 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 21:14:02 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 06/15] mm/swap: remove buggy cache->nr check in refill_swap_slots_cache
Date:   Mon, 9 May 2022 21:14:07 +0800
Message-ID: <20220509131416.17553-7-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220509131416.17553-1-linmiaohe@huawei.com>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refill_swap_slots_cache is always called when cache->nr is 0. And if
cache->nr != 0, we should return cache->nr instead of 0. So remove
such buggy and confusing check.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swap_slots.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 2f877e6f87d7..2a65a89b5b4d 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -258,7 +258,7 @@ void enable_swap_slots_cache(void)
 /* called with swap slot cache's alloc lock held */
 static int refill_swap_slots_cache(struct swap_slots_cache *cache)
 {
-	if (!use_swap_slot_cache || cache->nr)
+	if (!use_swap_slot_cache)
 		return 0;
 
 	cache->cur = 0;
-- 
2.23.0

