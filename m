Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D13C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  1 May 2022 11:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346134AbiEALbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 May 2022 07:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346104AbiEALb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 07:31:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C3D6D38F
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 04:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651404479; x=1682940479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qUZYbemYGfqX6UdR8vYw2GY0BXDxcZJ9d/Mb3z7FWrs=;
  b=S8HKWubqDQbjTXMNVljA59OTwY/1h29/pRa/UKpG01lMH/+8yCSjJi/x
   AbDkMvfmGj1FQ9s9sc+gbp/R0bMFZZ09J8YVva6lKVtYeADHSYGQ5MYSs
   uQAsQ8x3bO+Eybo8s1zRZUGN9S+FRUVzXurxlUhHGZFQ2F+88ZL1gb+Ht
   TEU9HUg7454u7+JAVdZKARoYbon78lwm4h2zno06hpAaMPx7WDxoqfBtt
   r4FQJspyP2vM4PJDo6Bqrxc+ilfGKMQnMHv2h8iFy4wDspIswkXgrfphk
   NtqmRZlF9PhSBMRrGIDpiyLPljwj28f9RDo5J/xNbT6MmFyggpZuzaWyn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="246912737"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="246912737"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 04:27:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="545114953"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 01 May 2022 04:27:56 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 5/5] iommu/vt-d: Remove hard coding PGSNP bit in PASID entries
Date:   Sun,  1 May 2022 19:24:34 +0800
Message-Id: <20220501112434.874236-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220501112434.874236-1-baolu.lu@linux.intel.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As enforce_cache_coherency has been introduced into the iommu_domain_ops,
the kernel component which owns the iommu domain is able to opt-in its
requirement for force snooping support. The iommu driver has no need to
hard code the page snoop control bit in the PASID table entries anymore.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h | 1 -
 drivers/iommu/intel/iommu.c | 3 ---
 drivers/iommu/intel/pasid.c | 6 ------
 3 files changed, 10 deletions(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 583ea67fc783..394e6284ce1f 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -48,7 +48,6 @@
  */
 #define PASID_FLAG_SUPERVISOR_MODE	BIT(0)
 #define PASID_FLAG_NESTED		BIT(1)
-#define PASID_FLAG_PAGE_SNOOP		BIT(2)
 
 /*
  * The PASID_FLAG_FL5LP flag Indicates using 5-level paging for first-
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d5808495eb64..edd3d940eb25 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2432,9 +2432,6 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 	if (level == 5)
 		flags |= PASID_FLAG_FL5LP;
 
-	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
-		flags |= PASID_FLAG_PAGE_SNOOP;
-
 	return intel_pasid_setup_first_level(iommu, dev, (pgd_t *)pgd, pasid,
 					     domain->iommu_did[iommu->seq_id],
 					     flags);
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 815c744e6a34..dc5020320323 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -625,9 +625,6 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		}
 	}
 
-	if (flags & PASID_FLAG_PAGE_SNOOP)
-		pasid_set_pgsnp(pte);
-
 	pasid_set_domain_id(pte, did);
 	pasid_set_address_width(pte, iommu->agaw);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
@@ -710,9 +707,6 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	pasid_set_fault_enable(pte);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
 
-	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
-		pasid_set_pgsnp(pte);
-
 	/*
 	 * Since it is a second level only translation setup, we should
 	 * set SRE bit as well (addresses are expected to be GPAs).
-- 
2.25.1

