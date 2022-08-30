Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA33FECAAA1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 12:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiH3Mgp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 08:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiH3Mgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:36:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA50E01EA
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:36:37 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MH6Fj29qJzHnVZ;
        Tue, 30 Aug 2022 20:34:49 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 20:36:35 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 4/6] mm, hwpoison: avoid unneeded page_mapped_in_vma() overhead in collect_procs_anon()
Date:   Tue, 30 Aug 2022 20:36:02 +0800
Message-ID: <20220830123604.25763-5-linmiaohe@huawei.com>
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

If vma->vm_mm != t->mm, there's no need to call page_mapped_in_vma() as
add_to_kill() won't be called in this case. Move up the mm check to avoid
possible unneeded calling to page_mapped_in_vma().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 69c4d1b48ad6..904c2b6284a4 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -521,11 +521,11 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 		anon_vma_interval_tree_foreach(vmac, &av->rb_root,
 					       pgoff, pgoff) {
 			vma = vmac->vma;
+			if (vma->vm_mm != t->mm)
+				continue;
 			if (!page_mapped_in_vma(page, vma))
 				continue;
-			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, FSDAX_INVALID_PGOFF, vma,
-					    to_kill);
+			add_to_kill(t, page, FSDAX_INVALID_PGOFF, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
-- 
2.23.0

