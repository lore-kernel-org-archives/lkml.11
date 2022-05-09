Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62733C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 13:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbiEINS3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 09:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbiEINSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:18:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C9B2A805D
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:14:08 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KxhSS4WW9zhZ19;
        Mon,  9 May 2022 21:13:28 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 21:13:59 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 01/15] mm/swap: use helper is_swap_pte() in swap_vma_readahead
Date:   Mon, 9 May 2022 21:14:02 +0800
Message-ID: <20220509131416.17553-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220509131416.17553-1-linmiaohe@huawei.com>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
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

Use helper is_swap_pte() to check whether pte is swap entry to make code
more clear. Minor readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swap_state.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 577c2848ae49..240b39ed5922 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -818,9 +818,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 	for (i = 0, pte = ra_info.ptes; i < ra_info.nr_pte;
 	     i++, pte++) {
 		pentry = *pte;
-		if (pte_none(pentry))
-			continue;
-		if (pte_present(pentry))
+		if (!is_swap_pte(pentry))
 			continue;
 		entry = pte_to_swp_entry(pentry);
 		if (unlikely(non_swap_entry(entry)))
-- 
2.23.0

