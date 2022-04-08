Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E016AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 09:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiDHJuM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 05:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiDHJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:50:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBE3DF2E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=UtA65oX850xs99+DJXK3qDx9TAaR2oCoGquP+j8c1RE=; b=hG0r72tjzA2GqqnKmkPl1nVnNY
        9cg/Uh8HENWEiyXsV7uMUPVC3VJ/4neUb6/dMzhsBc0zCvE/Tzov1+GlRHzwSnMG8y9ZdmhT4BxJf
        /Ycf+VbbIdo+cOe6YCa4kWzKKMtJD4FoVDEANfeNTDtofdk9e9gwgEdTMYMS7Flkyc2mM+7qxjgor
        sgdzHiCYS4DWMYwDl3oEMf9hofX0cmnQsnLtnrLeKDrV5exUGZ+lwsI1kbT0AVF68fKvNzhC45qUX
        06CUNjoNI7lf23TmMTUBabYrAvRTP2pSBLXLXCu2AeAb/72KEe5mB9UxmZRcn0UDc0N5Cen0+JVub
        vcvoXvUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nclDW-002rgT-75; Fri, 08 Apr 2022 09:47:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 05FB7300130;
        Fri,  8 Apr 2022 11:47:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BD35B2B38B6CF; Fri,  8 Apr 2022 11:47:43 +0200 (CEST)
Message-ID: <20220408094718.441854969@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Apr 2022 11:45:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        rick.p.edgecombe@intel.com, jpoimboe@redhat.com
Subject: [PATCH 4/4] x86,objtool: Explicitly mark idtentry_body()s tail REACHABLE
References: <20220408094552.432447640@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objtool can figure out that some \cfunc()s are noreturn and then
complains about certain instances having unreachable tails:

  vmlinux.o: warning: objtool: asm_exc_xen_unknown_trap()+0x16: unreachable instruction

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -337,6 +337,9 @@ SYM_CODE_END(ret_from_fork)
 
 	call	\cfunc
 
+	/* For some configurations \cfunc ends up being a noreturn. */
+	REACHABLE
+
 	jmp	error_return
 .endm
 


