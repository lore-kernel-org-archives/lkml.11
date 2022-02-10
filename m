Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89195C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 15:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243741AbiBJPrq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 10:47:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239919AbiBJPrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:47:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE15DC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:47:42 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4B2CF1F399;
        Thu, 10 Feb 2022 15:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644508061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6DvmGQ057+uOZYubo7rFkvNL5DX0u2Pzzr6JgHWxYu0=;
        b=ZElNN3FZwb3XaoWPOEpxq20+Lo98lpDcydjimmmeGoS+6YKUt0xluEeAjzn0kKBTBO5gpC
        PgOvA1N5BT5iEnM6/Q8NF+2YtXhFWPMu2dv+9eqmVdK4lhOluO8YW9lmDUrbndryrc5MXi
        Jn7NOJC3tP1ZiO1F9SYi0Bsch2o56Kc=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E6FA1A3B83;
        Thu, 10 Feb 2022 15:47:40 +0000 (UTC)
Date:   Thu, 10 Feb 2022 16:47:39 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] printk: defer_console_output: use atomic update
Message-ID: <YgUzm5POctivsjUg@alley>
References: <20220203112915.1350753-1-john.ogness@linutronix.de>
 <YfzP50vDiJiaRVCr@google.com>
 <87bkzj3t77.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkzj3t77.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-07 10:52:20, John Ogness wrote:
> The per-cpu @printk_pending variable can be updated from
> sleepable contexts, such as:
> 
>   get_random_bytes()
>     warn_unseeded_randomness()
>       printk_deferred()
>         defer_console_output()
> 
> and can be updated from interrupt contexts, such as:
> 
>   handle_irq_event_percpu()
>     __irq_wake_thread()
>       wake_up_process()
>         try_to_wake_up()
>           select_task_rq()
>             select_fallback_rq()
>               printk_deferred()
>                 defer_console_output()
> 
> and can be updated from NMI contexts, such as:
> 
>   vprintk()
>     if (in_nmi()) defer_console_output()
> 
> Therefore this_cpu_or(), the atomic variant of __this_cpu_or(),
> should be used to update the variable.
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Makes sense.

The patch has been committed into printk/linux.git, branch for-5.18.

Best Regards,
Petr
