Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A735DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 22:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245225AbiBGWuy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 17:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiBGWuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:50:52 -0500
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr [80.12.242.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D326C0612A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:50:51 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id HCqPnIrPgbnFGHCqPnWY5d; Mon, 07 Feb 2022 23:50:49 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 07 Feb 2022 23:50:49 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH v2 1/2] iommu/arm-smmu-v3: Avoid open coded arithmetic in memory allocation
Date:   Mon,  7 Feb 2022 23:50:48 +0100
Message-Id: <3f7b9b202c6b6f5edc234ab7af5f208fbf8bc944.1644274051.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc_array()/kcalloc() should be used to avoid potential overflow when
a multiplication is needed to compute the size of the requested memory.

So turn a devm_kzalloc()+explicit size computation into an equivalent
devm_kcalloc().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
This is NOT compile tested.
I don't have the needed cross compiling tools.

v2: - no changes
    - Acked-by added
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6dc6d8b6b368..14d06aad0726 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2981,10 +2981,10 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
 {
 	unsigned int i;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
-	size_t size = sizeof(*cfg->l1_desc) * cfg->num_l1_ents;
 	void *strtab = smmu->strtab_cfg.strtab;
 
-	cfg->l1_desc = devm_kzalloc(smmu->dev, size, GFP_KERNEL);
+	cfg->l1_desc = devm_kcalloc(smmu->dev, cfg->num_l1_ents,
+				    sizeof(*cfg->l1_desc), GFP_KERNEL);
 	if (!cfg->l1_desc)
 		return -ENOMEM;
 
-- 
2.32.0

