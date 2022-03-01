Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDE6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 20:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbiCAU2b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239283AbiCAUYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:24:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F183EF31
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:23:53 -0800 (PST)
Date:   Tue, 1 Mar 2022 21:23:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646166231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JOg1nNSreIv4g+4hnmQwgrhYZxdLsYmyoIF3WgegJzA=;
        b=EOaCe+YgN2EN/eHhaVZgRG0cE/1QcQrKteAxkzb56dQ0tTAR3Qz6FtLGQzsfl/6m4S5jTD
        BYzbuE1nqA6356Qkil/PSOIHnqvq9y3MXxc/JeYSGilGgZNnH405JM5DDs++Q4LF3sb+oD
        0K29lYFVyDQ6ZONSq6e97jQ/c1R8xbsGcRuJZaH6WV9eB1jnydKwbmTCISQ6IwltxYiW7y
        GX9Mv/q53UNRihygG2DKaybG2lUcfy4q+3yXjLNIzuvXRS62Sr6oYsY0ArF3kyc4PJJ/7A
        rn+R7lby1rN5ES5ri38sJU+wMj93uJ38eq2O7uobqOn9m883E+c4WBvaUWaDRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646166231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JOg1nNSreIv4g+4hnmQwgrhYZxdLsYmyoIF3WgegJzA=;
        b=EEB4w2SS7LimcNYXnz4B76ErC9H147ul9l1oPRRerWJcg8Bi95WXRB63EanvoLlvj4xxRD
        v5TUzcHeIHbhGuBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: Make preempt_enable_no_resched() behave like
 preempt_enable() on PREEMPT_RT
Message-ID: <Yh6A1a6yBfPW8AMk@linutronix.de>
References: <Yh5mSGCbvqDdeCa3@linutronix.de>
 <20220301201432.GL11184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220301201432.GL11184@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-01 21:14:32 [+0100], Peter Zijlstra wrote:
> Ignoring !x86 for a moment:
> 
> arch/x86/mm/kmmio.c:    preempt_enable_no_resched();
> arch/x86/mm/kmmio.c:    preempt_enable_no_resched();
> include/linux/preempt.h:#define sched_preempt_enable_no_resched() \
> include/linux/preempt.h:#define preempt_enable_no_resched() sched_preempt_enable_no_resched()
> include/linux/preempt.h:#define preempt_enable_no_resched_notrace() \
> include/linux/preempt.h:#define sched_preempt_enable_no_resched()       barrier()
> include/linux/preempt.h:#define preempt_enable_no_resched()             barrier()
> include/linux/preempt.h:#define preempt_enable_no_resched_notrace()     barrier()
> include/linux/preempt.h:#undef sched_preempt_enable_no_resched
> include/linux/preempt.h:#undef preempt_enable_no_resched
> include/linux/preempt.h:#undef preempt_enable_no_resched_notrace
> kernel/sched/core.c:            preempt_enable_no_resched();
> kernel/sched/core.c:                    preempt_enable_no_resched();
> kernel/sched/core.c:            sched_preempt_enable_no_resched();
> kernel/sched/core.c:    sched_preempt_enable_no_resched();
> kernel/sched/core.c:            sched_preempt_enable_no_resched();
> kernel/sched/core.c:            preempt_enable_no_resched_notrace();
> kernel/sched/core.c:            preempt_enable_no_resched_notrace();
> kernel/sched/core.c:            sched_preempt_enable_no_resched();
> kernel/sched/core.c:    sched_preempt_enable_no_resched();
> kernel/signal.c:                preempt_enable_no_resched();
> kernel/smpboot.c:                       preempt_enable_no_resched();
> lib/smp_processor_id.c: preempt_enable_no_resched_notrace();
> 
> 
> Surely we can audit that... At a glance the proposed patch does more
> harm than good. Only the kmmio case looks obviousl fail, but then IIRC
> kmmio had worse problems.

I was looking at the same before posting it. The majority of it
disappeared over time after certain someone made it worthless for
modules. So I'm dropping it then.
Does it make sense to keep sched_preempt_enable_no_resched() or should I
move everything to preempt_enable_no_resched()?

Sebastian
