Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E2DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 12:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbiCVMPZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 08:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiCVMPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:15:23 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FFB26AA59
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:13:55 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22MCDceW010766;
        Tue, 22 Mar 2022 13:13:38 +0100
Date:   Tue, 22 Mar 2022 13:13:38 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6
 arguments
Message-ID: <20220322121338.GD10306@1wt.eu>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-4-ammarfaizi2@gnuweeb.org>
 <8653f6784a9b4272a59a75a530663567@AcuMS.aculab.com>
 <a8eeec1d-656d-15a3-dde5-0f8cc8c5956b@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8eeec1d-656d-15a3-dde5-0f8cc8c5956b@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 07:02:53PM +0700, Ammar Faizi wrote:
> I propose the
> following macro (this is not so much different with other my_syscall macro),
> expect the 6th argument can be in reg or mem.
> 
> The "rm" constraint here gives the opportunity for the compiler to use %ebp
> instead of memory if -fomit-frame-pointer is turned on.
> 
> #define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6) \
> ({                                                         \
>     long _ret;                                             \
>     register long _num asm("eax") = (num);                 \
>     register long _arg1 asm("ebx") = (long)(arg1);         \
>     register long _arg2 asm("ecx") = (long)(arg2);         \
>     register long _arg3 asm("edx") = (long)(arg3);         \
>     register long _arg4 asm("esi") = (long)(arg4);         \
>     register long _arg5 asm("edi") = (long)(arg5);         \
>     long _arg6 = (long)(arg6); /* Might be in memory */    \
>                                                            \
>     asm volatile (                                         \
>         "pushl  %[_arg6]\n\t"                              \
>         "pushl  %%ebp\n\t"                                 \
>         "movl   4(%%esp), %%ebp\n\t"                       \
>         "int    $0x80\n\t"                                 \
>         "popl   %%ebp\n\t"                                 \
>         "addl   $4,%%esp\n\t"                              \
>         : "=a"(_ret)                                       \
>         : "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3),   \
>           "r"(_arg4),"r"(_arg5), [_arg6]"rm"(_arg6)        \
>         : "memory", "cc"                                   \
>     );                                                     \
>     _ret;                                                  \
> })
> 
> What do you think?

Hmmm indeed that comes back to the existing constructs and is certainly
more in line with the rest of the code (plus it will not be affected by
-O0).

I seem to remember a register allocation issue which kept me away from
implementing it this way on i386 back then, but given that my focus was
not as much on i386 as it was on other platforms, it's likely that I have
not insisted too much and not tried this one which looks like the way to
go to me.

Willy
