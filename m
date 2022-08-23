Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9803EC28D13
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 03:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbiHWDFH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 23:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239875AbiHWDEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:04:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1AF5D0ED
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:02:59 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MBYr355K3zhYC2;
        Tue, 23 Aug 2022 11:00:19 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 23 Aug
 2022 11:02:37 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <lukas.bulwahn@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 4/6] mm: hugetlb_vmemmap: add missing smp_wmb() before set_pte_at()
Date:   Tue, 23 Aug 2022 11:02:07 +0800
Message-ID: <20220823030209.57434-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220823030209.57434-1-linmiaohe@huawei.com>
References: <20220823030209.57434-1-linmiaohe@huawei.com>
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

The memory barrier smp_wmb() is needed to make sure that preceding stores
to the page contents become visible before the below set_pte_at() write.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 196159000897..ba2a2596fb4e 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -286,6 +286,11 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
 	copy_page(to, (void *)walk->reuse_addr);
 	reset_struct_pages(to);
 
+	/*
+	 * Makes sure that preceding stores to the page contents become visible
+	 * before the set_pte_at() write.
+	 */
+	smp_wmb();
 	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
 }
 
-- 
2.23.0

