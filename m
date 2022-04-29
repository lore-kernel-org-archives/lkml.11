Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B372DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Apr 2022 09:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356451AbiD2JX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Apr 2022 05:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356449AbiD2JXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:23:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850D4B246E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=tQ7a+vtleF2s0tDZTOYHjc7mpLTWk12Jwh1yKoSf5Jk=; b=X8k+MRDv7VhHcRPiSegFGl1yA7
        aIhq8o0Fni20TROZVB2aRzkTAN5QthRtztnESqa17/QidoVhspIw+kem92suTgSQ4arVKuaEdvdOQ
        M4LGKEMXRYwCCmhZYGYlretXOntd+x+z0etIjk9DDYLIB+q3V8DtOYOdKdGcOEOPVSoqBS9qFwhvN
        3XEzpRHaGyUDhZ5FZoi/7EQKRI0e1a2TdRK+UtwLD9xqn4+1iL6ZqJ+udtttmV3sODbcBBog9W3s9
        PUBC6e8KwIAyrxPYp5MLuVkDgNhyB8ruhUbK0E+ojw8xIxDX88rVO7DcmUNEalN2YSI96Ul/Kd4R1
        bGk/HqaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkMnY-009ZU6-Nm; Fri, 29 Apr 2022 09:20:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A83198038F; Fri, 29 Apr 2022 11:20:24 +0200 (CEST)
Date:   Fri, 29 Apr 2022 11:20:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH] objtool: Fix STACK_FRAME_NON_STANDARD reloc type
Message-ID: <20220429092024.GT2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


STACK_FRAME_NON_STANDARD results in inconsistent relocation types
depending on .c or .S usage:

  Relocation section '.rela.discard.func_stack_frame_non_standard' at offset 0x3c01090 contains 5 entries:
  Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  0000000000000000  00020c2200000002 R_X86_64_PC32          0000000000047b40 do_suspend_lowlevel + 0
  0000000000000008  0002461e00000001 R_X86_64_64            00000000000480a0 machine_real_restart + 0
  0000000000000010  0000001400000001 R_X86_64_64            0000000000000000 .rodata + b3d4
  0000000000000018  0002444600000002 R_X86_64_PC32          00000000000678a0 __efi64_thunk + 0
  0000000000000020  0002659d00000001 R_X86_64_64            0000000000113160 __crash_kexec + 0

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/objtool.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -137,7 +137,11 @@ struct unwind_hint {
 
 .macro STACK_FRAME_NON_STANDARD func:req
 	.pushsection .discard.func_stack_frame_non_standard, "aw"
-		.long \func - .
+#ifdef CONFIG_64BIT
+		.quad \func
+#else
+		.long \func
+#endif
 	.popsection
 .endm
 

