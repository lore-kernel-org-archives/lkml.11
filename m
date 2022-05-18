Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE85EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 19:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241848AbiERT2r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 15:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiERT2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:28:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988A71BA8E6;
        Wed, 18 May 2022 12:28:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AA72B821AB;
        Wed, 18 May 2022 19:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D9FC385A5;
        Wed, 18 May 2022 19:28:41 +0000 (UTC)
Date:   Wed, 18 May 2022 15:28:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] tracing: fix possible null pointer dereference
Message-ID: <20220518152839.0f51830b@gandalf.local.home>
In-Reply-To: <20220517095723.7426-1-ruc_gongyuanjun@163.com>
References: <20220517095723.7426-1-ruc_gongyuanjun@163.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022 17:57:23 +0800
Yuanjun Gong <ruc_gongyuanjun@163.com> wrote:

> From: Gong Yuanjun <ruc_gongyuanjun@163.com>
> 
> In hist_trigger_elt_data_alloc(), elt_data is freed by
> hist_elt_data_free() if kcalloc fails.
> 
> static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
> {
> ...
> elt_data->field_var_str = kcalloc(n_str, sizeof(char *), GFP_KERNEL);
>         if (!elt_data->field_var_str) {

But at this position elt_data->n_field_var_str is zero.

>                 hist_elt_data_free(elt_data);
>                 return -EINVAL;
>         }
> ...}
> 
> In hist_elt_data_free() the elt_data->field_var_str field should be
> checked before dereference.
> 
> Signed-off-by: Gong Yuanjun <ruc_gongyuanjun@163.com>
> ---
>  kernel/trace/trace_events_hist.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 44db5ba9cabb..73177c9f94b2 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1576,11 +1576,11 @@ static void hist_elt_data_free(struct hist_elt_data *elt_data)
>  {
>  	unsigned int i;
>  
> -	for (i = 0; i < elt_data->n_field_var_str; i++)

This loop will not execute because n_field_var_str is zero, and 0 < 0 is
false.

> -		kfree(elt_data->field_var_str[i]);
> -
> -	kfree(elt_data->field_var_str);

freeing a NULL pointer is OK to do.

There is nothing wrong with the current code. NACK.

-- Steve

> -
> +	if (elt_data->field_var_str) {
> +		for (i = 0; i < elt_data->n_field_var_str; i++)
> +			kfree(elt_data->field_var_str[i]);
> +		kfree(elt_data->field_var_str);
> +	}
>  	kfree(elt_data->comm);
>  	kfree(elt_data);
>  }

