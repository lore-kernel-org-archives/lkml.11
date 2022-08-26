Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10F5ECAAA3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Aug 2022 09:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343739AbiHZJZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Aug 2022 05:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343650AbiHZJYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:24:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512183F30A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:24:54 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MDZ8H3R0MzkWjK;
        Fri, 26 Aug 2022 17:21:19 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 17:24:51 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 02/10] hugetlb: Use helper macro SZ_1K
Date:   Fri, 26 Aug 2022 17:24:14 +0800
Message-ID: <20220826092422.39591-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220826092422.39591-1-linmiaohe@huawei.com>
References: <20220826092422.39591-1-linmiaohe@huawei.com>
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

Use helper macro SZ_1K to do the size conversion to make code more
consistent in this file. Minor readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 10d84abb1ca7..24f580ddf130 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4165,7 +4165,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	h->next_nid_to_alloc = first_memory_node;
 	h->next_nid_to_free = first_memory_node;
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
-					huge_page_size(h)/1024);
+					huge_page_size(h)/SZ_1K);
 
 	parsed_hstate = h;
 }
-- 
2.23.0

