Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D5DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 15:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbiBXPSr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbiBXPS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F0214A222
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=UmW7C0K30Hnm1Upg5kDM2T7AbuWknewOauqVLLZuMZ4=; b=mTgQEEQzs1YThIRpoV3/mR9UIa
        91GM4ec3Ss48ufzrn7gUO6p0X4ynl0E1FU5gAzneDyItOPhYZsOurIlsuPH/hyBmGYzAvKvMKIfdf
        N79Qa9at9o5epAKr0u2p9mWoVeN9c20OrOnxnT5EjZojU/Rnj3az3jP3g3OVDwlpQB2fnXU4XMBIY
        14/4yWc9x0YneJ1K4Z9uufBOmzZZP97oKGI9ERtS7NdVMEMMQPtyoWNQa/VPfpzgKao5rLPDha4r8
        8aTBBZEi+CyklvGeRfysypKQxG8Dk0CcpbPrA13eqNxuSXotrxiS/U9k0HBmtp3kQuUasgmvhIzdk
        Y5pUNDmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs3-004s1w-6S; Thu, 24 Feb 2022 15:17:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2635F300776;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 429E029E75E59; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151322.539002964@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:51:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 09/39] x86/ibt,paravirt: Sprinkle ENDBR
References: <20220224145138.952963315@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S                 |    1 +
 arch/x86/include/asm/paravirt.h           |    1 +
 arch/x86/include/asm/qspinlock_paravirt.h |    3 +++
 arch/x86/kernel/kvm.c                     |    3 ++-
 arch/x86/kernel/paravirt.c                |    2 ++
 5 files changed, 9 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -635,6 +635,7 @@ SYM_INNER_LABEL(restore_regs_and_return_
 
 SYM_INNER_LABEL_ALIGN(native_iret, SYM_L_GLOBAL)
 	UNWIND_HINT_IRET_REGS
+	ENDBR // paravirt_iret
 	/*
 	 * Are we returning to a stack segment from the LDT?  Note: in
 	 * 64-bit mode SS:RSP on the exception stack is always valid.
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -666,6 +666,7 @@ bool __raw_callee_save___native_vcpu_is_
 	    ".globl " PV_THUNK_NAME(func) ";"				\
 	    ".type " PV_THUNK_NAME(func) ", @function;"			\
 	    PV_THUNK_NAME(func) ":"					\
+	    ASM_ENDBR							\
 	    FRAME_BEGIN							\
 	    PV_SAVE_ALL_CALLER_REGS					\
 	    "call " #func ";"						\
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_QSPINLOCK_PARAVIRT_H
 #define __ASM_QSPINLOCK_PARAVIRT_H
 
+#include <asm/ibt.h>
+
 /*
  * For x86-64, PV_CALLEE_SAVE_REGS_THUNK() saves and restores 8 64-bit
  * registers. For i386, however, only 1 32-bit register needs to be saved
@@ -39,6 +41,7 @@ asm    (".pushsection .text;"
 	".type " PV_UNLOCK ", @function;"
 	".align 4,0x90;"
 	PV_UNLOCK ": "
+	ASM_ENDBR
 	FRAME_BEGIN
 	"push  %rdx;"
 	"mov   $0x1,%eax;"
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -1024,10 +1024,11 @@ asm(
 ".global __raw_callee_save___kvm_vcpu_is_preempted;"
 ".type __raw_callee_save___kvm_vcpu_is_preempted, @function;"
 "__raw_callee_save___kvm_vcpu_is_preempted:"
+ASM_ENDBR
 "movq	__per_cpu_offset(,%rdi,8), %rax;"
 "cmpb	$0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax);"
 "setne	%al;"
-"ret;"
+ASM_RET
 ".size __raw_callee_save___kvm_vcpu_is_preempted, .-__raw_callee_save___kvm_vcpu_is_preempted;"
 ".popsection");
 
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -41,6 +41,7 @@ extern void _paravirt_nop(void);
 asm (".pushsection .entry.text, \"ax\"\n"
      ".global _paravirt_nop\n"
      "_paravirt_nop:\n\t"
+     ASM_ENDBR
      ASM_RET
      ".size _paravirt_nop, . - _paravirt_nop\n\t"
      ".type _paravirt_nop, @function\n\t"
@@ -50,6 +51,7 @@ asm (".pushsection .entry.text, \"ax\"\n
 asm (".pushsection .entry.text, \"ax\"\n"
      ".global paravirt_ret0\n"
      "paravirt_ret0:\n\t"
+     ASM_ENDBR
      "xor %" _ASM_AX ", %" _ASM_AX ";\n\t"
      ASM_RET
      ".size paravirt_ret0, . - paravirt_ret0\n\t"


