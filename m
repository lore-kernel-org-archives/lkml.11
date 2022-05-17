Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57C3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 18:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352406AbiEQSxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 14:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352390AbiEQSxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:53:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEF94E38C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DD3B6145E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A89DC385B8;
        Tue, 17 May 2022 18:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652813608;
        bh=LcIKTyeK4tmxJB9koH8qnVbXxAaq79HYjVBPayYCxz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iuZ2Q6YsSJiu2DBUdKBu7CSFr2twcCWFoxz/MkvPHj0JASt6i4u6Ep8MJFpsvJX3y
         lSuAIU39tVkBhlykcnhmTNX4bKehkS0ncVtDuuvbIjIQ1n3SgfXC5+e2V30eC861A0
         wdiS0bXJ4vT0j20qSG+SGipIEGREOghZ8QFHvK3BMOz4+uldH/Y35gvt5UWb5CJM7W
         TpaGaFA+WL0mEb24JFSCg/mm+Ob4qzG5K9Nbhh03NNEOvHCCOe6o/cGF8oIL0feiPr
         TE9u8vaqamGC+Ap2rRraj6LDZEB1K105XjSgezzQdAcNfIq4MrpZuK2HKdLLyfeZ/5
         1VP5iOQIWfY+Q==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] riscv: switch has_fpu() to the unified static key mechanism
Date:   Wed, 18 May 2022 02:44:53 +0800
Message-Id: <20220517184453.3558-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220517184453.3558-1-jszhang@kernel.org>
References: <20220517184453.3558-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to use the unified static key mechanism instead of putting
static key related here and there.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/switch_to.h | 5 +++--
 arch/riscv/kernel/cpufeature.c     | 7 -------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 0a3f4f95c555..3f407182080d 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -8,6 +8,7 @@
 
 #include <linux/jump_label.h>
 #include <linux/sched/task_stack.h>
+#include <asm/hwcap.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/csr.h>
@@ -56,10 +57,10 @@ static inline void __switch_to_aux(struct task_struct *prev,
 	fstate_restore(next, task_pt_regs(next));
 }
 
-extern struct static_key_false cpu_hwcap_fpu;
 static __always_inline bool has_fpu(void)
 {
-	return static_branch_likely(&cpu_hwcap_fpu);
+	return riscv_isa_have_key_extension(RISCV_ISA_EXT_d) ||
+		riscv_isa_have_key_extension(RISCV_ISA_EXT_f);
 }
 #else
 static __always_inline bool has_fpu(void) { return false; }
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 89f886b35357..0235391be84b 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -21,9 +21,6 @@ unsigned long elf_hwcap __read_mostly;
 /* Host ISA bitmap */
 static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 
-#ifdef CONFIG_FPU
-__ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
-#endif
 __ro_after_init DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
 EXPORT_SYMBOL(riscv_isa_ext_keys);
 
@@ -239,8 +236,4 @@ void __init riscv_fill_hwcap(void)
 		if (j >= 0)
 			static_branch_enable(&riscv_isa_ext_keys[j]);
 	}
-#ifdef CONFIG_FPU
-	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
-		static_branch_enable(&cpu_hwcap_fpu);
-#endif
 }
-- 
2.34.1

