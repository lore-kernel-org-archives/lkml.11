Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A9EC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 15:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245708AbiDRPQh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 11:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244169AbiDRPPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:15:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C4B38BDD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:12:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KhpgD34p3zCr5B;
        Mon, 18 Apr 2022 22:08:08 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 22:12:31 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <pintu@codeaurora.org>,
        <charante@codeaurora.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 10/12] mm: compaction: make compaction_zonelist_suitable return false when COMPACT_SUCCESS
Date:   Mon, 18 Apr 2022 22:12:51 +0800
Message-ID: <20220418141253.24298-11-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220418141253.24298-1-linmiaohe@huawei.com>
References: <20220418141253.24298-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compact_result indicates that the allocation should now succeed,
i.e. compact_result = COMPACT_SUCCESS, compaction_zonelist_suitable
should return false because there is no need to do compaction now.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/compaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 82c54d70a978..334a573485fe 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2291,7 +2291,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
 		compact_result = __compaction_suitable(zone, order, alloc_flags,
 				ac->highest_zoneidx, available);
-		if (compact_result != COMPACT_SKIPPED)
+		if (compact_result == COMPACT_CONTINUE)
 			return true;
 	}
 
-- 
2.23.0

