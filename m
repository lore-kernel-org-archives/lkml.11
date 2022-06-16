Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD3BC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 12:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiFPMgL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 08:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiFPMgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:36:09 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCF1522EF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:36:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VGaLZ.H_1655382938;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VGaLZ.H_1655382938)
          by smtp.aliyun-inc.com;
          Thu, 16 Jun 2022 20:36:02 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: cpufeature: make sure cpu_mitigations_off then kpti off
Date:   Thu, 16 Jun 2022 20:35:38 +0800
Message-Id: <1655382938-126283-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

If kaslr is enabled, kpti cannot be turned off even if "mitigations=off",
adjust the code order to ensure that kpti is off when "mitigations=off".

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 arch/arm64/kernel/cpufeature.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 42ea2bd..27d4850 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1616,6 +1616,11 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 		__kpti_forced = -1;
 	}
 
+	if (cpu_mitigations_off() && !__kpti_forced) {
+		str = "mitigations=off";
+		__kpti_forced = -1;
+	}
+
 	/* Useful for KASLR robustness */
 	if (kaslr_requires_kpti()) {
 		if (!__kpti_forced) {
@@ -1624,11 +1629,6 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 		}
 	}
 
-	if (cpu_mitigations_off() && !__kpti_forced) {
-		str = "mitigations=off";
-		__kpti_forced = -1;
-	}
-
 	if (!IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0)) {
 		pr_info_once("kernel page table isolation disabled by kernel configuration\n");
 		return false;
-- 
1.8.3.1

