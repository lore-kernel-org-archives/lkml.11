Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D76FC32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 12:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240596AbiHWM26 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 08:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242479AbiHWM0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 08:26:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAA4FBA41;
        Tue, 23 Aug 2022 02:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF03761389;
        Tue, 23 Aug 2022 09:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E77C433C1;
        Tue, 23 Aug 2022 09:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661247832;
        bh=19IgdIE9ZrUrSbXsW+/oPm9vunuXvHYium+mpiIAJ+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j0rnFBQufVR28RrYNcxTee+uem8fh9HCNi6htBgk/I1KZL0PWYQ1T4nZ0u0awQph3
         vAGiOAsSkuDVRZCoRYJScZQeRo2U1czlHBLU8qx6nAFlb+TBC9uxtcvhaUU1a3zQTD
         4KITEEddrR5kliNURb5Cv+Y+a6Y/oDlNp7wa6EcM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, xctan <xc-tan@outlook.com>,
        dram <dramforever@live.com>, Ruizhe Pan <c141028@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 138/158] riscv: mmap with PROT_WRITE but no PROT_READ is invalid
Date:   Tue, 23 Aug 2022 10:27:50 +0200
Message-Id: <20220823080051.408345634@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080046.056825146@linuxfoundation.org>
References: <20220823080046.056825146@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Celeste Liu <coelacanthus@outlook.com>

[ Upstream commit 2139619bcad7ac44cc8f6f749089120594056613 ]

As mentioned in Table 4.5 in RISC-V spec Volume 2 Section 4.3, write
but not read is "Reserved for future use.". For now, they are not valid.
In the current code, -wx is marked as invalid, but -w- is not marked
as invalid.
This patch refines that judgment.

Reported-by: xctan <xc-tan@outlook.com>
Co-developed-by: dram <dramforever@live.com>
Signed-off-by: dram <dramforever@live.com>
Co-developed-by: Ruizhe Pan <c141028@gmail.com>
Signed-off-by: Ruizhe Pan <c141028@gmail.com>
Signed-off-by: Celeste Liu <coelacanthus@outlook.com>
Link: https://lore.kernel.org/r/PH7PR14MB559464DBDD310E755F5B21E8CEDC9@PH7PR14MB5594.namprd14.prod.outlook.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/sys_riscv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 12f8a7fce78b..8a7880b9c433 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -18,9 +18,8 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
 		return -EINVAL;
 
-	if ((prot & PROT_WRITE) && (prot & PROT_EXEC))
-		if (unlikely(!(prot & PROT_READ)))
-			return -EINVAL;
+	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
+		return -EINVAL;
 
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
 			       offset >> (PAGE_SHIFT - page_shift_offset));
-- 
2.35.1



