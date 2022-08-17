Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC8DC25B08
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 10:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbiHQKQW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 06:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiHQKQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:16:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B7E54CB2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:16:15 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M73nW64MGz67NYP;
        Wed, 17 Aug 2022 18:15:59 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 12:16:13 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 11:16:11 +0100
From:   John Garry <john.garry@huawei.com>
To:     <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/3] iova: Remove magazine BUG_ON() checks
Date:   Wed, 17 Aug 2022 18:09:43 +0800
Message-ID: <1660730984-30333-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1660730984-30333-1-git-send-email-john.garry@huawei.com>
References: <1660730984-30333-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two of the magazine helpers have BUG_ON() checks, as follows:
- iova_magazine_pop() - here we ensure that the mag is not empty. However we
  already ensure that in the only caller, __iova_rcache_get().
- iova_magazine_push() - here we ensure that the mag is not full. However
  we already ensure that in the only caller, __iova_rcache_insert().

As described, the two bug checks are pointless so drop them.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 580fdf669922..8aece052ce72 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -694,8 +694,6 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
 	int i;
 	unsigned long pfn;
 
-	BUG_ON(iova_magazine_empty(mag));
-
 	/* Only fall back to the rbtree if we have no suitable pfns at all */
 	for (i = mag->size - 1; mag->pfns[i] > limit_pfn; i--)
 		if (i == 0)
@@ -710,8 +708,6 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
 
 static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
 {
-	BUG_ON(iova_magazine_full(mag));
-
 	mag->pfns[mag->size++] = pfn;
 }
 
-- 
2.35.3

