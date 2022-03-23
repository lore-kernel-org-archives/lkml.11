Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41238C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 01:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241123AbiCWB1M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 21:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiCWB1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:27:10 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8772D6E8F8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:25:41 -0700 (PDT)
X-UUID: d4584398dece4b498383da4c3e9861c1-20220323
X-UUID: d4584398dece4b498383da4c3e9861c1-20220323
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <xieming@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1789687103; Wed, 23 Mar 2022 09:24:49 +0800
X-ns-mid: postfix-623A770C-942667795
Received: from localhost.localdomain (unknown [172.20.12.223])
        by cs2c.com.cn (NSMail) with ESMTPA id C287C383C640;
        Wed, 23 Mar 2022 01:25:32 +0000 (UTC)
From:   xieming <xieming@kylinos.cn>
To:     christoffer.dall@arm.com, marc.zyngier@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, xieming@kylinos.cn
Subject: [PATCH] kvm: fix gpu passthrough into vm on arm64
Date:   Wed, 23 Mar 2022 09:25:19 +0800
Message-Id: <20220323012519.521058-1-xieming@kylinos.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) when passthrough some pcie device, such as AMD gpus,
        kvm will report:"Unsupported FSC:" err.

2) the main reason is kvm setting memory type to
   PAGE_S2_DEVICE(DEVICE_nGnRE), but in guestos, all of device io memory
   type when ioremapping (including gpu driver TTM memory type) is
   setting to MT_NORMAL_NC.

3) according to ARM64 stage1&stage2 conbining rules.
   memory type attributes combining rules:
   Normal-WB < Normal-WT <  NormalNC <  Device-GRE <  Device-nGRE <
   DevicenGnRE < Device-nGnRnE
   Normal-WB is weakest,Device-nGnRnE is strongest.

   refferring to 'Arm Architecture Reference Manual Armv8,
   for Armv8-A architecture profile' pdf, chapter B2.8
   refferring to 'ARM System Memory Management Unit Architecture
   Specification SMMU architecture version 3.0 and version 3.1' pdf,
   chapter 13.1.5

4) therefore, the I/O memory attribute of the VM is setting to
   DevicenGnRE is a big mistake. it causes all device memory accessing in
   the virtual machine must be aligned.

   To summarize: stage2 memory type cannot be stronger than stage1 in
   arm64 archtechture.

Signed-off-by: xieming <xieming@kylinos.cn>
---
 virt/kvm/arm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 11103b75c596..9b7fb13f4546 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1209,7 +1209,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 	pfn = __phys_to_pfn(pa);
 
 	for (addr = guest_ipa; addr < end; addr += PAGE_SIZE) {
-		pte_t pte = pfn_pte(pfn, PAGE_S2_DEVICE);
+		pte_t pte = pfn_pte(pfn, PAGE_S2);
 
 		if (writable)
 			pte = kvm_s2pte_mkwrite(pte);
-- 
2.27.0

