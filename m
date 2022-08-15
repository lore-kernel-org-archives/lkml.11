Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A3DC00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 16:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiHOQUf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 12:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiHOQU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:20:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83FFADF01
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:20:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2194B1480;
        Mon, 15 Aug 2022 09:20:27 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D406A3F70D;
        Mon, 15 Aug 2022 09:20:24 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/16] iommu/amd: Handle race between registration and device probe
Date:   Mon, 15 Aug 2022 17:20:03 +0100
Message-Id: <a8d8ebe12b411d28972f1ab928c6db92e8913cf5.1660572783.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1660572783.git.robin.murphy@arm.com>
References: <cover.1660572783.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for the Intel driver, make sure the AMD driver can cope with seeing
.probe_device calls without having to wait for all known instances to
register first.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: No change

 drivers/iommu/amd/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 65b8e4fd8217..5ed9fd40d2a7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1851,6 +1851,10 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	if (!iommu)
 		return ERR_PTR(-ENODEV);
 
+	/* Not registered yet? */
+	if (!iommu->iommu.ops)
+		return ERR_PTR(-ENODEV);
+
 	if (dev_iommu_priv_get(dev))
 		return &iommu->iommu;
 
-- 
2.36.1.dirty

