Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128B8C433FE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 May 2022 11:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345979AbiEALbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 May 2022 07:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345776AbiEALbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 07:31:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749906D383
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 04:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651404471; x=1682940471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5zmR7Xs8756n/cIviDuKs63tUWLeK4DQi3HgXVUT7kk=;
  b=XYa98z4mv6EDmR/wrAeeo/AhUENEhHqnDAIn4bO7tJNa1WQXAxNznv4c
   L3KvbF5mifM9qdT7VEKx7DgVl5moV0DOPm4oDysqACvp+GKMw57BDKk0b
   RJmZ27hkWTh5z3uRH23LBi7sMopqMgYiENQmPr/EhYHpSZvW8cE8bVjwL
   0tt+REcGIClxuYA1DnpT1zQevZsTIUoSLUCHRb2oE3qHuF8iC4Ck+K4yw
   onl/tdcIplrZU0fAw81w0EGTngD5XSecge+RNSIhPtnE90ihNWgQCFpwC
   iNL7fcEWZWZnCCC6AuTW0TKsVB/B9RB23U27n8ClGA/kfGQuHPv77owsT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="246912718"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="246912718"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 04:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="545114827"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 01 May 2022 04:27:48 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/5] iommu/vt-d: Set SNP bit only in second-level page table entries
Date:   Sun,  1 May 2022 19:24:31 +0800
Message-Id: <20220501112434.874236-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220501112434.874236-1-baolu.lu@linux.intel.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SNP bit is only valid for second-level PTEs. Setting this bit in the
first-level PTEs has no functional impact because the Intel IOMMU always
ignores the same bit in first-level PTEs. Anyway, let's check the page
table type before setting SNP bit in PTEs to make the code more readable.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d68f5bbf3e93..98050943d863 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4431,7 +4431,7 @@ static int intel_iommu_map(struct iommu_domain *domain,
 		prot |= DMA_PTE_READ;
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= DMA_PTE_WRITE;
-	if (dmar_domain->force_snooping)
+	if (dmar_domain->force_snooping && !domain_use_first_level(dmar_domain))
 		prot |= DMA_PTE_SNP;
 
 	max_addr = iova + size;
-- 
2.25.1

