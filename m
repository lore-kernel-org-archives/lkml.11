Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B3AC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 08:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiCVIKc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 04:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiCVIK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:10:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F705F79;
        Tue, 22 Mar 2022 01:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tV3Hw9vtZCnQEQCQdNjrkRP1CxfsD225kd33zAEemCY=; b=NN4NWGOtuSuulLNlSx2y4shPZd
        sDQdJY7eyxa7gyy0h0P2XofYSyAk/maBV8LmE69J4XXFwZ5DvMBrD5Wyk3onbytDbUM2HJVNJezVU
        a6JDP8inzbfQx3rntZump6glxWskwKWsCv3eTI+wqTLF7QVWzajIs1qotkUu8M5PrVPIWf893oKZQ
        iom2w+1/KInxupCSH1oS+eEes05e1LcLbTr4MxyrFSQ/mYjXiRyRu3IXLFa66vYmE15CJ33B87zk6
        JbU5m1A4vyjO3csv+I9LOhztMmT/GRbdHdVQV0ER04LCcGk2HfFcxAfSlvqyb3/TGghUgFR2kqZxV
        kbZ6lExw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWZZ3-003PDO-0v; Tue, 22 Mar 2022 08:08:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFF163002E5;
        Tue, 22 Mar 2022 09:08:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A8ACD2C6B2DD9; Tue, 22 Mar 2022 09:08:22 +0100 (CET)
Date:   Tue, 22 Mar 2022 09:08:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        rostedt@goodmis.org, ast@kernel.org, hjl.tools@gmail.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        linux-toolchains@vger.kernel.org, Andrew.Cooper3@citrix.com,
        ndesaulniers@google.com
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <YjmD9ks5OAiZkjoL@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
 <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
 <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
 <YjisdqdofbDIYj2U@hirez.programming.kicks-ass.net>
 <20220322143136.0e78366c3521b54b7b9385b8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322143136.0e78366c3521b54b7b9385b8@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 02:31:36PM +0900, Masami Hiramatsu wrote:

> > Also, I think both should fix regs->ss.
> 
> I'm not sure this part. Since the return trampoline should run in the same
> context of the called function, isn't ss same there too?

It creates pt_regs on the stack, so the trampolines do:

	push $arch_rethook_trampoline
	push %rsp
	pushf
	sub $24, %rsp /* cs, ip, orig_ax */
	push %rdi
	...
	push %r15

That means that if anybody looks at regs->ss, it'll find
$arch_rethook_trampoline, which isn't a valid segment descriptor, or am
I just really bad at counting today?

I'm thinking you want a copy of __KERNEL_DS in that stack slot, not a
function pointer.
