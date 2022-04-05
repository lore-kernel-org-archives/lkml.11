Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B58DC433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 20:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241382AbiDEUp4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 16:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457619AbiDEQSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:18:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3C5B193D3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:16:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B5B41424;
        Tue,  5 Apr 2022 09:16:13 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.8.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85FD93F73B;
        Tue,  5 Apr 2022 09:16:11 -0700 (PDT)
Date:   Tue, 5 Apr 2022 17:16:02 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] linux/compiler-clang.h: define function_nocfi
Message-ID: <YkxrQl4zDe6YSoNO@FVFF77S0Q05N>
References: <20220401201916.1487500-1-samitolvanen@google.com>
 <20220401201916.1487500-3-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401201916.1487500-3-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 01:19:15PM -0700, Sami Tolvanen wrote:
> Use __builtin_function_start() to implement the function_nocfi() macro
> when CONFIG_CFI_CLANG is selected.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  include/linux/compiler-clang.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index babb1347148c..c84fec767445 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -69,6 +69,16 @@
>  #define __nocfi		__attribute__((__no_sanitize__("cfi")))
>  #define __cficanonical	__attribute__((__cfi_canonical_jump_table__))
>  
> +#if defined(CONFIG_CFI_CLANG)
> +/*
> + * With CONFIG_CFI_CLANG, the compiler replaces function address
> + * references with the address of the function's CFI jump table
> + * entry. The function_nocfi macro always returns the address of the
> + * actual function instead.
> + */
> +#define function_nocfi(x)	__builtin_function_start(x)
> +#endif

As a heads-up, with patches 1 and 2 applied (but not patch 3), we have two
definitions of function_nocfi(), which casues the compiler to scream for every
object:

| In file included from <built-in>:3:
| In file included from ././include/linux/compiler_types.h:107:
| ./arch/arm64/include/asm/compiler.h:33:9: warning: 'function_nocfi' macro redefined [-Wmacro-redefined]
| #define function_nocfi(x) ({                                            \
|         ^
| ./include/linux/compiler-clang.h:79:9: note: previous definition is here
| #define function_nocfi(x)       __builtin_function_start(x)
|         ^
| 1 warning generated.

... which would be painful for bisection.

I suspect It's probably worth folding patches 2 and 3 together to avoid that?

Arguably we could fold the entire series together into one commit at that
point.

Thanks,
Mark.
