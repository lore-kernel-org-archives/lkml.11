Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB20C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 18:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349765AbiC3SM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349729AbiC3SMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:12:22 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BD42B9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:10:36 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:42536)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nZcm8-003ss1-As; Wed, 30 Mar 2022 12:10:32 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:41730 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nZcm5-00GERa-R8; Wed, 30 Mar 2022 12:10:31 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <Ygq5aBB/qMQw6aP5@linutronix.de>
        <8735j2xigt.fsf@email.froward.int.ebiederm.org>
        <YkHfokLO1UGCISGc@linutronix.de>
        <87zgl9pw82.fsf@email.froward.int.ebiederm.org>
        <YkLR3rGTayl/6qIm@linutronix.de>
Date:   Wed, 30 Mar 2022 13:10:05 -0500
In-Reply-To: <YkLR3rGTayl/6qIm@linutronix.de> (Sebastian Andrzej Siewior's
        message of "Tue, 29 Mar 2022 11:31:10 +0200")
Message-ID: <87o81nl3b6.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nZcm5-00GERa-R8;;;mid=<87o81nl3b6.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX181c8bUv4aeOucoS6HSJ6n9gNxRXw+U5Lk=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] signal/x86: Delay calling signals in atomic
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2022-03-28 17:07:25 [-0500], Eric W. Biederman wrote:
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>> 
>> We have a few other cases where we deliver signals from interrupts.
>> Off the top of my head there is SAK and magic sysrq, but I think there
>> are more.  So I am also not convinced that all signals you care about
>> will go through force_sig_info_to_task.
>> 
>> What I really don't know and this is essentially a PREEMPT_RT question
>> is what makes int3 special?  Why don't other faults have this problem?
>
> int3 on x86 is delivered from the debug interrupt and at this point
> interrupts are in general disabled even on PREEMPT_RT.
> If you are in a section which disables interrupts via
> spin_lock_irqsave() then interrupts are not disabled on PREEMPT_RT.
> If you are in an interrupt handler (as per request_irq(), not the
> special vector that is used for int3 handling) then interrupts are also
> not disabled because the interrupt handler is threaded by default.
>
> In both cases in_atomic() reports 0 on PREEMPT_RT. So the exception is:
> - explicit usage of local_irq_{save|disable}, preempt_disable().
> - usage of raw_spinlock_t locks.
> - interrupts vectors which are not threaded (like int3 or the SMP IPI
>   function call).
>
>> I remember there was a change where we had threaded interrupt handlers
>> to get around this for interrupt service routines.  I wonder if we need
>> to do something similar with faults.  Have a fast part and a threaded
>> part that runs in a schedulable way.  Although given that for a fault
>> you need to be fundamentally bound to the task/thread you faulted from
>> it probably just means having a way to switch to a kernel stack that you
>> can schedule from, and not use a reserved per cpu stack.  The
>> task_struct would certainly need to stay the same for all of the pieces.
>> 
>> Or maybe for PREMPT_RT you pick the i386 mechanism.  How does PREEMPT_RT
>> deal with page faults, or general protection faults?
>
> An in-kernel stack overflow will panic() with interrupts disabled.
> An in-kernel NULL-pointer is also entered with disabled interrupts and
> complains later about sleeping locks in do_exit(). I do remember that
> the arch code conditionally enabled interrupts based on IRQ-flags on
> stack.
>
>> This is my long winded way of saying that I rather expect that if
>> PREEMPT_RT is going to call code it has modified to be sleeping that it
>> would also make it safe for that code to sleep.
>> 
>> Further (and this is probably my ignorance) I just don't see what makes
>> any of this specific to just int3.  Why aren't other faults affected?
>
> That NULL-pointer in kernel doesn't look good. If you have a test-case
> (like do this) then I can definitely look into it in case more is
> missed.

The linux kernel dump test module aka drivers/misc/lkdtm should have
that and several other nasty ways to die as a test cases.

So I am confused.  The call path that is trying to be fixed is:

idtentry
  idtentry_body
    exc_int3
      do_int3_user
        do_trap
          force_sig

There are a multiple am I from userspace checks and I did not verify
they are all equal, so I may have missed something subtle.

But it looks like if we are coming from userspace then we use the same
stack as any other time we would come from userspace.  AKA a stack
that allows the kernel to sleep.

So I don't see what the problem is that is trying to be fixed.

I know that code has been changed over the years, perhaps this is
something that was fixed upstream and the real time tree didn't realize
there was no longer a need to fix anything?

Or am I missing something subtle when reading the idtentry assembly?

Eric
