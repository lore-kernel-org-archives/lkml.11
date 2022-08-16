Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AEDC32773
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 13:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiHPNGc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 09:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbiHPNGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:06:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83B3639D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:06:21 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M6WZ02KypzmVX4;
        Tue, 16 Aug 2022 21:04:08 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 16 Aug
 2022 21:06:18 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/6] mm/hugetlb: fix missing call to restore_reserve_on_error()
Date:   Tue, 16 Aug 2022 21:05:50 +0800
Message-ID: <20220816130553.31406-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220816130553.31406-1-linmiaohe@huawei.com>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
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

When huge_add_to_page_cache() fails, the page is freed directly without
calling restore_reserve_on_error() to restore reserve for newly allocated
pages not in page cache. Fix this by calling restore_reserve_on_error()
when huge_add_to_page_cache fails.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ff991e5bdf1f..b69d7808f457 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5603,6 +5603,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		if (vma->vm_flags & VM_MAYSHARE) {
 			int err = huge_add_to_page_cache(page, mapping, idx);
 			if (err) {
+				restore_reserve_on_error(h, vma, haddr, page);
 				put_page(page);
 				if (err == -EEXIST)
 					goto retry;
-- 
2.23.0

