Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A29C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 15:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiGAP2m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 11:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGAP2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:28:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D074E1F60D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 08:28:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 753D66240B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 15:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA63C3411E;
        Fri,  1 Jul 2022 15:28:39 +0000 (UTC)
Date:   Fri, 1 Jul 2022 11:28:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "XueBing Chen" <chenxuebing@jari.cn>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: use strscpy to replace strlcpy
Message-ID: <20220701112837.44f5a1b4@gandalf.local.home>
In-Reply-To: <479ff932.d17.181b9735fdb.Coremail.chenxuebing@jari.cn>
References: <479ff932.d17.181b9735fdb.Coremail.chenxuebing@jari.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022 19:09:15 +0800 (GMT+08:00)
"XueBing Chen" <chenxuebing@jari.cn> wrote:

> The strlcpy should not be used because it doesn't limit the source
> length. Preferred is strscpy.
> 
> Signed-off-by: XueBing Chen <chenxuebing@jari.cn>
> ---
>  kernel/trace/ftrace.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 601ccf1b2f09..8d2ad1472fcb 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5902,7 +5902,7 @@ bool ftrace_filter_param __initdata;
>  static int __init set_ftrace_notrace(char *str)
>  {
>  	ftrace_filter_param = true;
> -	strlcpy(ftrace_notrace_buf, str, FTRACE_FILTER_SIZE);
> +	strscpy(ftrace_notrace_buf, str, FTRACE_FILTER_SIZE);
>  	return 1;
>  }
>  __setup("ftrace_notrace=", set_ftrace_notrace);
> @@ -5910,7 +5910,7 @@ __setup("ftrace_notrace=", set_ftrace_notrace);
>  static int __init set_ftrace_filter(char *str)
>  {
>  	ftrace_filter_param = true;
> -	strlcpy(ftrace_filter_buf, str, FTRACE_FILTER_SIZE);
> +	strscpy(ftrace_filter_buf, str, FTRACE_FILTER_SIZE);
>  	return 1;
>  }
>  __setup("ftrace_filter=", set_ftrace_filter);
> @@ -5922,14 +5922,14 @@ static int ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer);
>  
>  static int __init set_graph_function(char *str)
>  {
> -	strlcpy(ftrace_graph_buf, str, FTRACE_FILTER_SIZE);
> +	strscpy(ftrace_graph_buf, str, FTRACE_FILTER_SIZE);
>  	return 1;
>  }
>  __setup("ftrace_graph_filter=", set_graph_function);
>  
>  static int __init set_graph_notrace_function(char *str)
>  {
> -	strlcpy(ftrace_graph_notrace_buf, str, FTRACE_FILTER_SIZE);
> +	strscpy(ftrace_graph_notrace_buf, str, FTRACE_FILTER_SIZE);
>  	return 1;
>  }


No need for strscpy() in init functions that simply read the kernel command
line.

>  __setup("ftrace_graph_notrace=", set_graph_notrace_function);
> @@ -6714,8 +6714,8 @@ static int ftrace_get_trampoline_kallsym(unsigned int symnum,
>  			continue;
>  		*value = op->trampoline;
>  		*type = 't';
> -		strlcpy(name, FTRACE_TRAMPOLINE_SYM, KSYM_NAME_LEN);
> -		strlcpy(module_name, FTRACE_TRAMPOLINE_MOD, MODULE_NAME_LEN);
> +		strscpy(name, FTRACE_TRAMPOLINE_SYM, KSYM_NAME_LEN);
> +		strscpy(module_name, FTRACE_TRAMPOLINE_MOD, MODULE_NAME_LEN);

The source is a macro, no need for strscpy() here.


>  		*exported = 0;
>  		return 0;
>  	}
> @@ -7046,7 +7046,7 @@ ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
>  		if (off)
>  			*off = addr - found_func->ip;
>  		if (sym)
> -			strlcpy(sym, found_func->name, KSYM_NAME_LEN);
> +			strscpy(sym, found_func->name, KSYM_NAME_LEN);

The name can not be bigger than KSYM_NAME_LEN, no need for strscpy() here.

>  
>  		return found_func->name;
>  	}
> @@ -7100,8 +7100,8 @@ int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
>  
>  			*value = mod_func->ip;
>  			*type = 'T';
> -			strlcpy(name, mod_func->name, KSYM_NAME_LEN);
> -			strlcpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);
> +			strscpy(name, mod_func->name, KSYM_NAME_LEN);
> +			strscpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);

Same for this.

I don't see how converting any of these to strscpy() is helpful.

NAK.

-- Steve

>  			*exported = 1;
>  			preempt_enable();
>  			return 0;

