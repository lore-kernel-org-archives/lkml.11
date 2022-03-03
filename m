Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75254C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 11:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiCCLbW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 06:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiCCLbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F111183013
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pTgODVXwzVaBAVqPp5zYSq2XS+1FxzVybSLtoY0jHDo=; b=J5w2DMq6HF5GherucgOYDaDDWU
        +1wEA7XWivIjDU0ArRsMuYkrem6wv8Gq0eksfhb05RFwfsRyk7duQsRNAIPjnV4WG1q3hE/TSV8M1
        G/Auj5UgMI9klox//oNQ4IqKijxaaqQCyOVNeFmMZTbfUAGrUEaOeF4OLR4SW15775zuT0agkAKnL
        zvqQrUWMne0qfY0BuWKI9+7mbyJSMTxGgkMhmD8yR/O1xjQ+CMpCI1WRvEJGocnrR/bi1Ercbeyba
        gzFvIju9c9G+2vGsHYNgzVZTKLGCRH50cVD8tKW3YFYT7HNPPzH5qaRNao+3e9s1zwWDcMf7aUtM7
        +g8F4hvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjeg-00EtpU-D6; Thu, 03 Mar 2022 11:29:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DDD7B300C26;
        Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3258230019E62; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112825.435931161@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: [PATCH v3 08/39] x86/entry: Cleanup PARAVIRT
References: <20220303112321.422525803@infradead.org>
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


