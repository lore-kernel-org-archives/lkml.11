Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B23C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Jul 2022 13:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiGDNXU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Jul 2022 09:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiGDNWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:22:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52F721B2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:22:15 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lc5xy2Fq4zhZ1C;
        Mon,  4 Jul 2022 21:19:50 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Jul
 2022 21:22:13 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <shy828301@gmail.com>, <willy@infradead.org>, <zokeefe@google.com>,
        <songmuchun@bytedance.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v3 07/16] mm/huge_memory: use helper function vma_lookup in split_huge_pages_pid
Date:   Mon, 4 Jul 2022 21:21:52 +0800
Message-ID: <20220704132201.14611-8-linmiaohe@huawei.com>
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

Use helper function vma_lookup to lookup the needed vma to simplify the
code. Minor readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f2856cfac900..5f5123130b28 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3045,10 +3045,10 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 	 * table filled with PTE-mapped THPs, each of which is distinct.
 	 */
 	for (addr = vaddr_start; addr < vaddr_end; addr += PAGE_SIZE) {
-		struct vm_area_struct *vma = find_vma(mm, addr);
+		struct vm_area_struct *vma = vma_lookup(mm, addr);
 		struct page *page;
 
-		if (!vma || addr < vma->vm_start)
+		if (!vma)
 			break;
 
 		/* skip special VMA and hugetlb VMA */
-- 
2.23.0

