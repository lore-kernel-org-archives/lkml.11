Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ED3C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 15:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbiBXPTU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbiBXPS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:29 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D57F14D724
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pTgODVXwzVaBAVqPp5zYSq2XS+1FxzVybSLtoY0jHDo=; b=OLob+nwcQW/FV0hKLBZnKtfXIh
        owMi1UzQOl+D4qHE1+zlR4BJf6Dtpfi/U4E2PtLTzR2thsrYanSmUmTMATU22DATpcQ24AHkaYNqv
        9V4J2FeFeRIyskMNmjhG7nqFOW/Fm3s6uTjA7pAKECeOgq0Jt2cuowR6/Nsybzc1yT0RP48RbpdUE
        UnqDAwQ33JRo78eaRfSRXZPX2LmUM7nTeUIaGG/Tv9Aqns3RKwai+QbKjrRvyEjQW0qGWFR10u3vT
        XcqeBk755rQQa0KN4jVI5Iudtma7/FjrwC7s0tQRvau9T1yKCxPCf3jVpWc976J3EalgOKi42V8pY
        rliUlyrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs3-00CeLz-T9; Thu, 24 Feb 2022 15:17:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48467302AD4;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 87B732B35479B; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151323.541791174@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:52:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: [PATCH v2 26/39] x86/entry: Cleanup PARAVIRT
References: <20220224145138.952963315@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 5c8f6a2e316e ("x86/xen: Add
xenpv_restore_regs_and_return_to_usermode()") Xen will no longer reach
this code and we can do away with the paravirt
SWAPGS/INTERRUPT_RETURN.

Suggested-by: Andrew Cooper <Andrew.Cooper3@citrix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -619,8 +619,8 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_
 
 	/* Restore RDI. */
 	popq	%rdi
-	SWAPGS
-	INTERRUPT_RETURN
+	swapgs
+	jmp	native_iret
 
 
 SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)


