Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74E2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 17:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357283AbiBNRpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 12:45:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357242AbiBNRor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:44:47 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385C165491;
        Mon, 14 Feb 2022 09:44:36 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:60360)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nJfOq-009lqi-4z; Mon, 14 Feb 2022 10:44:32 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34362 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nJfOo-00Avjs-Vz; Mon, 14 Feb 2022 10:44:31 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Solar Designer <solar@openwall.com>
Cc:     linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Michal Koutn?? <mkoutny@suse.com>, stable@vger.kernel.org
References: <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
        <20220211021324.4116773-3-ebiederm@xmission.com>
        <20220212231701.GA29483@openwall.com>
        <87ee45wkjq.fsf@email.froward.int.ebiederm.org>
Date:   Mon, 14 Feb 2022 11:43:54 -0600
In-Reply-To: <87ee45wkjq.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Mon, 14 Feb 2022 09:10:49 -0600")
Message-ID: <87tud1s5r9.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nJfOo-00Avjs-Vz;;;mid=<87tud1s5r9.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX184wPQlcnyVPLeSw1arOps4vEB2edMeeyw=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 3/8] ucounts: Fix and simplify RLIMIT_NPROC handling
 during setuid()+execve
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Solar Designer <solar@openwall.com> writes:
>
>> On Thu, Feb 10, 2022 at 08:13:19PM -0600, Eric W. Biederman wrote:
>>> As of commit 2863643fb8b9 ("set_user: add capability check when
>>> rlimit(RLIMIT_NPROC) exceeds") setting the flag to see if execve
>>> should check RLIMIT_NPROC is buggy, as it tests the capabilites from
>>> before the credential change and not aftwards.
>>> 
>>> As of commit 21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of
>>> ucounts") examining the rlimit is buggy as cred->ucounts has not yet
>>> been properly set in the new credential.
>>> 
>>> Make the code correct and more robust moving the test to see if
>>> execve() needs to test RLIMIT_NPROC into commit_creds, and defer all
>>> of the rest of the logic into execve() itself.
>>> 
>>> As the flag only indicateds that RLIMIT_NPROC should be checked
>>> in execve rename it from PF_NPROC_EXCEEDED to PF_NPROC_CHECK.
>>> 
>>> Cc: stable@vger.kernel.org
>>> Link: https://lkml.kernel.org/r/20220207121800.5079-2-mkoutny@suse.com
>>> Link: https://lkml.kernel.org/r/20220207121800.5079-3-mkoutny@suse.com
>>> Reported-by: Michal Koutn?? <mkoutny@suse.com>
>>> Fixes: 2863643fb8b9 ("set_user: add capability check when rlimit(RLIMIT_NPROC) exceeds")
>>> Fixes: 21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of ucounts")
>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>
>> On one hand, this looks good.
>>
>> On the other, you asked about the Apache httpd suexec scenario in the
>> other thread, and here's what this means for it (per my code review):
>>
>> In that scenario, we have two execve(): first from httpd to suexec, then
>> from suexec to the CGI script.  Previously, the limit check only
>> occurred on the setuid() call by suexec, and its effect was deferred
>> until execve() of the script.  Now wouldn't it occur on both execve()
>> calls, because commit_creds() is also called on execve() (such as in
>> case the program is SUID, which suexec actually is)?
>
> Yes.  Moving the check into commit_creds means that the exec after a
> suid exec will perform an RLIMIT_NPROC check and could possibly fail.  I
> would call that a bug.  Anything happening in execve should be checked
> and handled in execve as execve can fail.
>
> It also points out that our permission checks for increasing
> RLIMIT_NPROC are highly inconsistent.
>
> One set of permissions in fork().
> Another set of permissions in set*id() and delayed until execve.
> No permission checks for the uid change in execve.
>
> Every time I look into the previous behavior of RLIMIT_NPROC I seem
> to find issues.  Currently I am planning a posting to linux-api
> so sorting out what when RLIMIT_NPROC should be enforced and how
> RLIMIT_NPROC gets accounted receives review.  I am also planning a
> feature branch to deal with the historical goofiness.
>
> I really like how cleanly this patch seems to be.  Unfortunately it is
> wrong.

Hmm.  Maybe not as wrong as I thought.  An suid execve does not change
the real user.

Still a bit wrong from a conservative change point of view because the
user namespace can change in setns and CLONE_NEWUSER which will change
the accounting now.  Which with the ucount rlimit stuff changes where
things should be accounted.

I am playing with the idea of changing accounting aka (cred->ucounts &
cred->user) to only change in fork (aka clone without CLONE_THREAD) and
exec.  I think that would make maintenance and  cleaning all of this up
easier.

That would also remove serious complications from RLIMIT_SIGPENDING as
well.

I thought SIGPENDING was only a multi-threaded process issue but from
one signal to the next the set*id() family functions can be called.

Eric
