Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C9DC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 May 2022 12:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiEHMmm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 May 2022 08:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiEHMme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 08:42:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C06FD2D
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652013523; x=1683549523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eGei70TdCcyqJEmDRek1hExpZpSxGelpQ6HhzQKlC2s=;
  b=J1Pvi03ZKwxsNHhzpH8+QM+rLJI4cBWpk67/IFBy7DvVE075GxGCqUGv
   A1KsSU2/+D7tSkffzw917taJGh7B3BBEzVYFSLV9RzRDV60uZde/+3dGj
   Dj7E9rTBvN9RBRB2slZx+u61MXApOWN8BwYLes2ZdoF9KkC9NA/fq3UEu
   Lah976zfY+pNZ0RRTPqLcKnYwhqMjk2iu/EHJcPhRtFdNI+nAlcbmul9s
   5/ukSZvMBJ7CFoABw8XlUMmGbKfMx7PWNqW04JpL1TYm5jmcp9J7DayaL
   zn3xowMwDz7ftPklXn9jGq0O7JwwgNhuUQQLYOOY4HSG4dreXK85seaeO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="267674816"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="267674816"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 05:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="710143757"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 08 May 2022 05:38:41 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 4/4] iommu/vt-d: Remove hard coding PGSNP bit in PASID entries
Date:   Sun,  8 May 2022 20:35:25 +0800
Message-Id: <20220508123525.1973626-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508123525.1973626-1-baolu.lu@linux.intel.com>
References: <20220508123525.1973626-1-baolu.lu@linux.intel.com>
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/pasid.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index d19dd66a670c..cb4c1d0cf25c 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -710,9 +710,6 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
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

