Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8686C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 15:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbiB1PqH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 10:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbiB1PqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:46:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E02879C79
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:45:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6A1AB811C2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A3EC340F0;
        Mon, 28 Feb 2022 15:45:24 +0000 (UTC)
Date:   Mon, 28 Feb 2022 10:45:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     bristot@kernel.org, paulmck@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
Message-ID: <20220228104523.01eda61a@gandalf.local.home>
In-Reply-To: <20220228141423.259691-1-nsaenzju@redhat.com>
References: <20220228141423.259691-1-nsaenzju@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 15:14:23 +0100
Nicolas Saenz Julienne <nsaenzju@redhat.com> wrote:

> @@ -1386,6 +1389,22 @@ static int run_osnoise(void)
>  					osnoise_stop_tracing();
>  		}
>  
> +		/*
> +		 * Check if we're the only ones running on this nohz_full CPU
> +		 * and that we're on a PREEMPT_RCU setup. If so, let's fake a
> +		 * QS since there is no way for RCU to know we're not making
> +		 * use of it.
> +		 *
> +		 * Otherwise it'll be done through cond_resched().
> +		 */
> +		if (IS_ENABLED(CONFIG_PREEMPT_RCU) &&
> +		    !housekeeping_cpu(raw_smp_processor_id(), HK_FLAG_MISC) &&
> +		    tick_nohz_tick_stopped()) {
> +			local_irq_save(flags);
> +			rcu_momentary_dyntick_idle();
> +			local_irq_restore(flags);
> +		}
> +

This looks very specific and a corner case. Something that depends on how
RCU works. This really should be in the RCU code such that if something
changes, RCU maintainers are aware of this and can update this too.

I wonder if this is similar to what we have in trace_benchmark(). Would
using: cond_resched_tasks_rcu_qs() work for you?

-- Steve


>  		/*
