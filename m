Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED89C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 01:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiBXBmH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 20:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiBXBmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:42:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2408F1086
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:41:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48D0360FE0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9373CC340EF;
        Thu, 24 Feb 2022 01:17:27 +0000 (UTC)
Date:   Wed, 23 Feb 2022 20:17:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        broonie@kernel.org, mark.rutland@arm.com, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        qirui.001@bytedance.com
Subject: Re: [PATCH v2 1/2] ftrace: cleanup ftrace_graph_caller enable and
 disable
Message-ID: <20220223201725.4cbb6d8a@rorschach.local.home>
In-Reply-To: <20220223090132.10114-1-zhouchengming@bytedance.com>
References: <20220223090132.10114-1-zhouchengming@bytedance.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 17:01:31 +0800
Chengming Zhou <zhouchengming@bytedance.com> wrote:

> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 7cc540e6de0c..c119ef7a9295 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -615,18 +615,8 @@ int ftrace_disable_ftrace_graph_caller(void)
>  
>  	return ftrace_mod_jmp(ip, &ftrace_stub);
>  }
> -#else /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
> -int ftrace_enable_ftrace_graph_caller(void)
> -{
> -	return 0;
> -}
> -
> -int ftrace_disable_ftrace_graph_caller(void)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
> -#endif /* !CONFIG_DYNAMIC_FTRACE */
> +#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
> +#endif /* CONFIG_DYNAMIC_FTRACE */

Since you are cleaning this up, and the above starts with:

#ifdef CONFIG_DYNAMIC_FTRACE

#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS


They were separate because of the #else that you just removed. I would
recommend consolidate them into a single #ifdef:

#if defined(CONFIG_DYNAMIC_FTRACE) && !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS)

[..]

#endif /* CONFIG_DYNAMIC_FTRACE && !CONFIG_HAVE_DYNAMI_FTRACE_WITH_ARGS */


-- Steve


>  
>  /*
>   * Hook the return address and push it in the stack of return addrs
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f9feb197b2da..60ae009e6684 100644
