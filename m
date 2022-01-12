Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213E3C4332F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jan 2022 16:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355299AbiALQnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jan 2022 11:43:04 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:43080 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349822AbiALQnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:43:03 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:49380)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n7giC-008Sxe-NA; Wed, 12 Jan 2022 09:43:00 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:41266 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n7giB-005CcX-Bl; Wed, 12 Jan 2022 09:43:00 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>,
        linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev,
        containers@lists.linux.dev, Sven Schnelle <svens@linux.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
References: <CA+G9fYsMHhXJCgO-ykR0oO1kVdusGnthgj6ifxEKaGPHZJ-ZCw@mail.gmail.com>
        <20220112131837.igsjkkttqskw4eix@wittgenstein>
        <CADYN=9Lvm-1etZS817eZK91NUyxkFBmsu=5-q_8Ei-1eV8DuZQ@mail.gmail.com>
        <20220112140254.cvngcwggeevwaazw@wittgenstein>
        <20220112141445.txgrdlycvfkiwsv5@example.org>
        <20220112142846.3b3m2dyhdtppgwrw@example.org>
        <CADYN=9LBjp0=mqyPkTGmdeMx52cg4pM39fnXe-ODTZ=_1OP+zw@mail.gmail.com>
Date:   Wed, 12 Jan 2022 10:42:32 -0600
In-Reply-To: <CADYN=9LBjp0=mqyPkTGmdeMx52cg4pM39fnXe-ODTZ=_1OP+zw@mail.gmail.com>
        (Anders Roxell's message of "Wed, 12 Jan 2022 16:56:27 +0100")
Message-ID: <87v8yoq51j.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n7giB-005CcX-Bl;;;mid=<87v8yoq51j.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19xVjhWaZhYL0/HgEx+P4VRuQZTUh+RHAs=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [next]: LTP: getxattr05.c:97: TFAIL: unshare(CLONE_NEWUSER)
 failed: ENOSPC (28)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Roxell <anders.roxell@linaro.org> writes:

> On Wed, 12 Jan 2022 at 15:28, Alexey Gladkov <legion@kernel.org> wrote:
>>
>> On Wed, Jan 12, 2022 at 03:14:45PM +0100, Alexey Gladkov wrote:
>> > On Wed, Jan 12, 2022 at 03:02:54PM +0100, Christian Brauner wrote:
>> > > On Wed, Jan 12, 2022 at 02:22:42PM +0100, Anders Roxell wrote:
>> > > > On Wed, 12 Jan 2022 at 14:18, Christian Brauner
>> > > > <christian.brauner@ubuntu.com> wrote:
>> > > > >
>> > > > > On Wed, Jan 12, 2022 at 05:15:37PM +0530, Naresh Kamboju wrote:
>> > > > > > While testing LTP syscalls with Linux next 20220110 (and till date 20220112)
>> > > > > > on x86_64, i386, arm and arm64 the following tests failed.
>> > > > > >
>> > > > > > tst_test.c:1365: TINFO: Timeout per run is 0h 15m 00s
>> > > > > > getxattr05.c:87: TPASS: Got same data when acquiring the value of
>> > > > > > system.posix_acl_access twice
>> > > > > > getxattr05.c:97: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
>> > > > > > tst_test.c:391: TBROK: Invalid child (13545) exit value 1
>> > > > > >
>> > > > > > fanotify17.c:176: TINFO: Test #1: Global groups limit in privileged user ns
>> > > > > > fanotify17.c:155: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
>> > > > > > tst_test.c:391: TBROK: Invalid child (14739) exit value 1
>> > > > > >
>> > > > > > sendto03.c:48: TBROK: unshare(268435456) failed: ENOSPC (28)
>> > > > > >
>> > > > > > setsockopt05.c:45: TBROK: unshare(268435456) failed: ENOSPC (28)
>> > > > > >
>> > > > > > strace output:
>> > > > > > --------------
>> > > > > > [pid   481] wait4(-1, 0x7fff52f5ae8c, 0, NULL) = -1 ECHILD (No child processes)
>> > > > > > [pid   481] clone(child_stack=NULL,
>> > > > > > flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
>> > > > > > child_tidptr=0x7f3af0fa7a10) = 483
>> > > > > > strace: Process 483 attached
>> > > > > > [pid   481] wait4(-1,  <unfinished ...>
>> > > > > > [pid   483] unshare(CLONE_NEWUSER)      = -1 ENOSPC (No space left on device)
>> > > > >
>> > > > > This looks like another regression in the ucount code. Reverting the
>> > > > > following commit fixes it and makes the getxattr05 test work again:
>> > > > >
>> > > > > commit 0315b634f933b0f12cfa82660322f6186c1aa0f4
>> > > > > Author: Alexey Gladkov <legion@kernel.org>
>> > > > > Date:   Fri Dec 17 15:48:23 2021 +0100
>> > > > >
>> > > > >     ucounts: Split rlimit and ucount values and max values
>> > > > >
>> > > > >     Since the semantics of maximum rlimit values are different, it would be
>> > > > >     better not to mix ucount and rlimit values. This will prevent the error
>> > > > >     of using inc_count/dec_ucount for rlimit parameters.
>> > > > >
>> > > > >     This patch also renames the functions to emphasize the lack of
>> > > > >     connection between rlimit and ucount.
>> > > > >
>> > > > >     v2:
>> > > > >     - Fix the array-index-out-of-bounds that was found by the lkp project.
>> > > > >
>> > > > >     Reported-by: kernel test robot <oliver.sang@intel.com>
>> > > > >     Signed-off-by: Alexey Gladkov <legion@kernel.org>
>> > > > >     Link: https://lkml.kernel.org/r/73ea569042babda5cee2092423da85027ceb471f.1639752364.git.legion@kernel.org
>> > > > >     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>> > > > >
>> > > > > The issue only surfaces if /proc/sys/user/max_user_namespaces is
>> > > > > actually written to.
>> > > >
>> > > > I did a git bisect and that pointed me to this patch too.
>> > >
>> > > Uhm, doesn't this want to be:
>> >
>> > Yes. I miss it. I tried not to mix the logic, but I myself stepped on this
>> > problem.
>>
>> It should be fixed in the four places:
>>
>> diff --git a/kernel/ucount.c b/kernel/ucount.c
>> index 22070f004e97..5c373a453f43 100644
>> --- a/kernel/ucount.c
>> +++ b/kernel/ucount.c
>> @@ -264,7 +264,7 @@ long inc_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v)
>>         long ret = 0;
>>
>>         for (iter = ucounts; iter; iter = iter->ns->ucounts) {
>> -               long new = atomic_long_add_return(v, &iter->ucount[type]);
>> +               long new = atomic_long_add_return(v, &iter->rlimit[type]);
>>                 if (new < 0 || new > max)
>>                         ret = LONG_MAX;
>>                 else if (iter == ucounts)
>> @@ -279,7 +279,7 @@ bool dec_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v)
>>         struct ucounts *iter;
>>         long new = -1; /* Silence compiler warning */
>>         for (iter = ucounts; iter; iter = iter->ns->ucounts) {
>> -               long dec = atomic_long_sub_return(v, &iter->ucount[type]);
>> +               long dec = atomic_long_sub_return(v, &iter->rlimit[type]);
>>                 WARN_ON_ONCE(dec < 0);
>>                 if (iter == ucounts)
>>                         new = dec;
>> @@ -292,7 +292,7 @@ static void do_dec_rlimit_put_ucounts(struct ucounts *ucounts,
>>  {
>>         struct ucounts *iter, *next;
>>         for (iter = ucounts; iter != last; iter = next) {
>> -               long dec = atomic_long_sub_return(1, &iter->ucount[type]);
>> +               long dec = atomic_long_sub_return(1, &iter->rlimit[type]);
>>                 WARN_ON_ONCE(dec < 0);
>>                 next = iter->ns->ucounts;
>>                 if (dec == 0)
>> @@ -313,7 +313,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
>>         long dec, ret = 0;
>>
>>         for (iter = ucounts; iter; iter = iter->ns->ucounts) {
>> -               long new = atomic_long_add_return(1, &iter->ucount[type]);
>> +               long new = atomic_long_add_return(1, &iter->rlimit[type]);
>>                 if (new < 0 || new > max)
>>                         goto unwind;
>>                 if (iter == ucounts)
>> @@ -330,7 +330,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
>>         }
>>         return ret;
>>  dec_unwind:
>> -       dec = atomic_long_sub_return(1, &iter->ucount[type]);
>> +       dec = atomic_long_sub_return(1, &iter->rlimit[type]);
>>         WARN_ON_ONCE(dec < 0);
>>  unwind:
>>         do_dec_rlimit_put_ucounts(ucounts, iter, type);
>>
>
> Thank you for the fix.
> I applied this patch and built and ran it in qemu for arm64 and x86.
> './runltp -s getxattr05' passed on both architectures.
>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thank you all.

For now I have dropped this from linux-next.  I will add the fix and
will aim to get this cleanup in the next merge window.

Eric
