Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6127C35278
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 15:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348904AbiCHP6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 10:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348089AbiCHP4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:12 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9924F9ED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=xB4u1Jy3hvc7M0RTBy37w5M/ndZ42JCBNtJfPEBqWsQ=; b=aL/B38vbfWu7GiedbiebWJsfv8
        w6nSMy20A6rtw5NYZZFvUBOrT8Jv7qruUb/JY/lRUE+Gtv87RI5ZRA6FwpqTzXIQvfZHtpxvQASt4
        D1BbEdDOBSQgomLUCSF5qHeH1RthLOMITWN9INCObmTYCSgJ1SujTqGC0Nv95WlB2/iK4DBXQhYKj
        61BE84xlceBwPOaxKul5DOsBqqQc95R63DxP/ylnHQiKgZMq1emEoKByaLAdsZiSTn46srZL10B1b
        SnKzDNBGao3oC8n+/ayJYkltlnZXhZDTeXgdCT6tIrg1qvEdXuwhN2QE7qxmOkv9bUm8V+I3G0PPM
        T2EdA1Zg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAc-00GUid-SP; Tue, 08 Mar 2022 15:54:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4696E302D8A;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 90D5F2B56193C; Tue,  8 Mar 2022 16:54:39 +0100 (CET)
Message-ID: <20220308154318.936599479@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 30/45] x86/ibt,ftrace: Annotate ftrace code patching
References: <20220308153011.021123062@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are code patching sites, not indirect targets.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/ftrace_64.S |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -145,6 +145,7 @@ SYM_FUNC_START(ftrace_caller)
 	movq %rcx, RSP(%rsp)
 
 SYM_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	/* Load the ftrace_ops into the 3rd parameter */
 	movq function_trace_op(%rip), %rdx
 
@@ -155,6 +156,7 @@ SYM_INNER_LABEL(ftrace_caller_op_ptr, SY
 	movq $0, CS(%rsp)
 
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	call ftrace_stub
 
 	/* Handlers can change the RIP */
@@ -169,6 +171,7 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBA
 	 * layout here.
 	 */
 SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 
 	jmp ftrace_epilogue
 SYM_FUNC_END(ftrace_caller);
@@ -192,6 +195,7 @@ SYM_FUNC_START(ftrace_regs_caller)
 	/* save_mcount_regs fills in first two parameters */
 
 SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	/* Load the ftrace_ops into the 3rd parameter */
 	movq function_trace_op(%rip), %rdx
 
@@ -221,6 +225,7 @@ SYM_INNER_LABEL(ftrace_regs_caller_op_pt
 	leaq (%rsp), %rcx
 
 SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	call ftrace_stub
 
 	/* Copy flags back to SS, to restore them */
@@ -248,6 +253,7 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_
 	 */
 	testq	%rax, %rax
 SYM_INNER_LABEL(ftrace_regs_caller_jmp, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	jnz	1f
 
 	restore_mcount_regs
@@ -261,6 +267,7 @@ SYM_INNER_LABEL(ftrace_regs_caller_jmp,
 	 * to the return.
 	 */
 SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	jmp ftrace_epilogue
 
 	/* Swap the flags with orig_rax */


