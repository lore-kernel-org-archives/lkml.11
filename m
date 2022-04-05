Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0043DC43217
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 00:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836648AbiDFAg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 20:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391218AbiDEPeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:34:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BEE44C42B;
        Tue,  5 Apr 2022 06:41:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E79A2D6E;
        Tue,  5 Apr 2022 06:41:00 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF2833F5A1;
        Tue,  5 Apr 2022 06:40:59 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] sfc: Stop using iommu_present()
Date:   Tue,  5 Apr 2022 14:40:55 +0100
Message-Id: <7350f957944ecfce6cce90f422e3992a1f428775.1649166055.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if an IOMMU might be present for some PCI segment in the system,
that doesn't necessarily mean it provides translation for the device
we care about. It appears that what we care about here is specifically
whether DMA mapping ops involve any IOMMU overhead or not, so check for
translation actually being active for our device.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/net/ethernet/sfc/falcon/rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/falcon/rx.c b/drivers/net/ethernet/sfc/falcon/rx.c
index 0c6cc2191369..6bbdb5d2eebf 100644
--- a/drivers/net/ethernet/sfc/falcon/rx.c
+++ b/drivers/net/ethernet/sfc/falcon/rx.c
@@ -718,12 +718,14 @@ static void ef4_init_rx_recycle_ring(struct ef4_nic *efx,
 				     struct ef4_rx_queue *rx_queue)
 {
 	unsigned int bufs_in_recycle_ring, page_ring_size;
+	struct iommu_domain __maybe_unused *domain;
 
 	/* Set the RX recycle ring size */
 #ifdef CONFIG_PPC64
 	bufs_in_recycle_ring = EF4_RECYCLE_RING_SIZE_IOMMU;
 #else
-	if (iommu_present(&pci_bus_type))
+	domain = iommu_get_domain_for_dev(&efx->pci_dev->dev);
+	if (domain && domain->type != IOMMU_DOMAIN_IDENTITY)
 		bufs_in_recycle_ring = EF4_RECYCLE_RING_SIZE_IOMMU;
 	else
 		bufs_in_recycle_ring = EF4_RECYCLE_RING_SIZE_NOIOMMU;
-- 
2.28.0.dirty

