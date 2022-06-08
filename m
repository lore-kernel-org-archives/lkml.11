Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7CCC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 11:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbiFHLsg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jun 2022 07:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238098AbiFHLse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:48:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D01EDF9F;
        Wed,  8 Jun 2022 04:48:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C0F6143D;
        Wed,  8 Jun 2022 04:48:32 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB5053F73B;
        Wed,  8 Jun 2022 04:48:30 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vdpa: Use device_iommu_capable()
Date:   Wed,  8 Jun 2022 12:48:26 +0100
Message-Id: <548e316fa282ce513fabb991a4c4d92258062eb5.1654688822.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new interface to check the capability for our device
specifically.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/vhost/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 935a1d0ddb97..4cfebcc24a03 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1074,7 +1074,7 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
 	if (!bus)
 		return -EFAULT;
 
-	if (!iommu_capable(bus, IOMMU_CAP_CACHE_COHERENCY))
+	if (!device_iommu_capable(dma_dev, IOMMU_CAP_CACHE_COHERENCY))
 		return -ENOTSUPP;
 
 	v->domain = iommu_domain_alloc(bus);
-- 
2.36.1.dirty

