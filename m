Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5029C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 13:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiEINTJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 09:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbiEINSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:18:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3442A9743
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:14:13 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KxhSn5gd7zhZ26;
        Mon,  9 May 2022 21:13:45 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 21:14:07 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 12/15] mm/swap: fix the obsolete comment for SWP_TYPE_SHIFT
Date:   Mon, 9 May 2022 21:14:13 +0800
Message-ID: <20220509131416.17553-13-linmiaohe@huawei.com>
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

Since commit 3159f943aafd ("xarray: Replace exceptional entries"), there
is only one bit of 'type' can be shifted up. Update the corresponding
comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/swapops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 7db424e2dcb1..bb7afd03a324 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -13,10 +13,10 @@
  * get good packing density in that tree, so the index should be dense in
  * the low-order bits.
  *
- * We arrange the `type' and `offset' fields so that `type' is at the seven
+ * We arrange the `type' and `offset' fields so that `type' is at the six
  * high-order bits of the swp_entry_t and `offset' is right-aligned in the
  * remaining bits.  Although `type' itself needs only five bits, we allow for
- * shmem/tmpfs to shift it all up a further two bits: see swp_to_radix_entry().
+ * shmem/tmpfs to shift it all up a further one bit: see swp_to_radix_entry().
  *
  * swp_entry_t's are *never* stored anywhere in their arch-dependent format.
  */
-- 
2.23.0

