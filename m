Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F063C00144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jul 2022 08:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiG2IBp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbiG2IB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:01:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CEA4F69E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:01:23 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LvKdy2p8gzlWZj;
        Fri, 29 Jul 2022 15:58:46 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Jul
 2022 16:01:21 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <almasrymina@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 2/5] hugetlb_cgroup: hugetlbfs: use helper macro SZ_1{K,M,G}
Date:   Fri, 29 Jul 2022 16:01:03 +0800
Message-ID: <20220729080106.12752-3-linmiaohe@huawei.com>
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

Use helper macro SZ_1K, SZ_1M and SZ_1G to do the size conversion. Minor
readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 mm/hugetlb_cgroup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index d16eb00c947d..01a709468937 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -675,12 +675,12 @@ static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
 
 static char *mem_fmt(char *buf, int size, unsigned long hsize)
 {
-	if (hsize >= (1UL << 30))
-		snprintf(buf, size, "%luGB", hsize >> 30);
-	else if (hsize >= (1UL << 20))
-		snprintf(buf, size, "%luMB", hsize >> 20);
+	if (hsize >= SZ_1G)
+		snprintf(buf, size, "%luGB", hsize / SZ_1G);
+	else if (hsize >= SZ_1M)
+		snprintf(buf, size, "%luMB", hsize / SZ_1M);
 	else
-		snprintf(buf, size, "%luKB", hsize >> 10);
+		snprintf(buf, size, "%luKB", hsize / SZ_1K);
 	return buf;
 }
 
-- 
2.23.0

