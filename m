Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BCEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 14:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiDFOXX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiDFOW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:22:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0009C403294
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4aXZ494ANJFYAvSLf9NhNu+L9uOvwMwzlNqPPZ7D/DU=; b=CdOrnXSf7eOJy5u8uP3NfhtnA0
        ZdRBAqc4tSpAWCm9ndZN3DHdEYEUsd6Q6lBPnvQsN8C0igjwqLFf4D1l/jKk6c47mWTFk6lOFPCDa
        e+68yvxJDcg5MeB4GKcuetEKea4wS6ZEfjOlVWSSWT/mwhSjyZstIllCRzd0qMg4TIr03W+AHuCR1
        OJTvhn9vcgdaYjEXprF4bYdt5M7EhA44AHaZ1lWYGF6V1ZQYhporY6yq0vwnxyQoV7mKeKZK5JHzj
        emwKLJFk1Zik8aAwtV6X3EeV/wAfymC2ryxi/JECB9pwX/3vtJCm6+lcB6Lenhc35K9S8MP7OGt9Z
        TWHLTT5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nc2tF-0028k2-Ef; Wed, 06 Apr 2022 10:27:54 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FBB0986199; Wed,  6 Apr 2022 12:27:51 +0200 (CEST)
Date:   Wed, 6 Apr 2022 12:27:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Bernardo Meurer Costa <beme@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/extable: prefer local labels in .set directives
Message-ID: <20220406102751.GA2731@worktop.programming.kicks-ass.net>
References: <20220329202148.2379697-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329202148.2379697-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 01:21:45PM -0700, Nick Desaulniers wrote:
> Bernardo reported an error that Nathan bisected down to
> (x86_64) defconfig+LTO_CLANG_FULL+X86_PMEM_LEGACY.
> 
>     LTO     vmlinux.o
>   ld.lld: error: <instantiation>:1:13: redefinition of 'found'
>   .set found, 0
>               ^
> 
>   <inline asm>:29:1: while in macro instantiation
>   extable_type_reg reg=%eax, type=(17 | ((0) << 16))
>   ^
> 
> This appears to be another LTO specific issue similar to what was folded
> into commit 4b5305decc84 ("x86/extable: Extend extable functionality"),
> where the `.set found, 0` in DEFINE_EXTABLE_TYPE_REG in
> arch/x86/include/asm/asm.h conflicts with the symbol for the static
> function `found` in arch/x86/kernel/pmem.c.
> 
> Assembler .set directive declare symbols with global visibility, so the
> assembler may not rename such symbols in the event of a conflict. LTO
> could rename static functions if there was a conflict in C sources, but
> it cannot see into symbols defined in inline asm.
> 
> The symbols are also retained in the symbol table, regardless of LTO.
> 
> Give the symbols .L prefixes making them locally visible, so that they
> may be renamed for LTO to avoid conflicts, and to drop them from the
> symbol table regardless of LTO.
> 
> Fixes: 4b5305decc84 ("x86/extable: Extend extable functionality")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1612
> Link: https://sourceware.org/binutils/docs/as/Symbol-Names.html#Local-Symbol-Names
> Reported-by: Bernardo Meurer Costa <beme@google.com>
> Debugged-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks!
