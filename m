Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B84C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 14:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiFWOVg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 10:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiFWOVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:21:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 131C243EFE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:21:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DF9012FC;
        Thu, 23 Jun 2022 07:21:35 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.26.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 698463F66F;
        Thu, 23 Jun 2022 07:21:33 -0700 (PDT)
Date:   Thu, 23 Jun 2022 15:21:30 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        christophe.leroy@csgroup.eu, naveen.n.rao@linux.vnet.ibm.com,
        mbenes@suse.cz, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [RFC][PATCH] ftrace,objtool: PC32 based __mcount_loc
Message-ID: <YrR26pFadVbt5RSh@FVFF77S0Q05N.cambridge.arm.com>
References: <YqxkhV1YcI6e+xXp@worktop.programming.kicks-ass.net>
 <YqxoEJG6jGDWitg3@FVFF77S0Q05N>
 <20220622105436.775ccf7f@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622105436.775ccf7f@rorschach.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:54:36AM -0400, Steven Rostedt wrote:
> On Fri, 17 Jun 2022 12:40:00 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > We have a similar issue on arm64, which is exacerbated by needing ABS64
> > relocations (24 bytes per entry!) adding significant bloat when FTRACE is
> > enabled.
> 
> I have patches that bring down the size quite a bit. The mcount loc is
> read into the dyn_rec, which has two longs (the second long is the
> flags that only use 32 bits, but is a long to make it aligned, as a 64
> bit word followed by a 32bit word just added 32 bits of padding to make
> it an array).
> 
> The patches make it into two ints (which bring down the size for 64 bit
> machines). The lists are broken up into blocks, and what I do is put
> the top 32 bits of a word into the top of the block, and make sure that
> they are the same among all the entries in the block.
> 
> I guess its time to bring this back alive.

I don't think that helps? I'm on about the size of the kernel "Image" file, not
the runtime memory footprint.

... unless you mean doing that at compiler time?

Mark.
