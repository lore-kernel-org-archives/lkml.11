Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FBEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jan 2022 16:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378499AbiAYQEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jan 2022 11:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344537AbiAYQD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:03:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB21AC06173D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:03:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96281B818D8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75246C340E0;
        Tue, 25 Jan 2022 16:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643126598;
        bh=KHKViS+ZOMcXA32XNvw1CZnIuutNB5Xs6JKM3HBXQfI=;
        h=From:To:Cc:Subject:Date:From;
        b=hYM1D5+uPzvDjlfDRdH4f3pp48z93xP+lQQiLcp5LxIr24/ysoaQzRTJ6Buw8OdjZ
         Dof/Z0dUBMVgcCOQebSZE1MmT1z0Z6Ta9EyDfH32tRo4/m8AC1KnpjwQkzQr5toEro
         UnLN2SQ/uKQTEOgD2z3IEwUXyfDZyQCUHAjpw8Ax6dvkQTFDI5UF0E7HOp10RrqsbY
         5WqYEURdPCuJT34B3A+fKODtI2Ng1vr6gfKSdkUctMOuvKtnQxHdl1Gps6lkUNeJMz
         WWJnPCBFe3jzG5vRMiPKKeYjitGF9pE9zmekMDbdNo83H6LyNbonlwnTK43eeANvoK
         bBccW2HwkjjvA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH] riscv: mm: remove the BUG_ON check of mapping the last 4K bytes of memory
Date:   Tue, 25 Jan 2022 23:55:42 +0800
Message-Id: <20220125155542.3753-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove the BUG_ON check of mapping the last 4K bytes of the addressable
memory since "this is true for every kernel actually" as pointed out
by Alexandre.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/mm/init.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index cf4d018b7d66..8347d0fda8cd 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -811,14 +811,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
 	BUG_ON((kernel_map.phys_addr % PMD_SIZE) != 0);
 
-#ifdef CONFIG_64BIT
-	/*
-	 * The last 4K bytes of the addressable memory can not be mapped because
-	 * of IS_ERR_VALUE macro.
-	 */
-	BUG_ON((kernel_map.virt_addr + kernel_map.size) > ADDRESS_SPACE_END - SZ_4K);
-#endif
-
 	pt_ops_set_early();
 
 	/* Setup early PGD for fixmap */
-- 
2.34.1

