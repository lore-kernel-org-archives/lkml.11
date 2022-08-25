Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162A2C28D13
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 06:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbiHYGlp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 02:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiHYGlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:41:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5135552E54;
        Wed, 24 Aug 2022 23:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=suL/EYVy2FnBYbtDax1tUpPi5wWYo1uJguDKeceNIkI=; b=Do25rY1cPxB2i+yQK6ONRRBmBp
        NOdrCYrhyKVKzzBz5n1OM0mt7qMi8/bPt45EujAcTMtRlSwIjkd/G6Cb/CxUlmMrJPbbf5s6dKOMx
        W6Uk3Af3AjKdUMlz5wHT5R2JCsG4aD3EknEg1H02i4HdiEZnz+aV7gVJ5c+zEy0vlSMVQ9Qy9E+pN
        E3Ji9Srhs1zDVHN0+cWFuyzV+O7RL3twB0Tkopebu+Nl/La/HrVq/nUvpXpn8nbcBh+DFaVyvQwgf
        9KBF7xSj6zRXgxyDn9trsQ/OqVOYhJeNK5hFyrUSOM9oUSYd4IEqky63ntt01QGCrTjX1zPTj9EgO
        vVkj6oCQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oR6YM-00H216-Gr; Thu, 25 Aug 2022 06:41:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1ECD798012A; Thu, 25 Aug 2022 08:41:20 +0200 (CEST)
Date:   Thu, 25 Aug 2022 08:41:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Michael Matz <matz@suse.de>, linux-toolchains@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/sev: Mark snp_abort() noreturn
Message-ID: <YwcZjxVkO/lspvmv@worktop.programming.kicks-ass.net>
References: <20220824152420.20547-1-bp@alien8.de>
 <20220824172929.GA25951@gate.crashing.org>
 <YwaN2HtMyM0YEdSB@worktop.programming.kicks-ass.net>
 <20220824224144.GC25951@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824224144.GC25951@gate.crashing.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 05:41:44PM -0500, Segher Boessenkool wrote:

> It is!  A noreturn function (that doesn't warn like "warning: 'noreturn'
> function does return") does not have whatever your architecture uses for
> function returns in it.  Just like most non-noreturn functions that do
> not return btw: the attribute affects code generation of the *caller* of
> such functions.

Yeah, but objtool can't tell if the compiler just spazzed out and
stopped generating code or if it was intentional.

> > STT_FUNC_NORETURN would do I suppose, except then all
> > the tools will need to be taught how to deal with that, which is also
> > very painful.
> 
> What is that?  Even Google has no idea.  Hrm.

Something I just made up :-) A new symbol type for noreturn functions
would be very useful.

> What fundamental problem does objtool have in dealing with any normal
> compiled code itself?  Does it try to understand the semantics of the
> machine code (not very tractable), does it expect some magic markup to
> be generated together with the machine code, does it want to have
> compilers hamstrung wrt what kind of code they can generate?
> 
> There is some serious disconnect here, and I'm not even completely sure
> what it is :-(

Objtool follows control flow. As you said above, noreturn functions
behave differently and code-gen after a call to a noreturn function
stops.

Typically objtool expects a call instruction to return and continue on
the next instruction; if all of a sudden there's nothing there, it gets
suspicious and says the compiler messed up.

(FWIW, we've found a fair number of actual compiler bugs with this)

Now, as mentioned we have heuristics that try and detect if a function
is noreturn or not; but all those fail horribly if the function is in
another translation unit for example.
