Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5802FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 23:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbiCOAAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 20:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiCOAAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:00:09 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DA7DFCC;
        Mon, 14 Mar 2022 16:58:58 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:44796)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nTuaW-002q7m-4N; Mon, 14 Mar 2022 17:58:56 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37744 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nTuaU-005KY7-2l; Mon, 14 Mar 2022 17:58:55 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Olivier Langlois <olivier@trillion01.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        io-uring@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <192c9697e379bf084636a8213108be6c3b948d0b.camel@trillion01.com>
        <9692dbb420eef43a9775f425cb8f6f33c9ba2db9.camel@trillion01.com>
        <87h7i694ij.fsf_-_@disp2133>
        <1b519092-2ebf-3800-306d-c354c24a9ad1@gmail.com>
        <b3e43e07c68696b83a5bf25664a3fa912ba747e2.camel@trillion01.com>
        <13250a8d-1a59-4b7b-92e4-1231d73cbdda@gmail.com>
        <878rw9u6fb.fsf@email.froward.int.ebiederm.org>
        <303f7772-eb31-5beb-2bd0-4278566591b0@gmail.com>
Date:   Mon, 14 Mar 2022 18:58:28 -0500
In-Reply-To: <303f7772-eb31-5beb-2bd0-4278566591b0@gmail.com> (Pavel
        Begunkov's message of "Tue, 28 Dec 2021 11:24:56 +0000")
Message-ID: <87ilsg13yz.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nTuaU-005KY7-2l;;;mid=<87ilsg13yz.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/LDPq3+2z3H5H31TkqwIyz8Jul6I65E2g=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC] coredump: Do not interrupt dump for TIF_NOTIFY_SIGNAL
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Begunkov <asml.silence@gmail.com> writes:

> On 12/24/21 19:52, Eric W. Biederman wrote:
>> Pavel Begunkov <asml.silence@gmail.com> writes:
> [...]
>>> FWIW, I worked it around in io_uring back then by breaking the
>>> dependency.
>> I am in the middle of untangling the dependencies between ptrace,
>> coredump, signal handling and maybe a few related things.
>
> Sounds great
>
>> Do folks have a reproducer I can look at?  Pavel especially if you have
>> something that reproduces on the current kernels.
>
> A syz reproducer was triggering it reliably, I'd try to revert the
> commit below and test:
> https://syzkaller.appspot.com/text?tag=ReproC&x=15d3600cb00000
>
> It should hung a task. Syzbot report for reference:
> https://syzkaller.appspot.com/bug?extid=27d62ee6f256b186883e
>
>
> commit 1d5f5ea7cb7d15b9fb1cc82673ebb054f02cd7d2
> Author: Pavel Begunkov <asml.silence@gmail.com>
> Date:   Fri Oct 29 13:11:33 2021 +0100
>
>     io-wq: remove worker to owner tw dependency
>
>     INFO: task iou-wrk-6609:6612 blocked for more than 143 seconds.
>           Not tainted 5.15.0-rc5-syzkaller #0
>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>     task:iou-wrk-6609    state:D stack:27944 pid: 6612 ppid:  6526 flags:0x00004006
>     Call Trace:
>      context_switch kernel/sched/core.c:4940 [inline]
>      __schedule+0xb44/0x5960 kernel/sched/core.c:6287
>      schedule+0xd3/0x270 kernel/sched/core.c:6366
>      schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1857
>      do_wait_for_common kernel/sched/completion.c:85 [inline]
>      __wait_for_common kernel/sched/completion.c:106 [inline]
>      wait_for_common kernel/sched/completion.c:117 [inline]
>      wait_for_completion+0x176/0x280 kernel/sched/completion.c:138
>      io_worker_exit fs/io-wq.c:183 [inline]
>      io_wqe_worker+0x66d/0xc40 fs/io-wq.c:597
>      ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>      ...

Thank you very much for this.  There were some bugs elsewhere I had to
deal with so I am slower looking at this part of the code than I was
expecting.

I have now reproduced this with the commit reverted on current kernels
and the repro.c from the syzcaller report.  I am starting to look into
how this interacts with my planned code changes in this area.

In combination with my other planned changes I think all that needs to
happen in do_coredump is to clear TIF_NOTIFY_SIGNAL along with
TIF_SIGPENDING to prevent io_uring interaction problems.  But we will
see.

The deadlock you demonstrate here shows that it is definitely not enough
to clear TIF_NOTIFY_SIGNAL (without other changes) so that
signal_pending returns false, which I was hoping was be the case.

Eric
