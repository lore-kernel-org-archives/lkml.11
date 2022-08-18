Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C73C25B08
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Aug 2022 02:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242716AbiHRC2c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 22:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiHRC2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:28:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EA890C77
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFEA761494
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 02:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE63C433D6;
        Thu, 18 Aug 2022 02:28:27 +0000 (UTC)
Date:   Wed, 17 Aug 2022 22:28:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <jpoimboe@kernel.org>,
        <peterz@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>
Subject: Re: [PATCH] x86/unwind/orc: unwind ftrace trampolines with correct
 orc
Message-ID: <20220817222836.72aa77bd@gandalf.local.home>
In-Reply-To: <20220818015525.222053-1-chenzhongjin@huawei.com>
References: <20220818015525.222053-1-chenzhongjin@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 09:55:25 +0800
Chen Zhongjin <chenzhongjin@huawei.com> wrote:


>  arch/x86/kernel/unwind_orc.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index 38185aedf7d1..a938c5d0ed6f 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -93,22 +93,25 @@ static struct orc_entry *orc_find(unsigned long ip);
>  static struct orc_entry *orc_ftrace_find(unsigned long ip)
>  {
>  	struct ftrace_ops *ops;
> -	unsigned long caller;
> +	unsigned long tramp_addr, offset;
>  
>  	ops = ftrace_ops_trampoline(ip);
>  	if (!ops)
>  		return NULL;
>  

Now if this is that unlikely recursion mentioned below then ops->trampoline
will be NULL, and if we do that offset addition, it will be incorrect.

Perhaps we should add here:

	if (!ops->trampoline)
		return NULL;


Let's add some comments.

	/* Set tramp_addr to the start of the code copied by the trampoline */

>  	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS)
> -		caller = (unsigned long)ftrace_regs_call;
> +		tramp_addr = (unsigned long)ftrace_regs_caller;
>  	else
> -		caller = (unsigned long)ftrace_call;
> +		tramp_addr = (unsigned long)ftrace_caller;
> +

	/* Now place tramp_addr to the location within the trampoline ip is at */

> +	offset = ip - ops->trampoline;
> +	tramp_addr += offset;
>  
>  	/* Prevent unlikely recursion */
> -	if (ip == caller)
> +	if (ip == tramp_addr)
>  		return NULL;
>  
> -	return orc_find(caller);
> +	return orc_find(tramp_addr);
>  }
>  #else
>  static struct orc_entry *orc_ftrace_find(unsigned long ip)

