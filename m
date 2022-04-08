Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15704C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 19:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiDHTnS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 15:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiDHTnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:43:16 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EF01A801
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 12:41:11 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:42746)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ncuTk-00C3Ie-SS; Fri, 08 Apr 2022 13:41:08 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:42862 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ncuTi-007Kjk-MT; Fri, 08 Apr 2022 13:41:08 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <Yh/b19JikC+Vnm8i@linutronix.de>
        <20220314185429.GA30364@redhat.com> <YjBO8yzxdmjTGNiy@linutronix.de>
        <20220315142944.GA22670@redhat.com> <YkW55u6u2fo5QmV7@linutronix.de>
        <20220405101026.GB34954@worktop.programming.kicks-ass.net>
        <20220405102849.GA2708@redhat.com>
        <Ykwn0MpcrZ/N+LOG@hirez.programming.kicks-ass.net>
        <20220407121340.GA2762@worktop.programming.kicks-ass.net>
        <87v8vk8q4g.fsf@email.froward.int.ebiederm.org>
        <20220408090908.GO2731@worktop.programming.kicks-ass.net>
Date:   Fri, 08 Apr 2022 14:40:42 -0500
In-Reply-To: <20220408090908.GO2731@worktop.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Fri, 8 Apr 2022 11:09:08 +0200")
Message-ID: <874k332wjp.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ncuTi-007Kjk-MT;;;mid=<874k332wjp.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18gdPkKSpj7Z7VBxZ2y31rC9yKS9HjfR0w=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] ptrace: fix ptrace vs tasklist_lock race on PREEMPT_RT.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Apr 07, 2022 at 05:50:39PM -0500, Eric W. Biederman wrote:

>> Given that fundamentally TASK_WAKEKILL must be added in ptrace_stop and
>> removed in ptrace_attach I don't see your proposed usage of jobctl helps
>> anything fundamental.
>> 
>> I suspect somewhere there is a deep trade-off between complicating
>> the scheduler to have a very special case for what is now
>> TASK_RTLOCK_WAIT, and complicating the rest of the code with having
>> TASK_RTLOCK_WAIT in __state and the values that should be in state
>> stored somewhere else.
>
> The thing is; ptrace is a special case. I feel very strongly we should
> not complicate the scheduler/wakeup path for something that 'never'
> happens.

I was going to comment that I could not understand how the saved_state
mechanism under PREEMPT_RT works.  Then I realized that wake_up_process
and wake_up_state call try_to_wake_up which calls ttwu_state_match which
modifies saved_state.


The options appear to be that either ptrace_freeze_traced modifies
__state/state to remove TASK_KILLABLE.  Or that something clever happens
in ptrace_freeze_traced that guarantees the task does not wake
up.  Something living in kernel/sched/* like wait_task_inactive.


I can imagine adding add a loop around freezable_schedule in
ptrace_stop.  That does something like:

	do {
        	freezable_schedule();
        } while (current->jobctl & JOBCTL_PTRACE_FREEZE);

Unfortunately after a SIGKILL is delivered the process will never sleep
unless there is a higher priority process to preempt it.  So I don't
think that is a viable solution.


What ptrace_freeze_traced and ptrace_unfreeze_traced fundamentally need
is that the process to not do anything interesting, so that the tracer
process can modify the process and it's task_struct.


That need is the entire reason ptrace does questionable things with
with __state.

So if we can do something better perhaps with a rewritten freezer it
would be a general code improvement.


The ptrace code really does want TASK_KILLABLE semantics the entire time
a task is being manipulated by the ptrace system call.   The code in
ptrace_unfreeze_traced goes through some gymnastics to detect if a
process was killed while traced (AKA to detect a missed SIGKILL)
and to use wake_up_state to make the task runnable instead of putting
it back in TASK_TRACED.

So really all that is required is a way to ask the scheduler to just
not schedule the process until the ptrace syscall completes and calls
ptrace_unfreeze_traced.

Eric
