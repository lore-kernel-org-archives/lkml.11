Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EA3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 03:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242906AbiELDCj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 23:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbiELDCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:02:35 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0E46668A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:02:34 -0700 (PDT)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id E7D8B36F;
        Thu, 12 May 2022 03:02:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id EDF332002B;
        Thu, 12 May 2022 03:02:28 +0000 (UTC)
Message-ID: <154f41707c58acdac26c3300c5b429f381c45708.camel@perches.com>
Subject: Re: [PATCH v4 1/2] x86/asm/bitops: ffs: use __builtin_ffs to
 evaluate constant expressions
From:   Joe Perches <joe@perches.com>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date:   Wed, 11 May 2022 20:02:28 -0700
In-Reply-To: <20220512011855.1189653-2-mailhol.vincent@wanadoo.fr>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
         <20220512011855.1189653-1-mailhol.vincent@wanadoo.fr>
         <20220512011855.1189653-2-mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: EDF332002B
X-Stat-Signature: s3ny7ydgms8u5bhpy6dseb6xt83hmmrk
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/YVM8TxruqLdoykQoTANU1GScIYiXrWm4=
X-HE-Tag: 1652324548-95630
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-12 at 10:18 +0900, Vincent Mailhol wrote:
> For x86_64, the current ffs() implementation does not produce
> optimized code when called with a constant expression. On the
> contrary, the __builtin_ffs() function of both GCC and clang is able
> to simplify the expression into a single instruction.
[]
> -static __always_inline int ffs(int x)
> +static __always_inline int variable_ffs(int x)
>  {
>  	int r;
>  
> @@ -310,6 +299,19 @@ static __always_inline int ffs(int x)
>  	return r + 1;
>  }
>  
> +/**
> + * ffs - find first set bit in word
> + * @x: the word to search
> + *
> + * This is defined the same way as the libc and compiler builtin ffs
> + * routines, therefore differs in spirit from the other bitops.
> + *
> + * ffs(value) returns 0 if value is 0 or the position of the first
> + * set bit if value is nonzero. The first (least significant) bit
> + * is at position 1.
> + */
> +#define ffs(x) (__builtin_constant_p(x) ? __builtin_ffs(x) : variable_ffs(x))

How about not defining another function and using parentheses around
the function definition to avoid the macro expansion like:

#define ffs(x) (__builtin_constant_p(x) ? __builtin_ffs(x) : ffs(x))

and

static __always_inline int (ffs)(int x)
{
	etc...
}


