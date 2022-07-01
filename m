Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40E8C43334
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 08:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbiGAIdf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 04:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiGAId3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:33:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D285E240B8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uRpohQNScmVGtWi4S52tn+WWM/ZbdD8yHswCWBcR6rI=; b=G42ddTmJYpNoVxw1MMfJsldsKK
        LtfXyhRrPe0xZhESEqIJpzkIjlWP3K1h4LebshYO6P4OXLrlcslCgBrcLbHCsrutG6EQvSNHFwXQj
        LIQd8Ih9gxYy9VgnRuH2KPJYA3lUfob/S8Prw9V8LCe6s6cvg+f94C76ZGEDGNU6NgKvkpCeyzys/
        Cs9dDWXkc0HOGFSkeXQN9D8+4lUk9YTq/h6jYqKTaH6sHDhF6EE53Ab86SU5q4GlfQmVdHLwJxZYw
        DuzZAA2j6QRujuZhdwUXXFWpJvO4A/5Z3+2Ec02rUa1q0RQIdcy8I3gBPDar2mjI8neeNCl12xP+m
        qfNdblWw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7C5H-00Eq1D-Bo; Fri, 01 Jul 2022 08:33:03 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44E8C980017; Fri,  1 Jul 2022 10:33:01 +0200 (CEST)
Date:   Fri, 1 Jul 2022 10:33:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: fix rq lock recursion issue
Message-ID: <Yr6xPWOReXNuDQqh@worktop.programming.kicks-ass.net>
References: <20220624074240.13108-1-quic_satyap@quicinc.com>
 <20220630215310.wb3kab72tlh5pq2g@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630215310.wb3kab72tlh5pq2g@airbuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 10:53:10PM +0100, Qais Yousef wrote:
> Hi Satya
> 
> On 06/24/22 00:42, Satya Durga Srinivasu Prabhala wrote:
> > Below recursion is observed in a rare scenario where __schedule()
> > takes rq lock, at around same time task's affinity is being changed,
> > bpf function for tracing sched_switch calls migrate_enabled(),
> > checks for affinity change (cpus_ptr != cpus_mask) lands into
> > __set_cpus_allowed_ptr which tries acquire rq lock and causing the
> > recursion bug.
> > 
> > Fix the issue by switching to preempt_enable/disable() for non-RT
> > Kernels.
> 
> Interesting bug. Thanks for the report. Unfortunately I can't see this being
> a fix as it just limits the bug visibility to PREEMPT_RT kernels, but won't fix
> anything, no? ie: Kernels compiled with PREEMPT_RT will still hit this failure.

Worse, there's !RT stuff that grew to rely on the preemptible migrate
disable stuff, so this actively breaks things.

> I'm curious how the race with set affinity is happening. I would have thought
> user space would get blocked as __schedule() will hold the rq lock.
> 
> Do you have more details on that?

Yeah, I'm not seeing how this works either, in order for
migrate_enable() to actually call __set_cpus_allowed_ptr(), it needs to
have done migrate_disable() *before* schedule, schedule() will then have
to call migrate_disable_swich(), and *then* migrate_enable() does this.

However, if things are nicely balanced (as they should be), then
trace_call_bpf() using migrate_disable()/migrate_enable() should never
hit this path.

If, OTOH, migrate_disable() was called prior to schedule() and we did do
migrate_disable_switch(), then it should be impossible for the
tracepoint/bpf stuff to reach p->migration_disabled == 0.

> > -010 |spin_bug(lock = ???, msg = ???)
> > -011 |debug_spin_lock_before(inline)
> > -011 |do_raw_spin_lock(lock = 0xFFFFFF89323BB600)
> > -012 |_raw_spin_lock(inline)
> > -012 |raw_spin_rq_lock_nested(inline)
> > -012 |raw_spin_rq_lock(inline)
> > -012 |task_rq_lock(p = 0xFFFFFF88CFF1DA00, rf = 0xFFFFFFC03707BBE8)
> > -013 |__set_cpus_allowed_ptr(inline)
> > -013 |migrate_enable()
> > -014 |trace_call_bpf(call = ?, ctx = 0xFFFFFFFDEF954600)
> > -015 |perf_trace_run_bpf_submit(inline)
> > -015 |perf_trace_sched_switch(__data = 0xFFFFFFE82CF0BCB8, preempt = FALSE, prev = ?, next = ?)
> > -016 |__traceiter_sched_switch(inline)
> > -016 |trace_sched_switch(inline)
> > -016 |__schedule(sched_mode = ?)
> > -017 |schedule()
> > -018 |arch_local_save_flags(inline)
> > -018 |arch_irqs_disabled(inline)
> > -018 |__raw_spin_lock_irq(inline)
> > -018 |_raw_spin_lock_irq(inline)
> > -018 |worker_thread(__worker = 0xFFFFFF88CE251300)
> > -019 |kthread(_create = 0xFFFFFF88730A5A80)
> > -020 |ret_from_fork(asm)

This doesn't clarify much. Please explain how things got to be
unbalanced, don't ever just make a problem dissapear like this without
understanding what the root cause is, that'll just get your reputation
sullied.
