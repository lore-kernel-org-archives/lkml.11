Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CC8C4167D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 14:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389598AbiDEOpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 10:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244413AbiDEJlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:41:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15136BB911;
        Tue,  5 Apr 2022 02:26:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A55C561659;
        Tue,  5 Apr 2022 09:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76F9C385A2;
        Tue,  5 Apr 2022 09:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649150783;
        bh=jdhV1ARZqjVBNBTFdsNBzGc69eetyP1wwgKMcVbjsh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ziSTaEOeucRBhDnenH2TdfNdJzyNDZntF0okMyisxPyoIjrVQigpTQRdg/Q1mYpFd
         ZFBrMtV/H0WZ4iLdvLryZleko9peK3KUbdTSFyMeL7HlWmylbVCuFESRbZQ0FrYr40
         12NwvWaU8/MgeJwSU/wGC00GHvm3ehTrNTPaLcs8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 5.15 172/913] xtensa: define update_mmu_tlb function
Date:   Tue,  5 Apr 2022 09:20:34 +0200
Message-Id: <20220405070345.007358677@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070339.801210740@linuxfoundation.org>
References: <20220405070339.801210740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

commit 1c4664faa38923330d478f046dc743a00c1e2dec upstream.

Before the commit f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault()
codepaths") there was a call to update_mmu_cache in alloc_set_pte that
used to invalidate TLB entry caching invalid PTE that caused a page
fault. That commit removed that call so now invalid TLB entry survives
causing repetitive page faults on the CPU that took the initial fault
until that TLB entry is occasionally evicted. This issue is spotted by
the xtensa TLB sanity checker.

Fix this issue by defining update_mmu_tlb function that flushes TLB entry
for the faulting address.

Cc: stable@vger.kernel.org # 5.12+
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/xtensa/include/asm/pgtable.h |    4 ++++
 arch/xtensa/mm/tlb.c              |    6 ++++++
 2 files changed, 10 insertions(+)

--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -411,6 +411,10 @@ extern  void update_mmu_cache(struct vm_
 
 typedef pte_t *pte_addr_t;
 
+void update_mmu_tlb(struct vm_area_struct *vma,
+		    unsigned long address, pte_t *ptep);
+#define __HAVE_ARCH_UPDATE_MMU_TLB
+
 #endif /* !defined (__ASSEMBLY__) */
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
--- a/arch/xtensa/mm/tlb.c
+++ b/arch/xtensa/mm/tlb.c
@@ -162,6 +162,12 @@ void local_flush_tlb_kernel_range(unsign
 	}
 }
 
+void update_mmu_tlb(struct vm_area_struct *vma,
+		    unsigned long address, pte_t *ptep)
+{
+	local_flush_tlb_page(vma, address);
+}
+
 #ifdef CONFIG_DEBUG_TLB_SANITY
 
 static unsigned get_pte_for_vaddr(unsigned vaddr)


