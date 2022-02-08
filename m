Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA54C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 01:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242885AbiBHBs4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245423AbiBHB1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:27:54 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592C1C0401C9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 17:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644283672; x=1675819672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v33tBhS6iHtpgvcd5VzkFlhXhg4W9ZiFf3SVGw4ZxjY=;
  b=npF3fdGPL5iyGpKmyBy4ZaX9fy7RQ2CZCbzu+VTfRgzccr5Ek5KkWb0c
   P/7W8VQQSgvMoq78MJAJ71wdj8CaiuofKN6rwcWViZohNWJ9Fd6odLyI3
   HmCIE3jz7w8HqN/gnuzoohQKOup+3cKQIDjcmyw4eIKITB/XwHxyBoP/r
   ME3fErJAg3quzFtn6WpCISlB7YLSoZhtVuCpu8zh2mOCZmXaHw5WeLKsb
   LXorwq8WEYhZ+3EMcMy20E1mgAlQUoAurqelYA/VA6RU+ruYoEAys6ENw
   Vkn1pcFPs8BU0A3eSN1Wh/DyQj6a8H7mw0Jjw2nucG6XzyLfGkxF0dpnk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="236251981"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="236251981"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 17:27:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="677948843"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 17:27:48 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 06/10] drm/nouveau/device: Get right pgsize_bitmap of iommu_domain
Date:   Tue,  8 Feb 2022 09:25:55 +0800
Message-Id: <20220208012559.1121729-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The supported page sizes of an iommu_domain are saved in the pgsize_bitmap
field. Retrieve the value from the right place.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/20211218074546.1772553-1-baolu.lu@linux.intel.com
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
index d0d52c1d4aee..992cc285f2fe 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
@@ -133,7 +133,7 @@ nvkm_device_tegra_probe_iommu(struct nvkm_device_tegra *tdev)
 		 * or equal to the system's PAGE_SIZE, with a preference if
 		 * both are equal.
 		 */
-		pgsize_bitmap = tdev->iommu.domain->ops->pgsize_bitmap;
+		pgsize_bitmap = tdev->iommu.domain->pgsize_bitmap;
 		if (pgsize_bitmap & PAGE_SIZE) {
 			tdev->iommu.pgshift = PAGE_SHIFT;
 		} else {
-- 
2.25.1

