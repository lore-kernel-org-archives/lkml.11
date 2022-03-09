Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1EBC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 07:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiCIH46 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 02:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiCIH4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1BA163D46;
        Tue,  8 Mar 2022 23:54:58 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:54:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812497;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PTP5lTxohWCmXELMqIblhLjNgPpl892lJBS/KOMP3YE=;
        b=qsELHZ61d6g2ymVoJ44x865c1BVRLDdgo/aUxrmHWFFR9ogVTPHFLcLNoPg5ljG3L+hmNe
        DYwNCprq0goJHdc2pZVW9ecFbEI/BM698nEHPkCcQ7HMDILDvv8XkSLkb06YNmZYmBARZS
        LEbwvM7KE87FSqMDq+nBXAxM0GVso/HUP+WcGcAF9JFlve69xqDxzH/2obDzmJEZJis+eJ
        jnMyZ9QJYVEEZ0JHuQ2v6KSq4SK5MI+uhzoW4wZ8/u/MPhoKy3ZQbN5N6cWdt/Q9FlybSi
        CkQW+9Q0wGJKUuRjvNrO8Prcc4fcrO4hBeLUTQFctRkauZLEy3WWpkrV4S+c1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812497;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PTP5lTxohWCmXELMqIblhLjNgPpl892lJBS/KOMP3YE=;
        b=wO0C9eksDg5Zv6m4h1/ewrZe5JeC9nvGx8bPSuFsxfju0UkcKkU3ALPGNN3F/0Mua+45T8
        sTg4iueNqTZERJAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/alternative: Simplify int3_selftest_ip
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154318.700456643@infradead.org>
References: <20220308154318.700456643@infradead.org>
MIME-Version: 1.0
Message-ID: <164681249645.16921.5745445367445064904.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     8cdcaee61f7fe2d35ad8c3b3295ac7bd30244c7f
Gitweb:        https://git.kernel.org/tip/8cdcaee61f7fe2d35ad8c3b3295ac7bd30244c7f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:37 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:34 +01:00

x86/alternative: Simplify int3_selftest_ip

Similar to ibt_selftest_ip, apply the same pattern.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.700456643@infradead.org
---
 arch/x86/kernel/alternative.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5007c3f..de56b5c 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -719,7 +719,7 @@ asm (
 "	.popsection\n"
 );
 
-extern __initdata unsigned long int3_selftest_ip; /* defined in asm below */
+extern void int3_selftest_ip(void); /* defined in asm below */
 
 static int __init
 int3_exception_notify(struct notifier_block *self, unsigned long val, void *data)
@@ -733,7 +733,7 @@ int3_exception_notify(struct notifier_block *self, unsigned long val, void *data
 	if (val != DIE_INT3)
 		return NOTIFY_DONE;
 
-	if (regs->ip - INT3_INSN_SIZE != int3_selftest_ip)
+	if (regs->ip - INT3_INSN_SIZE != (unsigned long)&int3_selftest_ip)
 		return NOTIFY_DONE;
 
 	int3_emulate_call(regs, (unsigned long)&int3_magic);
@@ -757,14 +757,7 @@ static void __init int3_selftest(void)
 	 * then trigger the INT3, padded with NOPs to match a CALL instruction
 	 * length.
 	 */
-	asm volatile ("1: int3; nop; nop; nop; nop\n\t"
-		      ".pushsection .init.data,\"aw\"\n\t"
-		      ".align " __ASM_SEL(4, 8) "\n\t"
-		      ".type int3_selftest_ip, @object\n\t"
-		      ".size int3_selftest_ip, " __ASM_SEL(4, 8) "\n\t"
-		      "int3_selftest_ip:\n\t"
-		      __ASM_SEL(.long, .quad) " 1b\n\t"
-		      ".popsection\n\t"
+	asm volatile ("int3_selftest_ip: int3; nop; nop; nop; nop\n\t"
 		      : ASM_CALL_CONSTRAINT
 		      : __ASM_SEL_RAW(a, D) (&val)
 		      : "memory");
