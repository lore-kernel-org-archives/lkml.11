Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B2BC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 12:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiFBM0V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 08:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiFBM0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:26:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F72F298585
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:26:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ED4561751
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E44DC34119;
        Thu,  2 Jun 2022 12:26:03 +0000 (UTC)
Date:   Thu, 2 Jun 2022 08:25:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     sunliming <sunliming@kylinos.cn>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        kelulanainsley@gmail.com
Subject: Re: [PATCH] tracing: Simplify conditional compilation code in
 tracing_set_tracer()
Message-ID: <20220602082559.795189e1@rorschach.local.home>
In-Reply-To: <20220602022404.508144-1-sunliming@kylinos.cn>
References: <20220602022404.508144-1-sunliming@kylinos.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Jun 2022 10:24:04 +0800
sunliming <sunliming@kylinos.cn> wrote:

> Two conditional compilation directives "#ifdef CONFIG_TRACER_SNAPSHOT"
> are used consecutively, and no other code in between. Simplify conditional
> the compilation code and only use one "#ifdef CONFIG_TRACER_SNAPSHOT".

I think you mean CONFIG_TRACER_MAX_TRACE here.

-- Steve

> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  kernel/trace/trace.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index f400800bc910..dc959e339512 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6430,9 +6430,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
>  		synchronize_rcu();
>  		free_snapshot(tr);
>  	}
> -#endif
>  
> -#ifdef CONFIG_TRACER_MAX_TRACE
>  	if (t->use_max_tr && !had_max_tr) {
>  		ret = tracing_alloc_snapshot_instance(tr);
>  		if (ret < 0)

