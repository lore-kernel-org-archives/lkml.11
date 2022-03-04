Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19CAC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 09:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbiCDJgy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 04:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbiCDJgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:36:02 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF0118A7B6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:35:11 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K92jW2DJgzdb9k;
        Fri,  4 Mar 2022 17:33:51 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Mar
 2022 17:35:08 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <willy@infradead.org>, <ying.huang@intel.com>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <ave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 13/16] mm/migration: return errno when isolate_huge_page failed
Date:   Fri, 4 Mar 2022 17:34:06 +0800
Message-ID: <20220304093409.25829-14-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220304093409.25829-1-linmiaohe@huawei.com>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should return errno (-EBUSY here) when failed to isolate the huge page
rather than always return 1 which could confuse the user.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/migrate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 6c2dfed2ddb8..279940c0c064 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1618,10 +1618,8 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 		goto out_putpage;
 
 	if (PageHuge(page)) {
-		if (PageHead(page)) {
-			isolate_huge_page(page, pagelist);
-			err = 1;
-		}
+		if (PageHead(page))
+			err = isolate_huge_page(page, pagelist) ? 1 : -EBUSY;
 	} else {
 		struct page *head;
 
-- 
2.23.0

