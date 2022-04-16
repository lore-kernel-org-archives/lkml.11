Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B31C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Apr 2022 02:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiDPCyh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 22:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiDPCyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:54:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402772A731
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:52:06 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KgHlJ70B6zfYlB;
        Sat, 16 Apr 2022 10:51:24 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 16 Apr
 2022 10:52:04 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/vmscan: fix comment for isolate_lru_pages
Date:   Sat, 16 Apr 2022 10:52:31 +0800
Message-ID: <20220416025231.8082-1-linmiaohe@huawei.com>
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

Since commit 791b48b64232 ("mm: vmscan: scan until it finds eligible
pages"), splicing any skipped pages to the tail of the LRU list won't
put the system at risk of premature OOM but will waste lots of cpu
cycles. Correct the comment accordingly.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6f96cf1eacb2..d75b6f94551c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2152,8 +2152,8 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 	 * Splice any skipped pages to the start of the LRU list. Note that
 	 * this disrupts the LRU order when reclaiming for lower zones but
 	 * we cannot splice to the tail. If we did then the SWAP_CLUSTER_MAX
-	 * scanning would soon rescan the same pages to skip and put the
-	 * system at risk of premature OOM.
+	 * scanning would soon rescan the same pages to skip and waste lots
+	 * of cpu cycles.
 	 */
 	if (!list_empty(&pages_skipped)) {
 		int zid;
-- 
2.23.0

