Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E3BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 15:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiBPPmK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:42:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbiBPPmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:42:09 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294B420194;
        Wed, 16 Feb 2022 07:41:55 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:35538)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nKMRF-001lC2-LD; Wed, 16 Feb 2022 08:41:53 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36692 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nKMRD-002TMw-GQ; Wed, 16 Feb 2022 08:41:53 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        containers@lists.linux-foundation.org, stable@vger.kernel.org
References: <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
        <20220211021324.4116773-4-ebiederm@xmission.com>
        <20220215105442.GF21589@blackbody.suse.cz>
Date:   Wed, 16 Feb 2022 09:41:44 -0600
In-Reply-To: <20220215105442.GF21589@blackbody.suse.cz> ("Michal
 =?utf-8?Q?Koutn=C3=BD=22's?=
        message of "Tue, 15 Feb 2022 11:54:42 +0100")
Message-ID: <87ee42kedj.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nKMRD-002TMw-GQ;;;mid=<87ee42kedj.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+xvcr2Ikvz83sQhp/phNRB12Ed4GEsqJs=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 4/8] ucounts: Only except the root user in init_user_ns
 from RLIMIT_NPROC
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Koutný <mkoutny@suse.com> writes:

> On Thu, Feb 10, 2022 at 08:13:20PM -0600, "Eric W. Biederman" <ebiederm@xmission.com> wrote:
>> @@ -1881,7 +1881,7 @@ static int do_execveat_common(int fd, struct filename *filename,
> [...]
>> -	    (current_user() != INIT_USER) &&
>> +	    (current_ucounts() != &init_ucounts) &&
> [...]
>> @@ -2027,7 +2027,7 @@ static __latent_entropy struct task_struct *copy_process(
> [...]
>> -		if (p->real_cred->user != INIT_USER &&
>> +		if ((task_ucounts(p) != &init_ucounts) &&
>
> These substitutions make sense to me.
>
>>  		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
>>  			goto bad_fork_cleanup_count;
>>  	}
>> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>> index 6b2e3ca7ee99..f0c04073403d 100644
>> --- a/kernel/user_namespace.c
>> +++ b/kernel/user_namespace.c
>> @@ -123,6 +123,8 @@ int create_user_ns(struct cred *new)
>>  		ns->ucount_max[i] = INT_MAX;
>>  	}
>>  	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
>> +	if (new->ucounts == &init_ucounts)
>> +		set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, RLIMIT_INFINITY);
>>  	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
>>  	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_SIGPENDING, rlimit(RLIMIT_SIGPENDING));
>>  	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MEMLOCK, rlimit(RLIMIT_MEMLOCK));
>
> First, I wanted to object this double fork_init() but I realized it's
> relevant for newly created user_ns.
>
> Second, I think new->ucounts would be correct at this point and the
> check should be
>
>> if (ucounts == &init_ucounts)
>
> i.e. before set_cred_ucounts() new->ucounts may not be correct.
>
> I'd suggest also a comment in the create_user_ns() explaining the
> reason is to exempt global root from RLIMINT_NRPOC also indirectly via
> descendant user_nss.

Yes.

This one got culled from my next version of the patchset as it is not
conservative enough.  I think it is probably the right general
direction.

On further reflection I am not convinced that it makes sense to test
user or ucounts.  They are really not fields designed to support
permission checks.

I think if we want to exempt the root user's children from the root
users rlimit using the second set_rlimit_ucount_max is the way to go.

Someone filed a bug that strongly suggests that we want the second
set_rlimit_ucount_max:
https://bugzilla.kernel.org/show_bug.cgi?id=215596

I am still trying to understand that case. 

Eric
