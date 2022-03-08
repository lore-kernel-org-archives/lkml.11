Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF45C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 13:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347192AbiCHNpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 08:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347200AbiCHNpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:45:02 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA6E49C8C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:44:05 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KCc292FnFzBrVk;
        Tue,  8 Mar 2022 21:42:09 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Mar
 2022 21:44:03 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <vitaly.wool@konsulko.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 2/8] mm/z3fold: remove obsolete comment in z3fold_alloc
Date:   Tue, 8 Mar 2022 21:43:05 +0800
Message-ID: <20220308134311.59086-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220308134311.59086-1-linmiaohe@huawei.com>
References: <20220308134311.59086-1-linmiaohe@huawei.com>
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

The highmem pages are supported since commit f1549cb5ab2b ("mm/z3fold.c:
allow __GFP_HIGHMEM in z3fold_alloc"). Remove the residual comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>
---
 mm/z3fold.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index e86aafea6599..87689f50f709 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1064,9 +1064,6 @@ static void z3fold_destroy_pool(struct z3fold_pool *pool)
  * performed first. If no suitable free region is found, then a new page is
  * allocated and added to the pool to satisfy the request.
  *
- * gfp should not set __GFP_HIGHMEM as highmem pages cannot be used
- * as z3fold pool pages.
- *
  * Return: 0 if success and handle is set, otherwise -EINVAL if the size or
  * gfp arguments are invalid or -ENOMEM if the pool was unable to allocate
  * a new page.
-- 
2.23.0

