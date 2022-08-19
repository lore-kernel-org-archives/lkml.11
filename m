Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59FAC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 15:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349329AbiHSPEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 11:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348481AbiHSPEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:04:36 -0400
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBD013F0A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:04:33 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 08529B002B2; Fri, 19 Aug 2022 17:04:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1660921471; bh=5DyeToWHhZNBwOW6jru0T77NoIDQPfqjDLXEgwCrlq4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ADwEwQqctMcgBjkKLmPlBONjSN8AspuVzdEciBmIirDuQJh68oLi3S8gY5qaQhxKL
         0s5rToJVV4iBB1xstm+l8qDyxlmRpOpZ4axRc3J+0sGglqqZnEGcsaWiSb1ewDe6Wt
         oOXA5EvL9rxDPB6DqtjhHaMwcP0WxhiV3pBOB3oJu2st/FVqr6Lee50LW3F4d/IRe5
         LqmCEZdEkdHKeDHo9JHZxJYdVExPC+nqPOA6Ix6a6OHNuD3ucp1i/Sjk64LedHsai+
         yYy9uo4YYwPgLN85U4NSH2wPFnyqDcbMRzWRfpJkTfb2ix9x0rWNlRTyR83Q4gS8Rj
         yYYTG1xanwPpQ==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 0681AB00241;
        Fri, 19 Aug 2022 17:04:31 +0200 (CEST)
Date:   Fri, 19 Aug 2022 17:04:31 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 1/9] slub: Make PREEMPT_RT support less convoluted
In-Reply-To: <5679405a-b3c3-6dc5-783f-7ebeda7c9bf0@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2208191655540.2139415@gentwo.de>
References: <20220817162703.728679-1-bigeasy@linutronix.de> <20220817162703.728679-2-bigeasy@linutronix.de> <alpine.DEB.2.22.394.2208181136560.1901102@gentwo.de> <5679405a-b3c3-6dc5-783f-7ebeda7c9bf0@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022, Vlastimil Babka wrote:

> On 8/18/22 11:42, Christoph Lameter wrote:
> > On Wed, 17 Aug 2022, Sebastian Andrzej Siewior wrote:
> >
> >> + *   On PREEMPT_RT, the local lock neither disables interrupts nor preemption
> >> + *   which means the lockless fastpath cannot be used as it might interfere with
> >> + *   an in-progress slow path operations. In this case the local lock is always
> >> + *   taken but it still utilizes the freelist for the common operations.
> >
> > The slub fastpath does not interfere with slow path operations and the
>
> That's true on !PREEMPT_RT because a slowpath operation under
> local_lock_irqsave() will disable interrupts, so there can't be a
> fastpath operation in an interrupt handler appearing in the middle of a
> slowpath operation.
>
> On PREEMPT_RT local_lock_irqsave() doesn't actually disable interrupts,
> so that can happen. IIRC we learned that the hard way when Mike
> Galbraith was testing early versions of my PREEMPT_RT changes for SLUB.

Well yes if you enable interrupts during the slowpath then interrupts may
use the fastpath. That is a basic design change to the way concurrency is
handled in the allocators.

There needs to be some fix here to restore the exclusion of the fastpath
during slow path processing. This could be

A) Exclude the fastpath during slowpath operations

This can be accomplished by setting things up like in the debug mode
that also excludes the fastpath.

or

B) Force interrupt allocations to the slowpath.

Check some flag that indicates an interrupt allocation is occurring and
then bypass the fastpath.

