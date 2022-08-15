Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665E6C25B0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 16:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiHOQVa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 12:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiHOQUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:20:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23CD0140FE
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:20:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D95D1477;
        Mon, 15 Aug 2022 09:20:40 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0B6E73F70D;
        Mon, 15 Aug 2022 09:20:37 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/16] iommu/exynos: Clean up bus_set_iommu()
Date:   Mon, 15 Aug 2022 17:20:11 +0100
Message-Id: <d7477ef546479300217ca7bccb44da8b02715a07.1660572783.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1660572783.git.robin.murphy@arm.com>
References: <cover.1660572783.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop calling bus_set_iommu() since it's now unnecessary, and simplify
the init failure path accordingly.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: No change

 drivers/iommu/exynos-iommu.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 8e18984a0c4f..45fd4850bacb 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1446,16 +1446,7 @@ static int __init exynos_iommu_init(void)
 		goto err_zero_lv2;
 	}
 
-	ret = bus_set_iommu(&platform_bus_type, &exynos_iommu_ops);
-	if (ret) {
-		pr_err("%s: Failed to register exynos-iommu driver.\n",
-								__func__);
-		goto err_set_iommu;
-	}
-
 	return 0;
-err_set_iommu:
-	kmem_cache_free(lv2table_kmem_cache, zero_lv2_table);
 err_zero_lv2:
 	platform_driver_unregister(&exynos_sysmmu_driver);
 err_reg_driver:
-- 
2.36.1.dirty

