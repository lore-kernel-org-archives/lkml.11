Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249E6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 09:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiBPJPo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:15:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiBPJP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:15:29 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6482D21D0A2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:15:18 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JzByR1kmSz1FCXG;
        Wed, 16 Feb 2022 17:10:55 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 16 Feb
 2022 17:15:16 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 8/8] mm/memory-failure.c: remove unnecessary PageTransTail check
Date:   Wed, 16 Feb 2022 17:14:31 +0800
Message-ID: <20220216091431.39406-9-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220216091431.39406-1-linmiaohe@huawei.com>
References: <20220216091431.39406-1-linmiaohe@huawei.com>
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

When we reach here, we're guaranteed to have non-compound page as thp is
already splited. Remove this unnecessary PageTransTail check.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5d2e653a145d..6e7baa90214a 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1842,7 +1842,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * page_lock. We need wait writeback completion for this page or it
 	 * may trigger vfs BUG while evict inode.
 	 */
-	if (!PageTransTail(p) && !PageLRU(p) && !PageWriteback(p))
+	if (!PageLRU(p) && !PageWriteback(p))
 		goto identify_page_state;
 
 	/*
-- 
2.23.0

