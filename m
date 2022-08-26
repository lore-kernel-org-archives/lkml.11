Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639F8ECAAD6
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Aug 2022 09:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343957AbiHZJZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Aug 2022 05:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343685AbiHZJZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:25:00 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4A952090
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:24:57 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MDZ8M0VRqz19VLD;
        Fri, 26 Aug 2022 17:21:23 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 17:24:55 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 09/10] hugetlb: remove meaningless BUG_ON(huge_pte_none())
Date:   Fri, 26 Aug 2022 17:24:21 +0800
Message-ID: <20220826092422.39591-10-linmiaohe@huawei.com>
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

When code reaches here, invalid page would have been accessed if huge pte
is none. So this BUG_ON(huge_pte_none()) is meaningless. Remove it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b432a00061e3..0ef26dbdc7f8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5374,7 +5374,6 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			u32 hash;
 
 			put_page(old_page);
-			BUG_ON(huge_pte_none(pte));
 			/*
 			 * Drop hugetlb_fault_mutex and vma_lock before
 			 * unmapping.  unmapping needs to hold vma_lock
-- 
2.23.0

