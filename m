Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5098C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 15:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242516AbiCNPed (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiCNPea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:34:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0839865FE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:33:18 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KHL9H5rwFzBrwW;
        Mon, 14 Mar 2022 23:31:15 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Mar
 2022 23:33:15 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/mlock: remove unneeded start >= vma->vm_end check
Date:   Mon, 14 Mar 2022 23:32:23 +0800
Message-ID: <20220314153223.53753-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If find_vma returns a vma, it must satisfies that start < vma->vm_end.
Since vma list is sorted in the ascending order, so we will never see
start >= vma->vm_end here. Remove this unneeded check.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/mlock.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index fefa9644d0f9..fe278634ebe3 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -509,8 +509,6 @@ static unsigned long count_mm_mlocked_page_nr(struct mm_struct *mm,
 		return 0;
 
 	for (; vma ; vma = vma->vm_next) {
-		if (start >= vma->vm_end)
-			continue;
 		if (start + len <=  vma->vm_start)
 			break;
 		if (vma->vm_flags & VM_LOCKED) {
-- 
2.23.0

