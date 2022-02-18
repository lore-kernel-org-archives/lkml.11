Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76711C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 17:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbiBRRRP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 12:17:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238224AbiBRRPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DFC4C406
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=jDOYWFr4jWW3kiIBEISVtsrcxFZNGSxMZIOUSK4rpWE=; b=OYuXbmZ4bh3+cQyuCsM8TsFmwU
        ZYOseE5TvCuzslN51pbyePrQ5AhefHt/D3bggMQGWa/pyeTHSP9WjNemYBFfU76VnR5wJYlWI2FLS
        oOGxkhgq0HL6cGF1XZuRo2XrQLv1ow6Sd7y/cKafDCOov2TBfQtFHzCcBoA61xLVSZSO8zB+naKKI
        21hEg4HvqPl02XCdljVCR7cr3TMp1cll6002GM4WYUpQ8lo1xs8kcI1GON3a3SQfzxIycQ98lCek6
        K3cPvME5vAGNXclT98/G0+nrX3EvdNAvxUCWUW8gYe3A5bJnykRu7zCszgi5/yDhGRvV0ssAjM1tF
        UmCYCYEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6qA-00Gl8j-HC; Fri, 18 Feb 2022 17:14:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CF63C301A5B;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 57A9229B3BE0E; Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Message-ID: <20220218171409.755600076@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 20/29] x86/ibt,sev: Annotations
References: <20220218164902.008644515@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No IBT on AMD so far.. probably correct, who knows.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S        |    1 +
 arch/x86/entry/entry_64_compat.S |    1 +
 arch/x86/kernel/head_64.S        |    1 +
 3 files changed, 3 insertions(+)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -96,6 +96,7 @@ SYM_CODE_START(entry_SYSCALL_64)
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 SYM_INNER_LABEL(entry_SYSCALL_64_safe_stack, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 
 	/* Construct struct pt_regs on stack */
 	pushq	$__USER_DS				/* pt_regs->ss */
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -214,6 +214,7 @@ SYM_CODE_START(entry_SYSCALL_compat)
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 
 	/* Construct struct pt_regs on stack */
 	pushq	$__USER32_DS		/* pt_regs->ss */
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -440,6 +440,7 @@ SYM_CODE_END(early_idt_handler_common)
  */
 SYM_CODE_START_NOALIGN(vc_no_ghcb)
 	UNWIND_HINT_IRET_REGS offset=8
+	ENDBR
 
 	/* Build pt_regs */
 	PUSH_AND_CLEAR_REGS


