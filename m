Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61134C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 09:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiB1JtI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbiB1JtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:49:05 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107431FCE6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TbX1elLNmY9m7mw4xyCAvKkgqBgBFXZB2/ysXnb7O3Y=; b=FZHEuiQVOkidq7h7dG+KG7FAA9
        9lVBkYHwxz/HV5UzT7gyYVS/klWo24u5lNs9Iel+z8JMwxt9ceillsUSZjDxCpQIF1H/2gd6ROonT
        KN0dqCymqq+xFJpyKrGLFK1uP3BsZJBLYCX3mtbdS+A5VoZ3IWO4zTrqXBPWWL1MzrgeAMKN7ycgu
        8XHAwP/ahwCL/rYA4jcJYNGB6SRXrK7kNUA9PJtc+IVg4rUCiisWDuehbOqMw0QUnr8ZPCPQEpJZu
        jUNFFsWfT3Tlm93hoIOUpCcZRr2/iEPRhmLKAs3wllU6nMpkHJykPYq3l9rrFgf5Bf91uQBS5h3yL
        jbk5fvjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOcdK-00Dqnz-79; Mon, 28 Feb 2022 09:47:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 11C673001EA;
        Mon, 28 Feb 2022 10:47:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E74D223944342; Mon, 28 Feb 2022 10:47:55 +0100 (CET)
Date:   Mon, 28 Feb 2022 10:47:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 34/39] objtool: Validate IBT assumptions
Message-ID: <YhyaS4tN9NpCJcmk@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151324.018939604@infradead.org>
 <20220227031348.drbmkcmoqur53aay@treble>
 <20220227170003.GE11184@worktop.programming.kicks-ass.net>
 <20220227222055.uqgcz33dwhl3atpr@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227222055.uqgcz33dwhl3atpr@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 02:20:55PM -0800, Josh Poimboeuf wrote:
> On Sun, Feb 27, 2022 at 06:00:03PM +0100, Peter Zijlstra wrote:
> > > > @@ -3101,6 +3164,17 @@ static int validate_branch(struct objtoo
> > > >  
> > > >  		if (insn->hint) {
> > > >  			state.cfi = *insn->cfi;
> > > > +			if (ibt) {
> > > > +				struct symbol *sym;
> > > > +
> > > > +				if (insn->cfi->type == UNWIND_HINT_TYPE_REGS_PARTIAL &&
> > > > +				    (sym = find_symbol_by_offset(insn->sec, insn->offset)) &&
> > > > +				    insn->type != INSN_ENDBR && !insn->noendbr) {
> > > > +					WARN_FUNC("IRET_REGS hint without ENDBR: %s",
> > > > +						  insn->sec, insn->offset,
> > > > +						  sym->name);
> > > > +				}
> > > 
> > > No need to print sym->name here, WARN_FUNC() already does it?
> > 
> > Almost; perhaps the change to make is to either introduce WARN_SYM or
> > make WARN_FUNC also print !STT_FUNC symbols ?
> 
> In the case of no function, WARN_FUNC() falls back to printing sec+off.
> Is that not good enough?

I got really tired of doing the manual symbol lookup... I don't suppose
it matters too much now that I've more or less completed the triage, but
it was useful.
