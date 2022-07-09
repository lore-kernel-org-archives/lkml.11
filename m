Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082DBC433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Jul 2022 09:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiGIJZj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Jul 2022 05:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIJZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:25:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DBB67CB3
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 02:25:35 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lg4R72NcTzTgbm;
        Sat,  9 Jul 2022 17:21:55 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 9 Jul
 2022 17:25:33 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/mmap: fix obsolete comment of find_extend_vma
Date:   Sat, 9 Jul 2022 17:25:27 +0800
Message-ID: <20220709092527.47778-1-linmiaohe@huawei.com>
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

mmget_still_valid() has already been removed via commit 4d45e75a9955
("mm: remove the now-unnecessary mmget_still_valid() hack"). Update
the corresponding comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/mmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 03c9ca35e0f4..4c10ffe80634 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2126,7 +2126,6 @@ find_extend_vma(struct mm_struct *mm, unsigned long addr)
 	vma = find_vma_prev(mm, addr, &prev);
 	if (vma && (vma->vm_start <= addr))
 		return vma;
-	/* don't alter vm_end if the coredump is running */
 	if (!prev || expand_stack(prev, addr))
 		return NULL;
 	if (prev->vm_flags & VM_LOCKED)
-- 
2.23.0

