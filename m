Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E354ECAAD2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 07:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiH2HNb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 03:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiH2HN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:13:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D414D819
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 00:13:28 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MGM5S26bMzlWZh;
        Mon, 29 Aug 2022 15:10:04 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 29 Aug
 2022 15:13:25 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <iommu@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <yuancan@huawei.com>
Subject: [PATCH] iommu: fix resource leak in iommu_group_alloc
Date:   Mon, 29 Aug 2022 07:11:25 +0000
Message-ID: <20220829071125.104173-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When it fails to create file for reserved_regions and type
of an iommu_group, the iommu_group_alloc returns ERR_PTR
without releasing the iommu_group.
Add error handling to cleanup leaking resources.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/iommu/iommu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1ca59afc8472..fff23231b5fc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -675,15 +675,22 @@ struct iommu_group *iommu_group_alloc(void)
 	ret = iommu_group_create_file(group,
 				      &iommu_group_attr_reserved_regions);
 	if (ret)
-		return ERR_PTR(ret);
+		goto out_put_group;
 
 	ret = iommu_group_create_file(group, &iommu_group_attr_type);
 	if (ret)
-		return ERR_PTR(ret);
+		goto out_remove_file;
 
 	pr_debug("Allocated group %d\n", group->id);
 
 	return group;
+
+out_remove_file:
+	iommu_group_remove_file(group, &iommu_group_attr_reserved_regions);
+out_put_group:
+	iommu_group_put(group);
+
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(iommu_group_alloc);
 
-- 
2.17.1

