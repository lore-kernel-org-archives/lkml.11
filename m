Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA9AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 17:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239725AbiCRRo1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 13:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbiCRRoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:44:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 066A09F6C2;
        Fri, 18 Mar 2022 10:43:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 977971515;
        Fri, 18 Mar 2022 10:43:04 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 270B73F7B4;
        Fri, 18 Mar 2022 10:43:03 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, baolu.lu@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Cc:     iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com, hch@lst.de
Subject: [PATCH v2 0/2] thunderbolt: Make iommu_dma_protection more accurate
Date:   Fri, 18 Mar 2022 17:42:56 +0000
Message-Id: <cover.1647624084.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, here's chapter 3 in the story of "but I really just want to
remove iommu_present()", which is the second go at this approach
on the Thunderbolt end, but now improving the IOMMU end as well
since the subtlety of why that still matters has been clarified.
Previous thread here:

https://lore.kernel.org/linux-iommu/f887686a-e7e4-f031-97e8-dbeb1c088095@arm.com/T/

Thanks,
Robin.


Robin Murphy (2):
  iommu: Add capability for pre-boot DMA protection
  thunderbolt: Make iommu_dma_protection more accurate

 drivers/iommu/intel/iommu.c  |  2 ++
 drivers/thunderbolt/domain.c | 12 +++--------
 drivers/thunderbolt/nhi.c    | 41 ++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h        |  7 ++++++
 include/linux/thunderbolt.h  |  2 ++
 5 files changed, 55 insertions(+), 9 deletions(-)

-- 
2.28.0.dirty

