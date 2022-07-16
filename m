Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DB5C43334
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jul 2022 11:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiGPLuP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jul 2022 07:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGPLuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 07:50:12 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F6421E18
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 04:50:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VJUDiDf_1657972181;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VJUDiDf_1657972181)
          by smtp.aliyun-inc.com;
          Sat, 16 Jul 2022 19:50:06 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: remove useless assignment in nvme_pci_setup_prps
Date:   Sat, 16 Jul 2022 19:49:41 +0800
Message-Id: <1657972181-72398-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

If prp_list is NULL, nvme_unmap_sg will be performed, and the assignment
to first_dma is meaningless, so remove it.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 193b447..3872e33 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -670,7 +670,6 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 
 	prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
 	if (!prp_list) {
-		iod->first_dma = dma_addr;
 		iod->npages = -1;
 		return BLK_STS_RESOURCE;
 	}
-- 
1.8.3.1

