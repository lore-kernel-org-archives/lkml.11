Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DD7C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 14:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbiB1OER (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 09:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiB1OEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:04:13 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF40533A0B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:03:33 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K6hs42mnPzccx1;
        Mon, 28 Feb 2022 22:02:16 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 28 Feb
 2022 22:03:31 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 1/4] mm/memory-failure.c: fix race with changing page compound again
Date:   Mon, 28 Feb 2022 22:02:42 +0800
Message-ID: <20220228140245.24552-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220228140245.24552-1-linmiaohe@huawei.com>
References: <20220228140245.24552-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race window where we got the compound_head, the hugetlb page
could be freed to buddy, or even changed to another compound page just
before we try to get hwpoison page. If this happens, just bail out.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5444a8ef4867..0d7c58340a98 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1534,6 +1534,17 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	}
 
 	lock_page(head);
+
+	/**
+	 * The page could have changed compound pages due to race window.
+	 * If this happens just bail out.
+	 */
+	if (!PageHuge(p) || compound_head(p) != head) {
+		action_result(pfn, MF_MSG_DIFFERENT_COMPOUND, MF_IGNORED);
+		res = -EBUSY;
+		goto out;
+	}
+
 	page_flags = head->flags;
 
 	if (hwpoison_filter(p)) {
-- 
2.23.0

