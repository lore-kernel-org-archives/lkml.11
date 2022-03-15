Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF691C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 10:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiCOKrS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 06:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347347AbiCOKpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A1D387A3;
        Tue, 15 Mar 2022 03:44:05 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:44:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341043;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QjIqBA18d+6k68nF1JF3P0tCn6XSCRmHUgMmZ3p20Y4=;
        b=tN84Xxxhstz05GypjccyddASGrvt3zVXZfbwf+4JEqP4PMVHSCW8D96S9D0tn4bkdZeVSM
        WrO2mGGUASJbMYKBjjF4e0w0oRj4zq4pVuMEaC7gybuuz1VmpXJ25e7OWjqwNu/jBWLLmd
        +Nprr6kKTYC5FW6U8M4584m+izSUAoGgfWSSWkwZHI2ANGFlDr31sKYY/RTEAjdG34jjr3
        5cwpJ3xPoGG6RBd+4fiK+GVugsTZGgumVEn1PMvVkgvwBz+yKLbF7bM2LpSD7aJ3nV11dT
        1HRGUUNP2m3oJAVX5wGEF59ScppHIlrUtZMYesgluFFN/8zdhRdTGfu+GuxXSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341043;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QjIqBA18d+6k68nF1JF3P0tCn6XSCRmHUgMmZ3p20Y4=;
        b=di7+i8AFSsb4flUU3Tgz5oXpgoXnniWK/KeGmcZmMraqVj8UgKFrw7ySqKlxFy0aWqYHUQ
        PAx5HP6w5Z32iQDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/livepatch: Validate __fentry__ location
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154318.285971256@infradead.org>
References: <20220308154318.285971256@infradead.org>
MIME-Version: 1.0
Message-ID: <164734104253.16921.15291352375479075056.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     d15cb3dab1e4f00e29599a4f5e1f6678a530d270
Gitweb:        https://git.kernel.org/tip/d15cb3dab1e4f00e29599a4f5e1f6678a530d270
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:30 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:37 +01:00

x86/livepatch: Validate __fentry__ location

Currently livepatch assumes __fentry__ lives at func+0, which is most
likely untrue with IBT on. Instead make it use ftrace_location() by
default which both validates and finds the actual ip if there is any
in the same symbol.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.285971256@infradead.org
---
 arch/powerpc/include/asm/livepatch.h | 10 ----------
 kernel/livepatch/patch.c             | 19 ++-----------------
 2 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
index 4fe018c..7b9dcd5 100644
--- a/arch/powerpc/include/asm/livepatch.h
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -19,16 +19,6 @@ static inline void klp_arch_set_pc(struct ftrace_regs *fregs, unsigned long ip)
 	regs_set_return_ip(regs, ip);
 }
 
-#define klp_get_ftrace_location klp_get_ftrace_location
-static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
-{
-	/*
-	 * Live patch works only with -mprofile-kernel on PPC. In this case,
-	 * the ftrace location is always within the first 16 bytes.
-	 */
-	return ftrace_location_range(faddr, faddr + 16);
-}
-
 static inline void klp_init_thread_info(struct task_struct *p)
 {
 	/* + 1 to account for STACK_END_MAGIC */
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index fe316c0..c172bf9 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -124,19 +124,6 @@ unlock:
 	ftrace_test_recursion_unlock(bit);
 }
 
-/*
- * Convert a function address into the appropriate ftrace location.
- *
- * Usually this is just the address of the function, but on some architectures
- * it's more complicated so allow them to provide a custom behaviour.
- */
-#ifndef klp_get_ftrace_location
-static unsigned long klp_get_ftrace_location(unsigned long faddr)
-{
-	return faddr;
-}
-#endif
-
 static void klp_unpatch_func(struct klp_func *func)
 {
 	struct klp_ops *ops;
@@ -153,8 +140,7 @@ static void klp_unpatch_func(struct klp_func *func)
 	if (list_is_singular(&ops->func_stack)) {
 		unsigned long ftrace_loc;
 
-		ftrace_loc =
-			klp_get_ftrace_location((unsigned long)func->old_func);
+		ftrace_loc = ftrace_location((unsigned long)func->old_func);
 		if (WARN_ON(!ftrace_loc))
 			return;
 
@@ -186,8 +172,7 @@ static int klp_patch_func(struct klp_func *func)
 	if (!ops) {
 		unsigned long ftrace_loc;
 
-		ftrace_loc =
-			klp_get_ftrace_location((unsigned long)func->old_func);
+		ftrace_loc = ftrace_location((unsigned long)func->old_func);
 		if (!ftrace_loc) {
 			pr_err("failed to find location for function '%s'\n",
 				func->old_name);
