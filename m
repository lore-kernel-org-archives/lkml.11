Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FABC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Jul 2022 13:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiGDNYF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Jul 2022 09:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiGDNWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:22:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7D06442
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:22:19 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Lc5zv3SylzYd0w;
        Mon,  4 Jul 2022 21:21:31 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Jul
 2022 21:22:17 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <shy828301@gmail.com>, <willy@infradead.org>, <zokeefe@google.com>,
        <songmuchun@bytedance.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v3 13/16] mm/huge_memory: fix comment of page_deferred_list
Date:   Mon, 4 Jul 2022 21:21:58 +0800
Message-ID: <20220704132201.14611-14-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220704132201.14611-1-linmiaohe@huawei.com>
References: <20220704132201.14611-1-linmiaohe@huawei.com>
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

The current comment is confusing because if global or memcg deferred list
in the second tail page is occupied by compound_head, why we still use
page[2].deferred_list here? I think it wants to say that Global or memcg
deferred list in the first tail page is occupied by compound_mapcount and
compound_pincount so we use the second tail page's deferred_list instead.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/huge_mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 12b297f9951d..37f2f11a6d7e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -294,8 +294,8 @@ static inline bool thp_migration_supported(void)
 static inline struct list_head *page_deferred_list(struct page *page)
 {
 	/*
-	 * Global or memcg deferred list in the second tail pages is
-	 * occupied by compound_head.
+	 * See organization of tail pages of compound page in
+	 * "struct page" definition.
 	 */
 	return &page[2].deferred_list;
 }
-- 
2.23.0

