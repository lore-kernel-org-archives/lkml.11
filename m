Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E71C43217
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 01:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1844166AbiDFBqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 21:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357363AbiDELQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:16:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60157DF53;
        Tue,  5 Apr 2022 03:41:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 193ACD6E;
        Tue,  5 Apr 2022 03:41:09 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A35C13F5A1;
        Tue,  5 Apr 2022 03:41:07 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, baolu.lu@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Cc:     iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com, hch@lst.de
Subject: [PATCH v3 0/4] thunderbolt: Make iommu_dma_protection more accurate
Date:   Tue,  5 Apr 2022 11:41:00 +0100
Message-Id: <cover.1649089693.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's the third and hopefully final outing for this series, addressing
Mika's review comments from last time and taking advantage of 5.18-rc1
goodies to be even cleaner and more complete. I've also picked up
Mario's AMD IOMMU patch to keep the whole topic together.

Unless there's other pending Thunderbolt development which might
conflict, I suspect it would be simplest for the whole lot to go through
the IOMMU tree.

Thanks,
Robin.


Mario Limonciello (1):
  iommu/amd: Indicate whether DMA remap support is enabled

Robin Murphy (3):
  iommu: Introduce device_iommu_capable()
  iommu: Add capability for pre-boot DMA protection
  thunderbolt: Make iommu_dma_protection more accurate

 drivers/iommu/amd/amd_iommu_types.h         |  4 ++
 drivers/iommu/amd/init.c                    |  3 ++
 drivers/iommu/amd/iommu.c                   |  4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  2 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  2 +-
 drivers/iommu/fsl_pamu_domain.c             |  2 +-
 drivers/iommu/intel/iommu.c                 |  4 +-
 drivers/iommu/iommu.c                       | 25 +++++++++++-
 drivers/iommu/s390-iommu.c                  |  2 +-
 drivers/thunderbolt/domain.c                | 12 ++----
 drivers/thunderbolt/nhi.c                   | 44 +++++++++++++++++++++
 include/linux/iommu.h                       | 10 ++++-
 include/linux/thunderbolt.h                 |  2 +
 14 files changed, 100 insertions(+), 18 deletions(-)

-- 
2.28.0.dirty

