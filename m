Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD33C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jan 2022 19:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244811AbiARTMk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jan 2022 14:12:40 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:34890 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244548AbiARTMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:12:38 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:46696)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9tuF-007YVI-6b; Tue, 18 Jan 2022 12:12:35 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:33802 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9tuE-007hWo-1S; Tue, 18 Jan 2022 12:12:34 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <20211129194707.5863-1-michael.christie@oracle.com>
        <87tuf79gni.fsf@email.froward.int.ebiederm.org>
        <a171238e-d731-1c22-af72-0f7faf7f4bea@oracle.com>
        <87tuf11oe6.fsf@email.froward.int.ebiederm.org>
        <a3bd6fe7-1775-6fdd-3a02-e779c4d4e498@oracle.com>
        <87pmpoxzuf.fsf@email.froward.int.ebiederm.org>
        <783145b7-243b-b85e-e274-44ef6c0696b9@oracle.com>
        <874k62b76d.fsf@email.froward.int.ebiederm.org>
        <68ba89ae-108e-c14a-02a0-db72b169c9b1@oracle.com>
Date:   Tue, 18 Jan 2022 13:12:26 -0600
In-Reply-To: <68ba89ae-108e-c14a-02a0-db72b169c9b1@oracle.com> (Mike
        Christie's message of "Tue, 18 Jan 2022 12:51:27 -0600")
Message-ID: <87a6fs3lk5.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n9tuE-007hWo-1S;;;mid=<87a6fs3lk5.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/xrXBIFZmCO/AVkFA8G1d01MrUM6jLen4=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH V6 01/10] Use copy_process in vhost layer
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie <michael.christie@oracle.com> writes:

> On 1/17/22 11:31 AM, Eric W. Biederman wrote:
>> Mike Christie <michael.christie@oracle.com> writes:
>> 
>>> On 12/22/21 12:24 PM, Eric W. Biederman wrote:
>>>> All I am certain of is that you need to set
>>>> "args->exit_signal = -1;".  This prevents having to play games with
>>>> do_notify_parent.
>>>
>>> Hi Eric,
>>>
>>> I have all your review comments handled except this one. It's looking like it's
>>> more difficult than just setting the exit_signal=-1, so I wanted to check that
>>> I understood you.
>> 
>> [snip problems with exit_signal = -1]
>> 
>>>
>>> What do you think?
>> 
>> I was wrong.  I appear to have confused the thread and the non-thread
>> cases.
>> 
>> Perhaps I meant "args->exit_signal = 0".  That looks like
>> do_notify_parent won't send it, and thread_group_leader continues to do
>> the right thing.
>
> That doesn't work too. exit_notify will call do_notify_parent but 
> our parent, qemu, does not ignore SIGCHILD so we will not drop
> down in into this chunk:
>
>         psig = tsk->parent->sighand;
>         spin_lock_irqsave(&psig->siglock, flags);
>         if (!tsk->ptrace && sig == SIGCHLD &&
>             (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN ||
>              (psig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT))) {
>
> do_notify_parent will return false and so autoreap in exit_notify will
> be false.

Bah good point.  We won't send the signal but you won't autoreap either.

I think we could legitimately change this bit:

	/*
	 * Send with __send_signal as si_pid and si_uid are in the
	 * parent's namespaces.
	 */
	if (valid_signal(sig) && sig)
		__send_signal(sig, &info, tsk->parent, PIDTYPE_TGID, false);

To add:
	else
        	/* We don't notify the parent so just autoreap */
        	autoreap = true;


I expect we could make that change all on it's own, it sort of breaks my
head that requesting not signaling a parent does not also trigger
autoreap behavior.

We certainly need some mechanism to trigger autoreap behavior or the
technical details of being an extra thread of the process need to be
solved.

Eric
