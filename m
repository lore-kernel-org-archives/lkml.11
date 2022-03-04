Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D99C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 19:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiCDT7L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 14:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiCDT7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 14:59:06 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECAF269A43
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 11:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=no0VEInXnl23SVS24m7UlFq4G8qUDmTk6Ccbs3zl4O0=; b=m9q/ektnWd85Jw/Qd6H4P70IG4
        CJf+sOmXwSGuEqphk+S4yoarL//k1hmWAubjEcXmQI1IrVfxaM/Hm0JjOUr+aztLad+dOno1N79R1
        /vwPkKlasJz1ZAhouQ05wHfJWkQ3tuIJhqSYWCktaU5aOQZXevWk7E1J0yNsdmwR6dxWTIEY8Skwg
        RbxobHgOmLnyWLNN7meCUboCnv/Nh7k+7jQ0AEoN25d+48/9ensMwRzq/3h+TzQ2j5VE/IUXOO9Nk
        sRjzPLiPSsO4IN7gThomloitB3WQqcShb8V1zcSRk9ufai1o8sYVjULJfPwxZKxhHNXSLlshjkQe0
        CbEbpPXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQDv5-00FIPA-Fj; Fri, 04 Mar 2022 19:48:55 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6241398624E; Fri,  4 Mar 2022 20:48:53 +0100 (CET)
Date:   Fri, 4 Mar 2022 20:48:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 18/39] x86/ibt,ftrace: Make function-graph play nice
Message-ID: <20220304194853.GN11184@worktop.programming.kicks-ass.net>
References: <20220303112321.422525803@infradead.org>
 <20220303112826.044301664@infradead.org>
 <20220304175154.l2otvmqd4r7ozsuy@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304175154.l2otvmqd4r7ozsuy@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 09:51:54AM -0800, Josh Poimboeuf wrote:
> On Thu, Mar 03, 2022 at 12:23:39PM +0100, Peter Zijlstra wrote:
> > +
> > +	addq $16, %rsp
> > +	ANNOTATE_INTRA_FUNCTION_CALL
> > +	call .Ldo_rop
> > +	int3
> > +.Ldo_rop:
> > +	mov %rdi, (%rsp)
> > +	UNWIND_HINT_FUNC
> > +	RET
> 
> Why the int3?

Speculation trap :-) Either I'm too paranoid or not paranoid enough; but
without it it's just too close to a retpoline and it doesn't feel right.
