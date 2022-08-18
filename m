Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9640BC32772
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Aug 2022 16:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344240AbiHRQOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 12:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbiHRQON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:14:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B8147BBA
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CCADB8221C
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C553C433C1;
        Thu, 18 Aug 2022 16:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660839250;
        bh=7q/WN5I1Z0IaU6xaTUCpYoDjYa2773Zrh8H7eHNY+7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nllylCRK/qNurG8PvM007baAU/nZfmxuCCjdMwcoghZLIjUbQFYF+U2JG+GLa8JyF
         lxmRv7rTZ8VZgJN16/p9dbf4XbFxABj9XwY0Y6G9jVj1lgaiPT7H8GbE0GJh1uOKbx
         oUNzdr86tkthx5bVhNstAOhtRddn6ssL3PeqIhRarn7/o6SOF9V5W40UNee9AuG+ZE
         hrBWDRhWs1W+oCeafEZkIjhge3mG32ZBUp+z6fUiuWLGp+1+c6G3r5ClLZ7fBwtszH
         JDEObp73q21pKLfLhnLuvNkR288ayjPTosSWUJPOYKVV7YkWOS0ktADnzebS8KR8Mo
         +UuwCDWqFFShg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Pengfei Xu <pengfei.xu@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Su, Heng" <heng.su@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/3] x86/kvm: Simplify FOP_SETCC()
Date:   Thu, 18 Aug 2022 08:53:42 -0700
Message-Id: <7c13d94d1a775156f7e36eed30509b274a229140.1660837839.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1660837839.git.jpoimboe@kernel.org>
References: <cover.1660837839.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SETCC_ALIGN and FOP_ALIGN are both 16.  Remove the special casing for
FOP_SETCC() and just make it a normal fastop.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kvm/emulate.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index b4eeb7c75dfa..205d566ebd72 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -446,27 +446,12 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 	FOP_END
 
 /* Special case for SETcc - 1 instruction per cc */
-
-/*
- * Depending on .config the SETcc functions look like:
- *
- * ENDBR			[4 bytes; CONFIG_X86_KERNEL_IBT]
- * SETcc %al			[3 bytes]
- * RET | JMP __x86_return_thunk	[1,5 bytes; CONFIG_RETHUNK]
- * INT3				[1 byte; CONFIG_SLS]
- */
-#define SETCC_ALIGN	16
-
 #define FOP_SETCC(op) \
-	".align " __stringify(SETCC_ALIGN) " \n\t" \
-	".type " #op ", @function \n\t" \
-	#op ": \n\t" \
-	ASM_ENDBR \
+	FOP_FUNC(op) \
 	#op " %al \n\t" \
-	__FOP_RET(#op) \
-	".skip " __stringify(SETCC_ALIGN) " - (.-" #op "), 0xcc \n\t"
+	FOP_RET(op)
 
-__FOP_START(setcc, SETCC_ALIGN)
+FOP_START(setcc)
 FOP_SETCC(seto)
 FOP_SETCC(setno)
 FOP_SETCC(setc)
@@ -1079,7 +1064,7 @@ static int em_bsr_c(struct x86_emulate_ctxt *ctxt)
 static __always_inline u8 test_cc(unsigned int condition, unsigned long flags)
 {
 	u8 rc;
-	void (*fop)(void) = (void *)em_setcc + SETCC_ALIGN * (condition & 0xf);
+	void (*fop)(void) = (void *)em_setcc + FASTOP_SIZE * (condition & 0xf);
 
 	flags = (flags & EFLAGS_MASK) | X86_EFLAGS_IF;
 	asm("push %[flags]; popf; " CALL_NOSPEC
-- 
2.37.2

