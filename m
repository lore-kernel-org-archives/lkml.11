Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08E7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 13:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbiCVNYb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 09:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbiCVNY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:24:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055A13B2A3;
        Tue, 22 Mar 2022 06:22:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B09E61571;
        Tue, 22 Mar 2022 13:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D396FC340EE;
        Tue, 22 Mar 2022 13:22:56 +0000 (UTC)
Date:   Tue, 22 Mar 2022 09:22:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        ast@kernel.org, hjl.tools@gmail.com, rick.p.edgecombe@intel.com,
        rppt@kernel.org, linux-toolchains@vger.kernel.org,
        Andrew.Cooper3@citrix.com, ndesaulniers@google.com
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <20220322092255.2c23e414@gandalf.local.home>
In-Reply-To: <20220322214629.2bf40306e3beba23d88d509f@kernel.org>
References: <20220321140327.777f9554@canb.auug.org.au>
        <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
        <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
        <YjisdqdofbDIYj2U@hirez.programming.kicks-ass.net>
        <20220322143136.0e78366c3521b54b7b9385b8@kernel.org>
        <Yjm+TmKyO+HDOBgN@hirez.programming.kicks-ass.net>
        <20220322214629.2bf40306e3beba23d88d509f@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 21:46:29 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > > Indeed. I would like to replace the trampoline code of kretprobe with
> > > rethook, eventually. There is no reason why we keep the clone.
> > > (But I need more arch maintainers help for that, there are too many
> > >  archs implemented kretprobes)  
> > 
> > CONFIG_KPROBE_ON_RETHOOK - and then implement archs one by one?  
> 
> Sounds good! Maybe we will see different data structure fields
> which depends on that config, but those are internal fields, so
> user will not access it.

Which is basically what I do for ftrace. Which is why we have all these:

        select HAVE_DYNAMIC_FTRACE
        select HAVE_DYNAMIC_FTRACE_WITH_REGS
        select HAVE_DYNAMIC_FTRACE_WITH_ARGS
        select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
        select HAVE_SAMPLE_FTRACE_DIRECT
        select HAVE_SAMPLE_FTRACE_DIRECT_MULTI

in the architecture Kconfigs.

-- Steve

