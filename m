Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B88AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 22:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386248AbiBHWhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388500AbiBHWdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 17:33:02 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06373C01CB14
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 14:25:12 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:50410)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nHYv9-00DAOc-CY; Tue, 08 Feb 2022 15:25:11 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:41898 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nHYv7-00CSCi-GT; Tue, 08 Feb 2022 15:25:10 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Waiman Long <longman@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Gladkov <legion@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
References: <20220208163912.1084752-1-longman@redhat.com>
        <YgKziblMKsmHkP4f@zeniv-ca.linux.org.uk>
        <bd83aca3-059f-92dd-e094-b27f51f9481a@redhat.com>
        <YgK/fdYWi0wWysci@zeniv-ca.linux.org.uk>
        <874k59f2ad.fsf@email.froward.int.ebiederm.org>
        <YgLr2GEXgz/TxdUA@zeniv-ca.linux.org.uk>
Date:   Tue, 08 Feb 2022 16:25:02 -0600
In-Reply-To: <YgLr2GEXgz/TxdUA@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Tue, 8 Feb 2022 22:16:56 +0000")
Message-ID: <87czjxdmip.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nHYv7-00CSCi-GT;;;mid=<87czjxdmip.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX182oeJyc/2QUC0MDFcVTea6z+qieDuOmFk=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] copy_process(): Move fd_install() out of
 sighand->siglock critical section
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Tue, Feb 08, 2022 at 03:59:06PM -0600, Eric W. Biederman wrote:
>
>> The fd is being installed in the fdtable of the parent process,
>> and the siglock and tasklist_lock are held to protect the child.
>> 
>> 
>> Further fd_install is exposing the fd to userspace where it can be used
>> by the process_madvise and the process_mrelease system calls, from
>> anything that shares the fdtable of the parent thread.  Which means it
>> needs to be guaranteed that kernel_clone will call wake_up_process
>> before it is safe to call fd_install.
>
> You mean "no calling fd_install() until after we are past the last possible
> failure exit, by which point we know that wake_up_process() will eventually
> be called", hopefully?  If so (as I assumed all along), anything downstream
> of
>         if (fatal_signal_pending(current)) {
> 		retval = -EINTR;
> 		goto bad_fork_cancel_cgroup;
> 	}
>
> should be fine...

Except for the problems of calling fd_install under siglock, and
tasklist_lock, which protect nothing and cause lockdep splats.

There may also be assumptions on the task actually being fully setup,
if not today then in a future use pidfd.  So I am not particularly
comfortable with fd_install coming before we drop tasklist_lock.

I was pointing out that to resolve the locking issue we fundamentally
can not move the fd_install earlier, to resolve the locking issues.

Eric
