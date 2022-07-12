Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A272CCA47F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 17:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiGLRwj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 13:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiGLRwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:52:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCE36715E;
        Tue, 12 Jul 2022 10:52:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78E6AB81A77;
        Tue, 12 Jul 2022 17:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50484C3411C;
        Tue, 12 Jul 2022 17:52:33 +0000 (UTC)
Date:   Tue, 12 Jul 2022 13:52:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <tom.zanussi@linux.intel.com>, <trix@redhat.com>,
        <stable@vger.kernel.org>, <zhangjinhao2@huawei.com>
Subject: Re: [PATCH] tracing/histograms: Simplify create_hist_fields()
Message-ID: <20220712135231.68d08a6f@gandalf.local.home>
In-Reply-To: <20220630013152.164871-1-zhengyejian1@huawei.com>
References: <20220630013152.164871-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2022 09:31:52 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 2784951e0fc8..832c4ccf41ab 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -4454,7 +4454,7 @@ static int create_hist_fields(struct hist_trigger_data *hist_data,
>  
>  	ret = parse_var_defs(hist_data);
>  	if (ret)
> -		goto out;
> +		return ret;

This is a functional change.

>  
>  	ret = create_val_fields(hist_data, file);
>  	if (ret)
> @@ -4465,8 +4465,7 @@ static int create_hist_fields(struct hist_trigger_data *hist_data,
>  		goto out;
>  
>  	ret = create_key_fields(hist_data, file);
> -	if (ret)
> -		goto out;
> +
>   out:

This is not a functional change ;-)

If you just had the latter, then it would have been OK to state "No
functional changes".

-- Steve

>  	free_var_defs(hist_data);
>  
