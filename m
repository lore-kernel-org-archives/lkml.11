Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5E2C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 13:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbiC2N15 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbiC2N1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:27:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F3F1F637F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:25:48 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KSVd25TYSzCr9R;
        Tue, 29 Mar 2022 21:23:34 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 29 Mar
 2022 21:25:46 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 7/8] mm/vmscan: take min_slab_pages into account when try to call shrink_node
Date:   Tue, 29 Mar 2022 21:26:18 +0800
Message-ID: <20220329132619.18689-8-linmiaohe@huawei.com>
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

Since commit 6b4f7799c6a5 ("mm: vmscan: invoke slab shrinkers from
shrink_zone()"), slab reclaim and lru page reclaim are done together
in the shrink_node. So we should take min_slab_pages into account
when try to call shrink_node.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmscan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1145d23332a3..e4ef6f637aa9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4695,7 +4695,8 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 	noreclaim_flag = memalloc_noreclaim_save();
 	set_task_reclaim_state(p, &sc.reclaim_state);
 
-	if (node_pagecache_reclaimable(pgdat) > pgdat->min_unmapped_pages) {
+	if (node_pagecache_reclaimable(pgdat) > pgdat->min_unmapped_pages ||
+	    node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B) > pgdat->min_slab_pages) {
 		/*
 		 * Free memory by calling shrink node with increasing
 		 * priorities until we have enough memory freed.
-- 
2.23.0

