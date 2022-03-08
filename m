Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D255C433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 13:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347232AbiCHNp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 08:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347209AbiCHNpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:45:03 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081F949C94
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:44:07 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KCc2q0rKzzdg0l;
        Tue,  8 Mar 2022 21:42:43 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Mar
 2022 21:44:04 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <vitaly.wool@konsulko.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 5/8] mm/z3fold: remove confusing local variable l reassignment
Date:   Tue, 8 Mar 2022 21:43:08 +0800
Message-ID: <20220308134311.59086-6-linmiaohe@huawei.com>
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

The local variable l holds the address of unbuddied[i] which won't change
after we take the pool lock. Remove it to avoid confusion.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>
---
 mm/z3fold.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 2f848ea45b4d..adc0b3fa4906 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -876,7 +876,6 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 
 		/* Re-check under lock. */
 		spin_lock(&pool->lock);
-		l = &unbuddied[i];
 		if (unlikely(zhdr != list_first_entry(READ_ONCE(l),
 						struct z3fold_header, buddy)) ||
 		    !z3fold_page_trylock(zhdr)) {
-- 
2.23.0

