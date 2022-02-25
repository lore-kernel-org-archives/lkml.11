Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3423FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 13:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241609AbiBYNnI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 08:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241618AbiBYNmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:42:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C599F1AE4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5qjyT+ZKelgJd14rLylT5OWqzGIhr+cM5+hmXw+z1ks=; b=vtxXtq6lyyGnmOQCvptEhOc4kd
        9Mk9/G3y9yJsU3rG11DJg7uufbhi1tcznol8gzNChBKRSR3q6acBC6SCg5YpGNf/FlscIRDWyej6v
        Qu7e32jyFeeA32ccazORQpuzjwncy9gjKVRYkaQfCiFZhadfbK9lwFErcx8G5cB5xdkJEb7P/o1Ye
        hOgvQtD3duxvYglhM9j3lizp42/3O7SIK+9plV0GbNPdOHQUszsJNurUryHyEn+FMn6a7vn9d+3pP
        9qkFOROW8pruhgArn0Fhf3SciLssYS4LxJZEIH+EyHdg+DHfjmbiK0SAqqhxfw5gTlWnnTQ8w5PwX
        7qTtm5tw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNar4-005p3W-H8; Fri, 25 Feb 2022 13:41:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3839300067;
        Fri, 25 Feb 2022 14:41:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8077A235EF288; Fri, 25 Feb 2022 14:41:52 +0100 (CET)
Date:   Fri, 25 Feb 2022 14:41:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2 05/39] x86: Base IBT bits
Message-ID: <YhjcoHh0ar9K6QrA@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.307406918@infradead.org>
 <202202241627.EEF3D5D2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202241627.EEF3D5D2@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 04:35:51PM -0800, Kees Cook wrote:

> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -36,7 +36,7 @@ endif
> >  
> >  # How to compile the 16-bit code.  Note we always compile for -march=i386;
> >  # that way we can complain to the user if the CPU is insufficient.
> > -REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING \
> > +REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
> >  		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
> >  		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
> >  		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)
> 
> This change seems important separately from this patch, yes? (Or at
> least a specific call-out in the commit log.)

It was to not stuff endbr in realmode code. *something* complained about
it (and Joao independently mentioned it on IRC).

Could be I hit some compile fail somewhere and this was the cleanest way
to simply make it go away.

I'll go mention it somewhere.

