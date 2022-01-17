Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54725C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jan 2022 15:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240636AbiAQPps (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jan 2022 10:45:48 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:54542 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240627AbiAQPpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:45:42 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:33720)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9UCT-004xBO-RM; Mon, 17 Jan 2022 08:45:41 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:43290 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9UCP-0039lU-RD; Mon, 17 Jan 2022 08:45:41 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <878rvhlvh2.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wgS865kHU=4NO=AvK07fcK7M6C6EYGdk80R1tkPKTLyhQ@mail.gmail.com>
        <CAHk-=wheeokE5rr_64iS_qnKmzSH4=e2Ds2L3gR_zSH=Cr4F5w@mail.gmail.com>
Date:   Mon, 17 Jan 2022 09:45:30 -0600
In-Reply-To: <CAHk-=wheeokE5rr_64iS_qnKmzSH4=e2Ds2L3gR_zSH=Cr4F5w@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 17 Jan 2022 06:15:16 +0200")
Message-ID: <87czkqgycl.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n9UCP-0039lU-RD;;;mid=<87czkqgycl.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19WrZnXKf82504GcdKsNKP43XxE9vbC1D4=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [GIT PULL] signal/exit/ptrace changes for v5.17
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Jan 17, 2022 at 6:08 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>>
>> People sometimes think that is just a "poll/select()" thing, but
>> that's not at all true. It's quite valid to do things like
>>
>>         add_wait_queue(..)
>>         for (.. some loop ..) {
>>                 set_current_state(TASK_INTERRUPTIBLE);
>>                 ... do various things, checking state etc ..
>>                schedule();
>>         }
>>         set_current_state(TASK_RUNNABLE);
>>         remove_wait_queue();
>
> Of course, in most modern cases, the above sequence is actually
> encoded as a "wait_event_interruptible()", because we don't generally
> want to open-code the whole thing.

Yes.

What I was looking at that inspired the question is that
"wake_up" ultimately expands to "try_to_wake_up(task, TASK_NORMAL, 0)".

Whereas "wake_up_interruptible" expands to
"try_to_wake_up(task, TASK_INTERRUPTIBLE, 0)".

With the practical challenge that if I want to change
wait_event_interruptible to wait_event_killable I need to change all of
the wakers.

> But the actual end result still ends up being exactly the same, it's
> just syntactically denser and more legible version of the above thing,
> and you can still have the "event" you wait on have nested waiting
> situations.
>
> The nested waiting is by no means common. The only _common_situation
> where you're on multiple wait queues tends to be select/poll kind of
> things, when they aren't really nested as much as iterated over, but
> conceptually the nested case is still quite important, and it allows
> you to do things that a traditional "wait_on()" interface with just
> one single wait-queue just doesn't allow for.

I think it may just be the part of the kernel where I usually work.
Changing wait_event_interruptible to wait_event_killable has always just
worked for me, but it doesn't in the pipe code.

It doesn't because of wake_up_interruptible.

I do know that short-term-disk-sleep aka task_uninterruptible is special
to performing things like disk I/O, and really short term things.

It might just be the names but I look at wake_up_interruptible and my
klaxon's go off in my head saying something doesn't make sense.  So I
will read up and look at those nested wait-queue scenarios and see if I
can find the piece of understanding I am missing.

Eric
