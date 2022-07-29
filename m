Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4684AC00144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jul 2022 08:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbiG2IBk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbiG2IB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:01:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E4A4AD7D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:01:26 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LvKfq2ZH9zmVNZ;
        Fri, 29 Jul 2022 15:59:31 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Jul
 2022 16:01:22 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <almasrymina@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 4/5] hugetlb_cgroup: use helper macro NUMA_NO_NODE
Date:   Fri, 29 Jul 2022 16:01:05 +0800
Message-ID: <20220729080106.12752-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220729080106.12752-1-linmiaohe@huawei.com>
References: <20220729080106.12752-1-linmiaohe@huawei.com>
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

It's better to use NUMA_NO_NODE instead of magic number -1. Minor
readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 mm/hugetlb_cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 01a709468937..2affccfe59f1 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -154,9 +154,9 @@ hugetlb_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	 * function.
 	 */
 	for_each_node(node) {
-		/* Set node_to_alloc to -1 for offline nodes. */
+		/* Set node_to_alloc to NUMA_NO_NODE for offline nodes. */
 		int node_to_alloc =
-			node_state(node, N_NORMAL_MEMORY) ? node : -1;
+			node_state(node, N_NORMAL_MEMORY) ? node : NUMA_NO_NODE;
 		h_cgroup->nodeinfo[node] =
 			kzalloc_node(sizeof(struct hugetlb_cgroup_per_node),
 				     GFP_KERNEL, node_to_alloc);
-- 
2.23.0

