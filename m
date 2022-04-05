Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C59C4707A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 08:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbiDEIho (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 04:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbiDEH7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:59:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3D840A14
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 00:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=v0lvCJ1nOTjsWpQFBErf0tqfOG0A5lcVLb6Qg+sSzpw=; b=uDrnUQwKSZFbIlBPBLGif1YYuh
        xI8QFY8k5HSb8rAJBirSb6+4PbVdsnnyfUBEsUg+qMuSC3j+z5tP8QVEs3yEASlqQR1gtGSLUZkmw
        3IPLSUofE/GhmD1ZAqDHunqWMDP5AzKiqO/lj0iQLR52oLOUlEtpUcbNz3A3r1HCNqa56iLC62K0c
        2B/XlGafViOp0d9Kq9JQDJnCD04/3LMDm/4RHn7bFXr6RgLsaO48EzKE2ElDPRbnjXa3oDztEdZ96
        ov7dodKqoVqNjU/U9ZxHyqzupw6+zEgpW59qKdZk7SUJUaVIb9luBrAG4bjyP/Jh1rTvcNx+ybK4F
        j5+fytiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbe2G-006Tew-7z; Tue, 05 Apr 2022 07:55:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9ADC2986B5B; Tue,  5 Apr 2022 09:55:31 +0200 (CEST)
Date:   Tue, 5 Apr 2022 09:55:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, alexei.starovoitov@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86,bpf: Avoid IBT objtool warning
Message-ID: <20220405075531.GB30877@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Clang can inline emit_indirect_jump() and then folds constants, which
results in:

  | vmlinux.o: warning: objtool: emit_bpf_dispatcher()+0x6a4: relocation to !ENDBR: .text.__x86.indirect_thunk+0x40
  | vmlinux.o: warning: objtool: emit_bpf_dispatcher()+0x67d: relocation to !ENDBR: .text.__x86.indirect_thunk+0x40
  | vmlinux.o: warning: objtool: emit_bpf_tail_call_indirect()+0x386: relocation to !ENDBR: .text.__x86.indirect_thunk+0x20
  | vmlinux.o: warning: objtool: emit_bpf_tail_call_indirect()+0x35d: relocation to !ENDBR: .text.__x86.indirect_thunk+0x20

Suppress the optimization such that it must emit a code reference to
the __x86_indirect_thunk_array[] base.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/net/bpf_jit_comp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -412,6 +412,7 @@ static void emit_indirect_jump(u8 **ppro
 		EMIT_LFENCE();
 		EMIT2(0xFF, 0xE0 + reg);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
+		OPTIMIZER_HIDE_VAR(reg);
 		emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
 	} else
 #endif

