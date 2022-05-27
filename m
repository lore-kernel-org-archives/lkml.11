Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26832C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 10:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350833AbiE0KJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 06:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbiE0KJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:09:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28A41269B6
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xkq6oyv4mezzHkhYu3k0ysYU7hK3/0lw10H+rsE+PlI=; b=PRZL9dbVRl1FFJvrwBgq86f+oS
        6maaVMtUpXNuMslDolwTLBgQHw7aWPt3HDcVeBB9tFFhCPxFZ6/tGnpvpR26WZxNhbMnGUhyCrNqL
        PU/EuoFa0y3jtAPDKjhKjYa2gw3K51qcbhYAs1p2hw1/p4peDlPvgj5D1QYQPlyJtBquVQRPi1wDo
        cbh/DpFe6RXSfMkv4bZ6E/MCAKBpGVCGUIi2uZPQgMPYLti1NOGd0ooG6rQxa9HxqriPyQ7gcdVBI
        KEjzLTFMjd4UE9MQH0HfWgkwsz6qpXUPqfaD8nx9AKf8tYOeTGCzusWnq1rSNuq4Fao2kuuVE1zqT
        P8lO91vg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuWtp-002090-Ha; Fri, 27 May 2022 10:08:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA27F980F6C; Fri, 27 May 2022 12:08:51 +0200 (CEST)
Date:   Fri, 27 May 2022 12:08:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:objtool/urgent 9/9]
 arch/x86/include/asm/extable.h:47:86: warning: 'noreturn' function does
 return
Message-ID: <20220527100851.GT2578@worktop.programming.kicks-ass.net>
References: <202205262227.2m2DJfpJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205262227.2m2DJfpJ-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 10:11:34PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git objtool/urgent
> head:   43c6fc6a431b43163dc3950543dd87b986f25945
> commit: 43c6fc6a431b43163dc3950543dd87b986f25945 [9/9] x86/extable: Annotate ex_handler_msr_mce() as a dead end
> config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220526/202205262227.2m2DJfpJ-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=43c6fc6a431b43163dc3950543dd87b986f25945
>         git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
>         git fetch --no-tags peterz-queue objtool/urgent
>         git checkout 43c6fc6a431b43163dc3950543dd87b986f25945
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/mm/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/x86/include/asm/uaccess.h:13,
>                     from include/linux/uaccess.h:11,
>                     from arch/x86/mm/extable.c:3:
>    arch/x86/include/asm/extable.h: In function 'ex_handler_msr_mce':
> >> arch/x86/include/asm/extable.h:47:86: warning: 'noreturn' function does return
>       47 | static inline void __noreturn ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr) { }
>          |                                                                                      ^
> 
> 
> vim +/noreturn +47 arch/x86/include/asm/extable.h
> 
>     43	
>     44	#ifdef CONFIG_X86_MCE
>     45	extern void __noreturn ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr);
>     46	#else
>   > 47	static inline void __noreturn ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr) { }
>     48	#endif
>     49	

This seems to cure...

--- a/arch/x86/include/asm/extable.h
+++ b/arch/x86/include/asm/extable.h
@@ -44,7 +44,11 @@ extern void early_fixup_exception(struct
 #ifdef CONFIG_X86_MCE
 extern void __noreturn ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr);
 #else
-static inline void __noreturn ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr) { }
+static inline void __noreturn ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr)
+{
+	for (;;)
+		cpu_relax();
+}
 #endif
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_X86_64)

