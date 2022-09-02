Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE31ECAAD5
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 17:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbiIBREM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 13:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiIBREJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:04:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D77E39A6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fkYUhUmO0S6kugiT2LYg3f4F80JAO7Aqk3FfxeycZyQ=; b=RzAY0ghN61ZZD0c8eB30uj84hN
        qVcUB7UYAlN8LNn4TaKxa3nt6eqc+NAgtE0rG2fIL73ziPN4OgNMqTZekcpyBpxIqv3KgRKgSBcGE
        kRyK087cbDkvCx1UxwKjpt6PGUCzRA1BAzZiRURz+Q5L4vK0m/ST0hpjXXwmznifxHioeK4S6NJt/
        sKi3WfcqpPGolK6AX4onCc4GLsmQV+iEFh1hdB6/GJlO/Rqj6F44mX2MICIPbIJpxvoLkycWcdeFk
        vGIwCT35fApWpVt6aIFNL5fleP2cc3CuIts1tL3JLMowMbdbzzqigdKd8uUpmeqYC3SYXxOeiwnbF
        nYxqB1AA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oUA4v-007Bhf-32; Fri, 02 Sep 2022 17:03:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0B8D3002A3;
        Fri,  2 Sep 2022 19:03:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DEA002022A4CD; Fri,  2 Sep 2022 19:03:33 +0200 (CEST)
Date:   Fri, 2 Sep 2022 19:03:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 37/59] x86/putuser: Provide room for padding
Message-ID: <YxI3Zf5drSHAkBL3@hirez.programming.kicks-ass.net>
References: <20220902130625.217071627@infradead.org>
 <20220902130950.205726504@infradead.org>
 <CAHk-=wig7_=CpkvZXrbcM97pBGk5MCbVkA0yBGP2moiho-XS_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wig7_=CpkvZXrbcM97pBGk5MCbVkA0yBGP2moiho-XS_Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 09:43:45AM -0700, Linus Torvalds wrote:
> So I don't hate this patch and it's probably good for consistency, but
> I really think that the retbleed tracking could perhaps be improved to
> let this be all unnecessary.
> 
> The whole return stack depth counting is already not 100% exact, and I
> think we could just make the rule be that we don't track leaf
> functions.
> 
> Why? It's just a off-by-one in the already not exact tracking. And -
> perhaps equally importantly - leaf functions are very very common
> dynamically, and I suspect it's trivial to see them.
> 
> Yes, yes, you could make objtool even smarter and actually do some
> kind of function flow graph thing (and I think some people were
> talking about that with the whole ret counting long long ago), but the
> leaf function thing is the really simple low-hanging fruit case of
> that.

So I did the leaf thing a few weeks ago, and at the time the perf gains
where not worth the complexity.

I can try again :-)
