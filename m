Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C2CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 13:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244290AbiCWNb7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 09:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236476AbiCWNb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:31:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015BD75C2C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77E1FB81EDB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 13:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD98C340E8;
        Wed, 23 Mar 2022 13:30:22 +0000 (UTC)
Date:   Wed, 23 Mar 2022 09:30:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     <oliver.sang@intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <lkp@intel.com>,
        <lkp@lists.01.org>, <matthias.bgg@gmail.com>, <mingo@redhat.com>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH] tracing: Avoid adding duplicated tracer options when
 update_tracer_options is running in parallel
Message-ID: <20220323093021.4f541b40@gandalf.local.home>
In-Reply-To: <20220323032442.22082-1-mark-pk.tsai@mediatek.com>
References: <20220322133339.GA32582@xsang-OptiPlex-9020>
        <20220323032442.22082-1-mark-pk.tsai@mediatek.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2022 11:24:42 +0800
Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:

> When update_tracer_options is running in parallel,
> tr->tops might be updated before the trace_types list traversal.
> Let update_tracer_options traverse the trace_types list safely in
> kernel init time and avoid the tr->tops update before it finish.

??? Have you seen a bug here? I'm totally confused by this.

> 
> Link: https://lore.kernel.org/lkml/20220322133339.GA32582@xsang-OptiPlex-9020/
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  kernel/trace/trace.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index adb37e437a05..2974ae056068 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6317,12 +6317,18 @@ static void tracing_set_nop(struct trace_array *tr)
>  	tr->current_trace = &nop_trace;
>  }
>  
> +static bool tracer_options_updated;
> +
>  static void add_tracer_options(struct trace_array *tr, struct tracer *t)
>  {
>  	/* Only enable if the directory has been created already. */
>  	if (!tr->dir)
>  		return;
>  
> +	/* Only create trace option files after update_tracer_options finish */
> +	if (!tracer_options_updated)
> +		return;
> +
>  	create_trace_option_files(tr, t);
>  }
>  
> @@ -9133,6 +9139,7 @@ static void update_tracer_options(struct trace_array *tr)
>  {
>  	mutex_lock(&trace_types_lock);

How is update_trace_options run in parallel?

There's a mutex that protects it. 

-- Steve


>  	__update_tracer_options(tr);
> +	tracer_options_updated = true;
>  	mutex_unlock(&trace_types_lock);
>  }
>  

