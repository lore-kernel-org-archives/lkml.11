Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4F8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 17:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352350AbiBKRvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Feb 2022 12:51:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352338AbiBKRvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:51:00 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E68CD5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:50:59 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:46566)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nIa4M-00DWVf-UO; Fri, 11 Feb 2022 10:50:54 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:47806 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nIa4L-009ZGG-PP; Fri, 11 Feb 2022 10:50:54 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        containers@lists.linux-foundation.org,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
References: <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
        <20220211021324.4116773-6-ebiederm@xmission.com>
        <20220211113454.socmlrne5heux7q7@example.org>
Date:   Fri, 11 Feb 2022 11:50:46 -0600
In-Reply-To: <20220211113454.socmlrne5heux7q7@example.org> (Alexey Gladkov's
        message of "Fri, 11 Feb 2022 12:34:54 +0100")
Message-ID: <87sfspz409.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nIa4L-009ZGG-PP;;;mid=<87sfspz409.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+5NZOYvFHMyiJziNe9v0dW5vlnbSAVvWo=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 6/8] ucounts: Handle inc_rlimit_ucounts wrapping in fork
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <legion@kernel.org> writes:

> On Thu, Feb 10, 2022 at 08:13:22PM -0600, Eric W. Biederman wrote:
>> Move inc_rlimit_ucounts from copy_creds into copy_process immediately
>> after copy_creds where it can be called exactly once.  Test for and
>> handle it when inc_rlimit_ucounts returns LONG_MAX indicating the
>> count has wrapped.
>> 
>> This is good hygenine and fixes a theoretical bug.  In practice
>> PID_MAX_LIMIT is at most 2^22 so there is not a chance the number of
>> processes would ever wrap even on an architecture with a 32bit long.
>> 
>> Fixes: 21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of ucounts")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  kernel/cred.c | 2 --
>>  kernel/fork.c | 2 ++
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/kernel/cred.c b/kernel/cred.c
>> index 229cff081167..96d5fd6ff26f 100644
>> --- a/kernel/cred.c
>> +++ b/kernel/cred.c
>> @@ -358,7 +358,6 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
>>  		kdebug("share_creds(%p{%d,%d})",
>>  		       p->cred, atomic_read(&p->cred->usage),
>>  		       read_cred_subscribers(p->cred));
>> -		inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
>>  		return 0;
>>  	}
>>  
>> @@ -395,7 +394,6 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
>>  #endif
>>  
>>  	p->cred = p->real_cred = get_cred(new);
>> -	inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
>>  	alter_cred_subscribers(new, 2);
>>  	validate_creds(new);
>>  	return 0;
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 6f62d37f3650..69333078259c 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -2026,6 +2026,8 @@ static __latent_entropy struct task_struct *copy_process(
>>  		goto bad_fork_free;
>>  
>>  	retval = -EAGAIN;
>> +	if (inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1) == LONG_MAX)
>> +		goto bad_fork_cleanup_count;
>>  	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
>>  		if ((task_ucounts(p) != &init_ucounts) &&
>>  		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
>
> It might make sense to do something like:
>
> 	if (inc_rlimit_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1, rlimit(RLIMIT_NPROC)) == LONG_MAX) {
> 		if ((task_ucounts(p) != &init_ucounts) &&
> 		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
>
> and the new function:
>
> long inc_rlimit_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, long v, unsigned long rlimit)
> {
> 	struct ucounts *iter;
> 	long ret = 0;
> 	long max = rlimit;
> 	if (rlimit > LONG_MAX)
> 		max = LONG_MAX;
> 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
> 		long new = atomic_long_add_return(v, &iter->ucount[type]);
> 		if (new < 0 || new > max)
> 			ret = LONG_MAX;
> 		else if (iter == ucounts)
> 			ret = new;
> 		max = READ_ONCE(iter->ns->ucount_max[type]);
> 	}
> 	return ret;
> }
>
> This will avoid double checking the same userns tree.
>
> Or even modify inc_rlimit_ucounts. This function is used elsewhere like
> this:
>
>
> msgqueue = inc_rlimit_ucounts(info->ucounts, UCOUNT_RLIMIT_MSGQUEUE, mq_bytes);
> if (msgqueue == LONG_MAX || msgqueue > rlimit(RLIMIT_MSGQUEUE)) {
>
>
> memlock = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
> if (!allowed && (memlock == LONG_MAX || memlock > lock_limit) && !capable(CAP_IPC_LOCK)) {
>
>
> In all cases, we have max value for comparison.

Good point.   The downside is that it means we can't use the same code
in exec.  The upside is that the code is more idiomatic.

Eric

