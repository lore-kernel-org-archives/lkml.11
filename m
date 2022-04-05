Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8C5C4321E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 00:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839006AbiDFA5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 20:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356140AbiDEKW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:22:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1988BB8219;
        Tue,  5 Apr 2022 03:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA41D61777;
        Tue,  5 Apr 2022 10:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF061C385A1;
        Tue,  5 Apr 2022 10:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649153199;
        bh=EagtgJoqyPZf7J5pgJP96eRgqDmMIx2ztSMpC7BaJm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwynnHPRs5YlwlbXuyqGBU+37FTZTxbNncEyjGNYCsxfunw+g8hW6nemjZ9ZgviW2
         FXrtnWVowruDDU4oWrgnFErQkiN5CFtOsyKhbbhgdUvjuHpc9y8Yy8uy7qeCVYjDAv
         VsdG6Gx5HEpXpqS3eoJpd26+lC0ljfuYKzAuKy1U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianyong Wu <jianyong.wu@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 137/599] arm64/mm: avoid fixmap race condition when create pud mapping
Date:   Tue,  5 Apr 2022 09:27:11 +0200
Message-Id: <20220405070302.917553358@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianyong Wu <jianyong.wu@arm.com>

[ Upstream commit ee017ee353506fcec58e481673e4331ff198a80e ]

The 'fixmap' is a global resource and is used recursively by
create pud mapping(), leading to a potential race condition in the
presence of a concurrent call to alloc_init_pud():

kernel_init thread                          virtio-mem workqueue thread
==================                          ===========================

  alloc_init_pud(...)                       alloc_init_pud(...)
  pudp = pud_set_fixmap_offset(...)         pudp = pud_set_fixmap_offset(...)
  READ_ONCE(*pudp)
  pud_clear_fixmap(...)
                                            READ_ONCE(*pudp) // CRASH!

As kernel may sleep during creating pud mapping, introduce a mutex lock to
serialise use of the fixmap entries by alloc_init_pud(). However, there is
no need for locking in early boot stage and it doesn't work well with
KASLR enabled when early boot. So, enable lock when system_state doesn't
equal to "SYSTEM_BOOTING".

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Fixes: f4710445458c ("arm64: mm: use fixmap when creating page tables")
Link: https://lore.kernel.org/r/20220201114400.56885-1-jianyong.wu@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/mmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 991e599f7057..a9ec8c739d37 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -61,6 +61,7 @@ static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
 static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
 
 static DEFINE_SPINLOCK(swapper_pgdir_lock);
+static DEFINE_MUTEX(fixmap_lock);
 
 void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
 {
@@ -314,6 +315,12 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 	}
 	BUG_ON(p4d_bad(p4d));
 
+	/*
+	 * No need for locking during early boot. And it doesn't work as
+	 * expected with KASLR enabled.
+	 */
+	if (system_state != SYSTEM_BOOTING)
+		mutex_lock(&fixmap_lock);
 	pudp = pud_set_fixmap_offset(p4dp, addr);
 	do {
 		pud_t old_pud = READ_ONCE(*pudp);
@@ -344,6 +351,8 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 	} while (pudp++, addr = next, addr != end);
 
 	pud_clear_fixmap();
+	if (system_state != SYSTEM_BOOTING)
+		mutex_unlock(&fixmap_lock);
 }
 
 static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
-- 
2.34.1



