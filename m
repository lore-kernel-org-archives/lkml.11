Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADF9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 10:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbiBYKwB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 05:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiBYKvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:51:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB0A23930C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yZGqTyAZd53iFHPQKMpQ/OxnAtNYhi/jhLEffl9QJ4Y=; b=p1Ce44iHctaEj9J3qs+ERGOslC
        L+x+qf+xDUSkAm3GfH8A/Os6FvCU6i75eOpNNR7eM3zZ1+mxNvxJQ84Eb6t74OoWjjVs/fLE/weXh
        y6gq6XZnDm1OWQi2S4cVYGT+2aIaNo0cU5wuokQYSkBs6SkCJfm14WrTQPE3Xuqq2k4zYmE/rNQvJ
        fOYL7wCYyYycpEFKpbY9huQGLszcKgp6KEK4d6Y7MVB1BKT+zZlMCn4LLMJLZCwQham3UjwRlqOy8
        QZRFyBkTqR/NeKDvgh8q3l0kdXt6hF9hBfircj1G3XtNs4KnASjwj0xO2QILWQlUKDnqCj/8p9ICB
        O7jRb7yw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNYBh-005iBh-VD; Fri, 25 Feb 2022 10:51:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E3BF300472;
        Fri, 25 Feb 2022 11:51:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 74D372CE691EB; Fri, 25 Feb 2022 11:51:01 +0100 (CET)
Date:   Fri, 25 Feb 2022 11:51:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 18/39] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <Yhi0lY8w3E5VKquU@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.069205370@infradead.org>
 <20220224235516.qdikcfdl7jo35iu6@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224235516.qdikcfdl7jo35iu6@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:55:16PM -0800, Josh Poimboeuf wrote:
> On Thu, Feb 24, 2022 at 03:51:56PM +0100, Peter Zijlstra wrote:
> > +static __always_inline void setup_cet(struct cpuinfo_x86 *c)
> > +{
> > +	u64 msr = CET_ENDBR_EN;
> > +
> > +	if (!HAS_KERNEL_IBT ||
> > +	    !cpu_feature_enabled(X86_FEATURE_IBT))
> > +		return;
> 
> If you add X86_FEATURE_BIT to arch/x86/include/asm/disabled-features.h,
> the HAS_KERNEL_IBT check becomes redundant.

Cute.

> > +bool ibt_selftest(void)
> > +{
> > +	unsigned long ret;
> > +
> > +	asm ("1: lea 2f(%%rip), %%rax\n\t"
> > +	     ANNOTATE_RETPOLINE_SAFE
> > +	     "   jmp *%%rax\n\t"
> > +	     ASM_REACHABLE
> > +	     ANNOTATE_NOENDBR
> > +	     "2: nop\n\t"
> > +
> > +	     /* unsigned ibt_selftest_ip = 2b */
> > +	     ".pushsection .rodata,\"a\"\n\t"
> > +	     ".align 8\n\t"
> > +	     ".type ibt_selftest_ip, @object\n\t"
> > +	     ".size ibt_selftest_ip, 8\n\t"
> > +	     "ibt_selftest_ip:\n\t"
> > +	     ".quad 2b\n\t"
> > +	     ".popsection\n\t"
> 
> It's still seems silly to make this variable in asm.
> 
> Also .rodata isn't going to work for CPU hotplug.

It's just the IP, that stays invariant. I'm not sure how else to match
regs->ip to 2 in #CP.
