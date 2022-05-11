Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0AFC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 20:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347923AbiEKU4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 16:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiEKU4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:56:34 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BA42AC5D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:56:32 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id otNXnkMYfWqfTotNYnPGX7; Wed, 11 May 2022 22:56:30 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 11 May 2022 22:56:30 +0200
X-ME-IP: 86.243.180.246
Message-ID: <324f245e-15e2-a1f2-bc8a-46255a1a859f@wanadoo.fr>
Date:   Wed, 11 May 2022 22:56:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/2] x86/asm/bitops: ffs: use __builtin_ffs to evaluate
 constant expressions
Content-Language: en-US
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220511160319.1045812-2-mailhol.vincent@wanadoo.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220511160319.1045812-2-mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/05/2022 à 18:03, Vincent Mailhol a écrit :
> For x86_64, the current ffs() implementation does not produce
> optimized code when called with a constant expression. On the
> contrary, the __builtin_ffs() function of both GCC and clang is able
> to simplify the expression into a single instruction.
> 

[...]

> 
> ** Statistics **
> 
> On a allyesconfig, before applying this patch...:
> 
> | $ objdump -d vmlinux.o | grep bsf | wc -l
> | 3607
> 
> ...and after:
> 
> | $ objdump -d vmlinux.o | grep bsf | wc -l
> | 792
> 
> So, roughly 26.7% of the call to ffs() were using constant expression
> and were optimized out.
> 
> 
nitpicking: numbers look odd.
    3607 is the exact same number as in patch 2/2. (ok, could be)
    26.7% is surprising with these numbers. (I guess it is (total_before 
- remaining) / total_before x 100 = (3607-792)/36.07 = 78.0%)

(but patch looks great to me :)

CJ
