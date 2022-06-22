Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A674CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 14:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358513AbiFVOyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357566AbiFVOyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:54:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CCA26ACF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:54:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7418B61CD2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39B2C34114;
        Wed, 22 Jun 2022 14:54:37 +0000 (UTC)
Date:   Wed, 22 Jun 2022 10:54:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        christophe.leroy@csgroup.eu, naveen.n.rao@linux.vnet.ibm.com,
        mbenes@suse.cz, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [RFC][PATCH] ftrace,objtool: PC32 based __mcount_loc
Message-ID: <20220622105436.775ccf7f@rorschach.local.home>
In-Reply-To: <YqxoEJG6jGDWitg3@FVFF77S0Q05N>
References: <YqxkhV1YcI6e+xXp@worktop.programming.kicks-ass.net>
        <YqxoEJG6jGDWitg3@FVFF77S0Q05N>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2022 12:40:00 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> We have a similar issue on arm64, which is exacerbated by needing ABS64
> relocations (24 bytes per entry!) adding significant bloat when FTRACE is
> enabled.

I have patches that bring down the size quite a bit. The mcount loc is
read into the dyn_rec, which has two longs (the second long is the
flags that only use 32 bits, but is a long to make it aligned, as a 64
bit word followed by a 32bit word just added 32 bits of padding to make
it an array).

The patches make it into two ints (which bring down the size for 64 bit
machines). The lists are broken up into blocks, and what I do is put
the top 32 bits of a word into the top of the block, and make sure that
they are the same among all the entries in the block.

I guess its time to bring this back alive.

-- Steve

> 
> It'd be really nice if going forwards compilers could expose an option to
> generate PC32/PREL32 entries directly for this.

