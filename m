Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344BDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 15:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238299AbiBOP1M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:27:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiBOP1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:27:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B0375E73
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:26:58 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C614D1F392;
        Tue, 15 Feb 2022 15:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644938816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dlG8fKH5x541PzrRHKYThguxn3zd3UnEfYJY4nE7XYk=;
        b=bf+Q4iMYliQm/gT4OrBDIJ10PYZSVK59IKkYfsu6gVBAoAAqHAcljn6ZqAHfJ0sn8fQUch
        V1SloUKhcryUkiWBYCkCQet+mcIkeYDJLd9pwR60lOocM4tFP2Ey1vJUgCsR6DlbmxTDw4
        pSVS+U1gNtNnDmhN+jbK1HGqEc5s/gI=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 891A9A3B88;
        Tue, 15 Feb 2022 15:26:56 +0000 (UTC)
Date:   Tue, 15 Feb 2022 16:26:56 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3] printk: use atomic updates for klogd work
Message-ID: <YgvGQO+RbPQ/PEEq@alley>
References: <20220203112915.1350753-1-john.ogness@linutronix.de>
 <YfzP50vDiJiaRVCr@google.com>
 <87bkzj3t77.fsf@jogness.linutronix.de>
 <YgUzm5POctivsjUg@alley>
 <87leyhd4wc.fsf@jogness.linutronix.de>
 <87iltld4ue.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iltld4ue.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-02-11 12:29:37, John Ogness wrote:
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
> Therefore the atomic variant of the updating functions must be used.
> 
> Replace __this_cpu_xchg() with this_cpu_xchg().
> Replace __this_cpu_or() with this_cpu_or().
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

The v3 patch is comitted in printk/linux.git, branch for.5.18.

I have replaced v2 version with it.

Best Regards,
Petr
