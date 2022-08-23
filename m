Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598D6C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 03:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbiHWDFN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 23:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239655AbiHWDET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:04:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF155D0EF
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:03:00 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MBYq14qbZzlWNY;
        Tue, 23 Aug 2022 10:59:25 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 23 Aug
 2022 11:02:37 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <lukas.bulwahn@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 5/6] mm/hugetlb: fix sysfs group leak in hugetlb_unregister_node()
Date:   Tue, 23 Aug 2022 11:02:08 +0800
Message-ID: <20220823030209.57434-6-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220823030209.57434-1-linmiaohe@huawei.com>
References: <20220823030209.57434-1-linmiaohe@huawei.com>
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

The sysfs group per_node_hstate_attr_group and hstate_demote_attr_group
when h->demote_order != 0 are created in hugetlb_register_node(). But
these sysfs groups are not removed when unregister the node, thus sysfs
group is leaked. Using sysfs_remove_group() to fix this issue.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Fengwei Yin <fengwei.yin@intel.com>
---
 mm/hugetlb.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8e62da153c64..2dfd10599f98 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3851,12 +3851,18 @@ static int hugetlb_sysfs_add_hstate(struct hstate *h, struct kobject *parent,
 	}
 
 	if (h->demote_order) {
-		if (sysfs_create_group(hstate_kobjs[hi],
-					&hstate_demote_attr_group))
+		retval = sysfs_create_group(hstate_kobjs[hi],
+					    &hstate_demote_attr_group);
+		if (retval) {
 			pr_warn("HugeTLB unable to create demote interfaces for %s\n", h->name);
+			sysfs_remove_group(hstate_kobjs[hi], hstate_attr_group);
+			kobject_put(hstate_kobjs[hi]);
+			hstate_kobjs[hi] = NULL;
+			return retval;
+		}
 	}
 
-	return retval;
+	return 0;
 }
 
 static void __init hugetlb_sysfs_init(void)
@@ -3942,10 +3948,15 @@ static void hugetlb_unregister_node(struct node *node)
 
 	for_each_hstate(h) {
 		int idx = hstate_index(h);
-		if (nhs->hstate_kobjs[idx]) {
-			kobject_put(nhs->hstate_kobjs[idx]);
-			nhs->hstate_kobjs[idx] = NULL;
-		}
+		struct kobject *hstate_kobj = nhs->hstate_kobjs[idx];
+
+		if (!hstate_kobj)
+			continue;
+		if (h->demote_order)
+			sysfs_remove_group(hstate_kobj, &hstate_demote_attr_group);
+		sysfs_remove_group(hstate_kobj, &per_node_hstate_attr_group);
+		kobject_put(hstate_kobj);
+		nhs->hstate_kobjs[idx] = NULL;
 	}
 
 	kobject_put(nhs->hugepages_kobj);
-- 
2.23.0

