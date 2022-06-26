Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FAEC43334
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jun 2022 00:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiFZA0Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jun 2022 20:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiFZA0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 20:26:23 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD9E1181F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 17:26:22 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:44156)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5G6X-009Ew9-Cu; Sat, 25 Jun 2022 18:26:21 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57634 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5G6W-00AZG4-Dq; Sat, 25 Jun 2022 18:26:21 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Petr Mladek <pmladek@suse.com>,
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
Date:   Sat, 25 Jun 2022 19:26:13 -0500
In-Reply-To: <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 25 Jun 2022 11:25:21 -0700")
Message-ID: <87edzcw9qy.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o5G6W-00AZG4-Dq;;;mid=<87edzcw9qy.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+0Ew3aHKu/DFfK6TO/eca53o/6Gled/lY=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: re. Spurious wakeup on a newly created kthread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, Jun 25, 2022 at 10:36 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Let me suggest someone create a new variant of kthread_create that takes
>> all of the parameters the workqueue code wants to set.
>
> I suspect the real issue is that that the kthread code simply
> shouldn't use the kernel_thread() helper at all.
>
> That helper is literally designed for "start a thread, run this thing".
>
> That's what it *does*.
>
> And that's not at all what the kthread code wants. It wants to set
> affinity masks, it wants to create a name for the thread, it wants to
> do all those other things.
>
> That code really wants to just do copy_process().
>
> Or maybe it really should just use create_io_thread(), which has a
> much better interface, except it has that one oddity in that it sets
> the flag that does this:
>
>         if (args->io_thread) {
>                 /*
>                  * Mark us an IO worker, and block any signal that isn't
>                  * fatal or STOP
>                  */
>                 p->flags |= PF_IO_WORKER;
>                 siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
>         }
>
> that then has special semantics.

It is worth pointing out kthreads also have special semantics for
signals and they are different.  In particular kthreads ignore all
signals by default.

The io_threads are much more userspace threads and the userspace process
handles signals, it is just the io_thread that blocks the signals so
they will go to real userspace processes.

Eric

