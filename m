Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2A2C32772
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 10:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiHQKQT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 06:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiHQKQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:16:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1478554CB2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:16:13 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M73h560fhz67Prk;
        Wed, 17 Aug 2022 18:11:17 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 12:16:11 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 11:16:09 +0100
From:   John Garry <john.garry@huawei.com>
To:     <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/3] iova: Remove some magazine pointer NULL checks
Date:   Wed, 17 Aug 2022 18:09:42 +0800
Message-ID: <1660730984-30333-2-git-send-email-john.garry@huawei.com>
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

Since commit 32e92d9f6f87 ("iommu/iova: Separate out rcache init") it
has not been possible to have NULL CPU rcache "loaded" or "prev" magazine
pointers. As such, the checks in iova_magazine_full(),
iova_magazine_empty(), and iova_magazine_free_pfns() may be dropped.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 47d1983dfa2a..580fdf669922 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -661,9 +661,6 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 	unsigned long flags;
 	int i;
 
-	if (!mag)
-		return;
-
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 
 	for (i = 0 ; i < mag->size; ++i) {
@@ -683,12 +680,12 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 
 static bool iova_magazine_full(struct iova_magazine *mag)
 {
-	return (mag && mag->size == IOVA_MAG_SIZE);
+	return mag->size == IOVA_MAG_SIZE;
 }
 
 static bool iova_magazine_empty(struct iova_magazine *mag)
 {
-	return (!mag || mag->size == 0);
+	return mag->size == 0;
 }
 
 static unsigned long iova_magazine_pop(struct iova_magazine *mag,
-- 
2.35.3

