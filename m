Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DA1C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jun 2022 00:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiFZAWD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jun 2022 20:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiFZAWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 20:22:02 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C09D13EAC
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 17:22:01 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37100)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5G2H-00Bdks-Ul; Sat, 25 Jun 2022 18:21:59 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57630 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5G2G-00726l-Tu; Sat, 25 Jun 2022 18:21:57 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <20220622140853.31383-1-pmladek@suse.com>
        <YraWWl+Go17uPOgR@mtj.duckdns.org>
        <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
        <874k0863x8.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
        <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
        <87pmiw1fy6.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
Date:   Sat, 25 Jun 2022 19:21:50 -0500
In-Reply-To: <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 25 Jun 2022 16:43:39 -0700")
Message-ID: <87sfnsw9y9.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o5G2G-00726l-Tu;;;mid=<87sfnsw9y9.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/5qEuZjbMFSnC3oEQhRe8Cw7yT3Ii1FY0=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: re. Spurious wakeup on a newly created kthread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, Jun 25, 2022 at 4:28 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> I presume you mean kthreadd games?
>
> Yeah, sorry.
>
>> So with the introduction of kthreadd the kernel threads were moved
>> out of the userspace process tree, and userspace stopped being able to
>> influence the kernel threads.
>
> Ahh. So essentially it's indeed just basically the parenting issue.

That is one way to look at it.  The way I described it at the time was:

> commit 73c279927f89561ecb45b2dfdf9314bafcfd9f67
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Wed May 9 02:34:32 2007 -0700
> 
>     kthread: don't depend on work queues
>     
>     Currently there is a circular reference between work queue initialization
>     and kthread initialization.  This prevents the kthread infrastructure from
>     initializing until after work queues have been initialized.
>     
>     We want the properties of tasks created with kthread_create to be as close
>     as possible to the init_task and to not be contaminated by user processes.
>     The later we start our kthreadd that creates these tasks the harder it is
>     to avoid contamination from user processes and the more of a mess we have
>     to clean up because the defaults have changed on us.
>     
>     So this patch modifies the kthread support to not use work queues but to
>     instead use a simple list of structures, and to have kthreadd start from
>     init_task immediately after our kernel thread that execs /sbin/init.
>     
>     By being a true child of init_task we only have to change those process
>     settings that we want to have different from init_task, such as our process
>     name, the cpus that are allowed, blocking all signals and setting SIGCHLD
>     to SIG_IGN so that all of our children are reaped automatically.
>     
>     By being a true child of init_task we also naturally get our ppid set to 0
>     and do not wind up as a child of PID == 1.  Ensuring that tasks generated
>     by kthread_create will not slow down the functioning of the wait family of
>     functions.
>     
>     [akpm@linux-foundation.org: use interruptible sleeps]
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>     Cc: Oleg Nesterov <oleg@tv-sign.ru>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Eric
