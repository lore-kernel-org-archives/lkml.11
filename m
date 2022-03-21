Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A900C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 16:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351384AbiCUQrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 12:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243912AbiCUQrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:47:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AEE6D38B;
        Mon, 21 Mar 2022 09:45:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E0A6B81822;
        Mon, 21 Mar 2022 16:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084F6C340E8;
        Mon, 21 Mar 2022 16:45:52 +0000 (UTC)
Date:   Mon, 21 Mar 2022 12:45:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        mhiramat@kernel.org, ast@kernel.org, hjl.tools@gmail.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        linux-toolchains@vger.kernel.org, Andrew.Cooper3@citrix.com,
        ndesaulniers@google.com
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <20220321124551.3d73660b@gandalf.local.home>
In-Reply-To: <YjiqgPL+pPGkOgCv@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
        <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
        <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
        <20220321112805.1393f9b9@gandalf.local.home>
        <YjiiDFHIQg78QwSb@hirez.programming.kicks-ass.net>
        <20220321121209.3b95e406@gandalf.local.home>
        <20220321121549.1c8588c5@gandalf.local.home>
        <YjiqgPL+pPGkOgCv@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022 17:40:32 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> func_B:
> 	call __fentry__	/* push func_B */
> 	...
> 	call __fexit__	/* pop 1 + tails */
> 	ret
> 
> func_A:
> 	call __fentry__ /* push func_A */
> 	...
> 	call __ftail__  /* mark func_A tail */
> 	jmp func_B
> 
> func_C:
> 	call __fentry__ /* push func_C */
> 	call func_A;
> 	...
> 	call __fexit__  /* pop 1 + tails */
> 	ret;

This also assumes that we need to trace everything that is marked. I
mentioned in another email, what do we do if we only trace funcA?

-- Steve
