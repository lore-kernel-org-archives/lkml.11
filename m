Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B86C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 15:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbiCVPGR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 11:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiCVPGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:06:12 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BD08149C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:04:44 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:44330)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nWg3u-00BAWb-CC; Tue, 22 Mar 2022 09:04:42 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38952 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nWg3t-00C8Tj-8m; Tue, 22 Mar 2022 09:04:41 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Tony Battersby <tonyb@cybernetics.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Olivier Langlois <olivier@trillion01.com>
References: <76d3418c-e9ba-4392-858a-5da8028e3526@kernel.dk>
        <CAHk-=wgBMNC1ePTgqM6f0iBH94KE5_oHQYD2sqCbjev0KaZ6Kw@mail.gmail.com>
        <7fb2d8a6-951c-092c-ccaa-15522ae2ed01@kernel.dk>
        <6d8b3c24-12d1-043f-aec8-cfdc5b2e2786@cybernetics.com>
Date:   Tue, 22 Mar 2022 10:04:33 -0500
In-Reply-To: <6d8b3c24-12d1-043f-aec8-cfdc5b2e2786@cybernetics.com> (Tony
        Battersby's message of "Mon, 21 Mar 2022 14:20:50 -0400")
Message-ID: <874k3qxc3i.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nWg3t-00C8Tj-8m;;;mid=<874k3qxc3i.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18h5W458lQKuQY5dUtBaAoDKfXLK/PUHhU=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] kernel: make TIF_NOTIFY_SIGNAL and core dumps co-exist
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Battersby <tonyb@cybernetics.com> writes:

> On 8/19/21 10:59, Jens Axboe wrote:
>> On 8/18/21 8:57 PM, Linus Torvalds wrote:
>>> On Tue, Aug 17, 2021 at 8:06 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>> task_work being added with notify == TWA_SIGNAL will utilize
>>>> TIF_NOTIFY_SIGNAL for signaling the targeted task that work is available.
>>>> If this happens while a task is going through a core dump, it'll
>>>> potentially disturb and truncate the dump as a signal interruption.
>>> This patch seems (a) buggy and (b) hacky.
>>>
>>>> --- a/kernel/task_work.c
>>>> +++ b/kernel/task_work.c
>>>> @@ -41,6 +41,12 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
>>>>                 head = READ_ONCE(task->task_works);
>>>>                 if (unlikely(head == &work_exited))
>>>>                         return -ESRCH;
>>>> +               /*
>>>> +                * TIF_NOTIFY_SIGNAL notifications will interfere with
>>>> +                * a core dump in progress, reject them.
>>>> +                */
>>>> +               if (notify == TWA_SIGNAL && (task->flags & PF_SIGNALED))
>>>> +                       return -ESRCH;
>>> This basically seems to check task->flags with no serialization.
>>>
>>> I'm sure it works 99.9% of the time in practice, since you'd be really
>>> unlucky to hit any races, but I really don't see what the
>>> serialization logic is.
>>>
>>> Also, the main user that actually triggered the problem already has
>>>
>>>         if (unlikely(tsk->flags & PF_EXITING))
>>>                 goto fail;
>>>
>>> just above the call to task_work_add(), so this all seems very hacky indeed.
>>>
>>> Of course, I don't see what the serialization for _that_ one is either.
>>>
>>> Pls explain. You can't just randomly add tests for random flags that
>>> get modified by other random code.
>> You're absolutely right. On the io_uring side, in the current tree,
>> there's only one check where current != task being checked - and that's
>> in the poll rewait arming. That one should likely just go away. It may
>> be fine as it is, as it just pertains to ring exit cancelations. We want
>> to ensure that we don't rearm poll requests if the process is canceling
>> and going away. I'll take a closer look at that one.
>>
>> For this particular patch, I agree it's racy. I'll see if I can come up
>> with something better...
>>
>
> Continuing this thread from August 2021:
>
> I previously tested a version of Jens' patch backported to 5.10 and it
> fixed my problem.  Now I am trying to upgrade kernels, and 5.17 still
> has the same problem - coredumps from an io_uring program to a pipe are
> truncated.  Jens' patch applied to 5.17 again fixes the problem.  Has
> there been any progress with fixing the problem upstream?
>
> Reference:
>
> https://lore.kernel.org/all/8af373ec-9609-35a4-f185-f9bdc63d39b7@cybernetics.com/
> https://lore.kernel.org/all/76d3418c-e9ba-4392-858a-5da8028e3526@kernel.dk/

I am still slowly working on this.  (I was unfortunately preempted by
some painful to track down and fix regressions elsewhere).

When I was doubly checking to be certain I understood the problem the
case you describe is one of the easy cases that needs to be handled.

There is at least one more difficult interaction that is not solved by
squelching task_work_add after PF_SIGNALED is set, and I am not 100%
convinced that it is even correct to squelch task_work_add at that point
in the code.

The progress I have made to date that I am sending to Linus for v5.18 is
the removal of tracehook.h which makes the code much more
understandable.

I think I have a general solution that I am planning to post after
v5.18-rc1 that I have not tested yet on the cases that I know about,
but I expect it will work.

So I think that puts a good general fix 2-3 weeks out.

This is quite possibly a case where perfection is getting in the way of
the good, but I honestly can't judge anything except a fix that cleans
up everything and is complete.  There are too many weird and subtle
interactions that I don't understand.

So I am going to continue concentrating on a good general solution so
that the code is readable and makes sense.

Eric

