Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAFFC433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 23:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575188AbiDEXDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 19:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392134AbiDEPfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:35:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7DF0133D9B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:46:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76DA0D6E;
        Tue,  5 Apr 2022 06:46:35 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AEAE63F5A1;
        Tue,  5 Apr 2022 06:46:34 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     ogabbay@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH] habanalabs: Stop using iommu_present()
Date:   Tue,  5 Apr 2022 14:46:31 +0100
Message-Id: <8201946a5b8b26dab35738b87da24ff27a9f9270.1649166391.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if an IOMMU might be present for some PCI segment in the system,
that doesn't necessarily mean it provides translation for the device
we care about. Replace iommu_present() with a more appropriate check.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 8 ++++----
 drivers/misc/habanalabs/goya/goya.c   | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 21c2b678ff72..5dc66dc7618e 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6133,7 +6133,7 @@ static int gaudi_debugfs_read32(struct hl_device *hdev, u64 addr,
 			rc = -EIO;
 
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
+			user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
 
 		*val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
 
@@ -6176,7 +6176,7 @@ static int gaudi_debugfs_write32(struct hl_device *hdev, u64 addr,
 			rc = -EIO;
 
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
+			user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
 
 		*(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
 
@@ -6223,7 +6223,7 @@ static int gaudi_debugfs_read64(struct hl_device *hdev, u64 addr,
 			rc = -EIO;
 
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
+			user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
 
 		*val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
 
@@ -6268,7 +6268,7 @@ static int gaudi_debugfs_write64(struct hl_device *hdev, u64 addr,
 			rc = -EIO;
 
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
+			user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
 
 		*(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index ec9358bcbf0b..0c455bf460f4 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4309,7 +4309,7 @@ static int goya_debugfs_read32(struct hl_device *hdev, u64 addr,
 			rc = -EIO;
 
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
+			user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
 		*val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
 
 	} else {
@@ -4369,7 +4369,7 @@ static int goya_debugfs_write32(struct hl_device *hdev, u64 addr,
 			rc = -EIO;
 
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
+			user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
 		*(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
 
 	} else {
@@ -4418,7 +4418,7 @@ static int goya_debugfs_read64(struct hl_device *hdev, u64 addr,
 			rc = -EIO;
 
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
+			user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
 		*val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
 
 	} else {
@@ -4465,7 +4465,7 @@ static int goya_debugfs_write64(struct hl_device *hdev, u64 addr,
 			rc = -EIO;
 
 	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
-			user_address && !iommu_present(&pci_bus_type)) {
+			user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
 		*(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
 
 	} else {
-- 
2.28.0.dirty

