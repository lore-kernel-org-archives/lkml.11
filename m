Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C069BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jan 2022 14:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579247AbiAYOg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jan 2022 09:36:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42906 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388184AbiAYOdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:33:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A741615CF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BEBC340E0;
        Tue, 25 Jan 2022 14:32:59 +0000 (UTC)
Date:   Tue, 25 Jan 2022 09:32:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     xkernel.wang@foxmail.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/histogram: fix a potential memory leak for
 kstrdup()
Message-ID: <20220125093258.222175c7@gandalf.local.home>
In-Reply-To: <tencent_C52895FD37802832A3E5B272D05008866F0A@qq.com>
References: <tencent_C52895FD37802832A3E5B272D05008866F0A@qq.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 12:07:15 +0800
xkernel.wang@foxmail.com wrote:

> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kfree() is missing on an error path to free the memory allocated by
> kstrdup():
> > p = param = kstrdup(data->params[i], GFP_KERNEL);  
> So it is better to free it via kfree(p).
> 

Applied. Thanks,

-- Steve

> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  kernel/trace/trace_events_hist.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index f01e442..1fac14c 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -3578,6 +3578,7 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
>  
>  			var_ref_idx = find_var_ref_idx(hist_data, var_ref);
>  			if (WARN_ON(var_ref_idx < 0)) {
> +				kfree(p);
>  				ret = var_ref_idx;
>  				goto err;
>  			}

