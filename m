Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDB6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 11:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiBXLzg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 06:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiBXLze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:55:34 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBD5254550
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:55:03 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K4B6s4nlpzbbq4;
        Thu, 24 Feb 2022 19:50:29 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 24 Feb
 2022 19:55:01 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/writeback: minor clean up for highmem_dirtyable_memory
Date:   Thu, 24 Feb 2022 19:54:16 +0800
Message-ID: <20220224115416.46089-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
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

Since commit a804552b9a15 ("mm/page-writeback.c: fix dirty_balance_reserve
subtraction from dirtyable memory"), local variable x can not be negative
values. And it can not overflow when it is the total number of dirtyable
highmem pages. Thus remove the unneeded comment and overflow check.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/page-writeback.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 48a8cf770e3f..cdba72aa7fa9 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -326,18 +326,6 @@ static unsigned long highmem_dirtyable_memory(unsigned long total)
 		}
 	}
 
-	/*
-	 * Unreclaimable memory (kernel memory or anonymous memory
-	 * without swap) can bring down the dirtyable pages below
-	 * the zone's dirty balance reserve and the above calculation
-	 * will underflow.  However we still want to add in nodes
-	 * which are below threshold (negative values) to get a more
-	 * accurate calculation but make sure that the total never
-	 * underflows.
-	 */
-	if ((long)x < 0)
-		x = 0;
-
 	/*
 	 * Make sure that the number of highmem pages is never larger
 	 * than the number of the total dirtyable memory. This can only
-- 
2.23.0

