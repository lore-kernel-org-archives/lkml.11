Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775EAC001B5
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 16:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiIBQas (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiIBQan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:30:43 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A99F386885
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:30:38 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 282GRT1B016993;
        Fri, 2 Sep 2022 11:27:29 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 282GRS0W016992;
        Fri, 2 Sep 2022 11:27:28 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 2 Sep 2022 11:27:28 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc/math-emu: Remove -w build flag and fix warnings
Message-ID: <20220902162728.GS25951@gate.crashing.org>
References: <a7384eafc6a27aea15bdc9e8f9a12aac593fccb7.1662113301.git.christophe.leroy@csgroup.eu> <35c86b7ca823954c6cd593acc3690dc3748da9b1.1662113301.git.christophe.leroy@csgroup.eu> <YxIjM/jdLajq4dFk@dev-arch.thelio-3990X> <20220902155954.GP25951@gate.crashing.org> <YxIrRJz3+fkzogay@dev-arch.thelio-3990X>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxIrRJz3+fkzogay@dev-arch.thelio-3990X>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri, Sep 02, 2022 at 09:11:48AM -0700, Nathan Chancellor wrote:
> On Fri, Sep 02, 2022 at 10:59:54AM -0500, Segher Boessenkool wrote:
> > Maybe add -Wno-implicit-fallthrough?  This code is a copy from outside
> > the kernel, no one has ever wanted to maintain it, if nothing else (the
> > more politically correct formulation is "we cannot as easily pick up
> > improvements from upstream if we modify stuff").
> 
> Sure, we could do something like this if you preferred:
> 
> diff --git a/arch/powerpc/math-emu/Makefile b/arch/powerpc/math-emu/Makefile
> index 26fef2e5672e..ed775747a2a5 100644
> --- a/arch/powerpc/math-emu/Makefile
> +++ b/arch/powerpc/math-emu/Makefile
> @@ -16,3 +16,7 @@ obj-$(CONFIG_SPE)		+= math_efp.o
>  
>  CFLAGS_fabs.o = -fno-builtin-fabs
>  CFLAGS_math.o = -fno-builtin-fabs
> +
> +ifdef CONFIG_CC_IS_CLANG
> +ccflags-remove-y := $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
> +endif

That is a GCC warning as well.  It needs some $(call cc-option ...)
thing then, though (GCC versions of more than two or so years ago are
supported as well).

> At the same time, I see other modifications to these files that appear
> to be for the kernel only so I suspect that this is already in the "we
> cannot as easily pick up improvements from upstream" category,
> regardless of that diff.

So maybe someone should really maintain this stuff, bring it up to some
reasonably modern state?  :-)


Segher
