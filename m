Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF876C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 13:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346705AbiDKNty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 09:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbiDKNtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:49:53 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515E015802
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:47:39 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:34458)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nduOH-00FRlk-22; Mon, 11 Apr 2022 07:47:37 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:43166 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nduOF-006sHs-Pu; Mon, 11 Apr 2022 07:47:36 -0600
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
References: <20220315142944.GA22670@redhat.com>
        <YkW55u6u2fo5QmV7@linutronix.de>
        <20220405101026.GB34954@worktop.programming.kicks-ass.net>
        <20220405102849.GA2708@redhat.com>
        <Ykwn0MpcrZ/N+LOG@hirez.programming.kicks-ass.net>
        <20220407121340.GA2762@worktop.programming.kicks-ass.net>
        <87v8vk8q4g.fsf@email.froward.int.ebiederm.org>
        <20220408090908.GO2731@worktop.programming.kicks-ass.net>
        <874k332wjp.fsf@email.froward.int.ebiederm.org>
        <YlCVxlTVL1pyBF08@hirez.programming.kicks-ass.net>
        <YlQSe6m2tidxwHt0@hirez.programming.kicks-ass.net>
Date:   Mon, 11 Apr 2022 08:44:24 -0500
In-Reply-To: <YlQSe6m2tidxwHt0@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Mon, 11 Apr 2022 13:35:23 +0200")
Message-ID: <87ee23zqdj.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nduOF-006sHs-Pu;;;mid=<87ee23zqdj.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX188ZDHkbBs9DsD+QJBQKY9+zMFZ+64NOjs=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] ptrace: fix ptrace vs tasklist_lock race on PREEMPT_RT.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Fri, Apr 08, 2022 at 10:06:30PM +0200, Peter Zijlstra wrote:
>
>> I'll ponder if wait_task_inactive() can simplify things..
>
> This,.. so ptrace_check_attach(), which does ptrace_freeze_traced()
> already does wait_task_inactive(), but on the 'wrong' side of things.
>
> AFAICT, if we move that up, we're almost there, except that opens up a
> detach+attach race. That could be fixed by doing another
> wait_task_inactive(), but we can't due to locking :/
>
> Let's see if I can make that work without making a mess of things.
> Because ensuring the task is stuck in schedule() makes the whole
> saved_state thing go away -- as you noted.

The code can perhaps synchronize on a bit using the the full locking and
then drop the locks and call the wait_task_inactive or whatever.

The challenge as I see it is after the traced task is inactive to allow
"wake_up_state(t, TASK_WAKEKILL)" on the traced task, have the traced
tasks state change to TASK_RUNNING and not allow the traced task to run
until what is today ptrace_unfreeze_task is called.

I just don't know how to get something stuck and not allow it to run.

Eric
