Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF50C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 01:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbiGEBsJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Jul 2022 21:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiGEBsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:48:07 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FA0101DB;
        Mon,  4 Jul 2022 18:48:04 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id ZYA00152;
        Tue, 05 Jul 2022 09:47:52 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server id
 15.1.2507.9; Tue, 5 Jul 2022 09:47:53 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <alex.williamson@redhat.com>
CC:     <cohuck@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] vfio/spapr_tce: Remove the unused parameters container
Date:   Sat, 2 Jul 2022 02:46:13 -0400
Message-ID: <20220702064613.5293-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   2022705094752f058e025d35fdeb4e1095acbc5a59066
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter of container has been unused for tce_iommu_unuse_page.
So, we should delete it.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 708a95e61831..ea3d17a94e94 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -378,8 +378,7 @@ static void tce_iommu_release(void *iommu_data)
 	kfree(container);
 }
 
-static void tce_iommu_unuse_page(struct tce_container *container,
-		unsigned long hpa)
+static void tce_iommu_unuse_page(unsigned long hpa)
 {
 	struct page *page;
 
@@ -474,7 +473,7 @@ static int tce_iommu_clear(struct tce_container *container,
 			continue;
 		}
 
-		tce_iommu_unuse_page(container, oldhpa);
+		tce_iommu_unuse_page(oldhpa);
 	}
 
 	iommu_tce_kill(tbl, firstentry, pages);
@@ -524,7 +523,7 @@ static long tce_iommu_build(struct tce_container *container,
 		ret = iommu_tce_xchg_no_kill(container->mm, tbl, entry + i,
 				&hpa, &dirtmp);
 		if (ret) {
-			tce_iommu_unuse_page(container, hpa);
+			tce_iommu_unuse_page(hpa);
 			pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%ld\n",
 					__func__, entry << tbl->it_page_shift,
 					tce, ret);
@@ -532,7 +531,7 @@ static long tce_iommu_build(struct tce_container *container,
 		}
 
 		if (dirtmp != DMA_NONE)
-			tce_iommu_unuse_page(container, hpa);
+			tce_iommu_unuse_page(hpa);
 
 		tce += IOMMU_PAGE_SIZE(tbl);
 	}
-- 
2.27.0

