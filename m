Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850FCC3F6B0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jul 2022 16:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbiG0Qsp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jul 2022 12:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbiG0QsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:48:07 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DBB60697
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:32:18 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:42396)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oGjxJ-009L2K-Bb; Wed, 27 Jul 2022 10:32:17 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:47988 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oGjxH-007kF3-TE; Wed, 27 Jul 2022 10:32:16 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
References: <Ys2PwTS0qFmGNFqy@netflix>
        <20220713175305.1327649-1-tycho@tycho.pizza>
        <20220720150328.GA30749@mail.hallyn.com>
        <YthsgqAZYnwHZLn+@tycho.pizza> <20220721015459.GA4297@mail.hallyn.com>
        <YuFdUj5X4qckC/6g@tycho.pizza>
Date:   Wed, 27 Jul 2022 11:32:08 -0500
In-Reply-To: <YuFdUj5X4qckC/6g@tycho.pizza> (Tycho Andersen's message of "Wed,
        27 Jul 2022 09:44:18 -0600")
Message-ID: <871qu6bjp3.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oGjxH-007kF3-TE;;;mid=<871qu6bjp3.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18aPcy1jAAy0mA/ZJLcFWBzs1oaHyQSRLk=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] sched: __fatal_signal_pending() should also check
 PF_EXITING
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tycho Andersen <tycho@tycho.pizza> writes:

> Hi all,
>
> On Wed, Jul 20, 2022 at 08:54:59PM -0500, Serge E. Hallyn wrote:
>> Oh - I didn't either - checking the sigkill in shared signals *seems*
>> legit if they can be put there - but since you posted the new patch I
>> assumed his reasoning was clear to you.  I know Eric's busy, cc:ing Oleg
>> for his interpretation too.
>
> Any thoughts on this?

Having __fatal_signal_pending check SIGKILL in shared signals is
completely and utterly wrong.

What __fatal_signal_pending reports is if a signal has gone through
short cirucuit delivery after determining that the delivery of the
signal will terminate the process.

Using "sigismember(&tsk->pending.signal, SIGKILL)" to report that a
fatal signal has experienced short circuit delivery is a bit of an
abuse, but essentially harmless as tkill of SIGKILL to a thread will
result in every thread in the process experiencing short circuit
delivery of the fatal SIGKILL.  So a pending SIGKILL can't really mean
anything else.



After having looked at the code a little more I can unfortunately also
say that testing PF_EXITING in __fatal_signal_pending will cause
kernel_wait4 in zap_pid_ns_processes to not sleep, and instead to return
0.  Which will cause zap_pid_ns_processes to busy wait.  That seems very
unfortunate.

I hadn't realized it at the time I wrote zap_pid_ns_processes but I
think anything called from do_exit that cares about signal pending state
is pretty much broken and needs to be fixed.



So the question is how do we fix the problem in fuse that shows up
during a pid namespace exit without having interruptible sleeps we need
to wake up?

What are the code paths that experience the problem?

Will refactoring zap_pid_ns_processes as I have proposed so that it does
not use kernel_wait4 help sort this out?  AKA make it work something
like thread group leader of a process and not allow wait to reap the
init process of a pid namespace until all of the processes in a pid
namespaces have been gone.  Not that I see the problem in using
kernel_wait4 it looks like zap_pid_ns_processes needs to stop calling
kernel_wait4 regardless of the fuse problem.

Eric




