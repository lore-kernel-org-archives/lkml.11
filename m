Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FD6C433FE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 16:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbiCDQNY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 11:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240623AbiCDQNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:13:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2105D1CA5E7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:12:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F07061D06
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 16:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1A5C340EF;
        Fri,  4 Mar 2022 16:12:27 +0000 (UTC)
Date:   Fri, 4 Mar 2022 11:12:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 2/4 v3] tracing: Add sample code for custom trace events
Message-ID: <20220304111226.264c7ae2@gandalf.local.home>
In-Reply-To: <20220305010930.ff114dbd48cc267d242a74ed@kernel.org>
References: <20220303220530.058538533@goodmis.org>
        <20220303220625.369226746@goodmis.org>
        <20220305010930.ff114dbd48cc267d242a74ed@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Mar 2022 01:09:30 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > --- a/arch/x86/kernel/kprobes/core.c
> > +++ b/arch/x86/kernel/kprobes/core.c
> > @@ -202,8 +202,10 @@ __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
> >  	 * arch_check_ftrace_location(). Something went terribly wrong
> >  	 * if such an address is checked here.
> >  	 */
> > -	if (WARN_ON(faddr && faddr != addr))
> > +	if (WARN_ON(faddr && faddr != addr)) {
> > +		printk("faddr=%pS (%lx) addr=%pS (%lx)\n", (void*)faddr, faddr, (void*)addr, addr);
> >  		return 0UL;
> > +	}  
> 
> This part seems not related to this patch.
> Can you drop this?

Ug, yeah. Thanks for spotting this. This was used to help debug the IBT
code from Peter Z. I didn't even notice it.

-- Steve
