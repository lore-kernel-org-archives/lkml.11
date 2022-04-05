Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CE3C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 02:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1847063AbiDFCMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 22:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378484AbiDENNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:13:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A500B45056
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:13:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EB9ED6E;
        Tue,  5 Apr 2022 05:13:37 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F7643F5A1;
        Tue,  5 Apr 2022 05:13:36 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     iommu@lists.linux-foundation.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: emu10k1: Stop using iommu_present()
Date:   Tue,  5 Apr 2022 13:13:33 +0100
Message-Id: <5ac9b54285b2189b848da2595408eb3cae8e5e9d.1649160813.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu_get_domain_for_dev() is already perfectly happy to return NULL
if the given device has no IOMMU. Drop the unnecessary check.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 sound/pci/emu10k1/emu10k1_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 86cc1ca025e4..5ffab343b89c 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1751,9 +1751,6 @@ static void snd_emu10k1_detect_iommu(struct snd_emu10k1 *emu)
 
 	emu->iommu_workaround = false;
 
-	if (!iommu_present(emu->card->dev->bus))
-		return;
-
 	domain = iommu_get_domain_for_dev(emu->card->dev);
 	if (domain && domain->type == IOMMU_DOMAIN_IDENTITY)
 		return;
-- 
2.28.0.dirty

