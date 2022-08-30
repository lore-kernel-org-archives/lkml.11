Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04079C0502A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 12:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiH3Mgt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 08:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiH3Mgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:36:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B19FD99F4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:36:36 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MH6Fh3fQkzHnVM;
        Tue, 30 Aug 2022 20:34:48 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 20:36:34 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/6] mm, hwpoison: use __PageMovable() to detect non-lru movable pages
Date:   Tue, 30 Aug 2022 20:36:00 +0800
Message-ID: <20220830123604.25763-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220830123604.25763-1-linmiaohe@huawei.com>
References: <20220830123604.25763-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's more recommended to use __PageMovable() to detect non-lru movable
pages. We can avoid bumping page refcnt via isolate_movable_page() for
the isolated lru pages. Also if pages become PageLRU just after they're
checked but before trying to isolate them, isolate_lru_page() will be
called to do the right work.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a923a6dde871..3966fa6abe03 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2404,7 +2404,7 @@ EXPORT_SYMBOL(unpoison_memory);
 static bool isolate_page(struct page *page, struct list_head *pagelist)
 {
 	bool isolated = false;
-	bool lru = PageLRU(page);
+	bool lru = !__PageMovable(page);
 
 	if (PageHuge(page)) {
 		isolated = !isolate_hugetlb(page, pagelist);
-- 
2.23.0

