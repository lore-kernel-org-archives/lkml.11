Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0676C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 21:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiCDVkq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 16:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiCDVko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:40:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9711FE565
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 13:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+It/rMNXjbIO9eivSq4MdRYjnhWglySliEF32xrALSQ=; b=L7gH6IMAsYIpuf/D9W9mgVxAqK
        oC3YkNNPg1SLm+6WBfdET5n0uI2fyP63SlaHqDho+OB8KP8SM8DmYUReIrQ1jmLACPuhxwjDxaHte
        9BLgGbKxf9jRgaOL0i/HFXwNpLd+vmtCANaqACeGGHvOSuzwl1x1OrFlvItSXUcpAS/syxELXeEou
        76vxeGNbWJYU9HnYTDdRFIOhmU0nLNYcx8b5wgdOISe50SPeq9HueHl33M5fKjsZIn/vjiswedH1V
        NnVDZVsw+zB8tRpb4YTUN8wtmQpwReSpAWBx7mnNg+rXCNtA+PbHsdC8y9lie7sCVe81cl/9Q2o70
        V7B/bTdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQFe7-00D3AU-R7; Fri, 04 Mar 2022 21:39:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3070A986ACA; Fri,  4 Mar 2022 22:39:30 +0100 (CET)
Date:   Fri, 4 Mar 2022 22:39:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 00/39] x86: Kernel IBT
Message-ID: <20220304213930.GS11184@worktop.programming.kicks-ass.net>
References: <20220303112321.422525803@infradead.org>
 <20220304190958.comlw5wt7zdgeakc@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304190958.comlw5wt7zdgeakc@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 11:09:58AM -0800, Josh Poimboeuf wrote:
> On Thu, Mar 03, 2022 at 12:23:21PM +0100, Peter Zijlstra wrote:
> > Hi, another week, another series.
> > 
> > Since last time:
> > 
> >  - fixed and tested kexec (redgecomb)
> >  - s/4*HAS_KERNEL_IBT/ENDBR_INSN_SIZE/ (jpoimboe)
> >  - re-arranged Xen patches to avoid churn (andyhpp)
> >  - folded IBT_SEAL Kconfig and objtool options (jpoimboe)
> >  - dropped direct call/jmp rewrite from objtool (jpoimboe)
> >  - dropped UD1 poison (jpoimboe)
> >  - fixed kprobe selftests (masami,naveen)
> >  - fixed ftrace selftests (rostedt)
> >  - simplified CET/INT3 selftests (jpoimboe)
> >  - boot time msg on IBT (kees)
> >  - objtool WARN_FUNC sym+off fallback (jpoimboe)
> >  - picked up tags for unchanged patches
> >  - probably more
> > 
> > Supposedly clang-14-rc2 will work on this series, I'll validate the moment the
> > Debian package gets updated.
> > 
> > Patches go on top of tip/master + arm64/for-next/linkage. Also available here:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
> 
> I'm getting some warnings with CONFIG_X86_KERNEL_IBT=n:
> 
>   arch/x86/entry/entry_64.o: warning: objtool: irq_entries_start()+0x7: unreachable instruction
>   arch/x86/kernel/ftrace_64.o: warning: objtool: return_to_handler()+0x2a: unreachable instruction

Blergh, those are INT3 instructions, the first is the LDT stub padding
while the second is that INT3 you asked about earlier.

I can mark then all using SLS style rules, but that then triggers:

arch/x86/kernel/reboot.o: warning: objtool: native_machine_emergency_restart()+0x8f: BUG: why am I validating an ignored function?

which does horrible things on purpose to tickle a tripple fault in order
to reboot the machine.

Perhaps we should ignore INT3 by default, just like NOP ?
