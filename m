Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DABBC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 15:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiBPPWc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:22:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiBPPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:22:30 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A90CF4D3D;
        Wed, 16 Feb 2022 07:22:17 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:59752)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nKM8E-00FUVx-J8; Wed, 16 Feb 2022 08:22:14 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35816 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nKM8D-00AnNX-Kw; Wed, 16 Feb 2022 08:22:14 -0700
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
        <20220211021324.4116773-1-ebiederm@xmission.com>
        <20220214183727.GA10803@blackbody.suse.cz>
Date:   Wed, 16 Feb 2022 09:22:06 -0600
In-Reply-To: <20220214183727.GA10803@blackbody.suse.cz> ("Michal
 =?utf-8?Q?Koutn=C3=BD=22's?=
        message of "Mon, 14 Feb 2022 19:37:27 +0100")
Message-ID: <87bkz6n8f5.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nKM8D-00AnNX-Kw;;;mid=<87bkz6n8f5.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18GHd2u5OO43mJ7g75YNTvv6XIKXa6NCZc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/8] ucounts: Fix RLIMIT_NPROC regression
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Koutný <mkoutny@suse.com> writes:

> On Thu, Feb 10, 2022 at 08:13:17PM -0600, "Eric W. Biederman" <ebiederm@xmission.com> wrote:
>> This can be fixed either by fixing the test or by moving the increment
>> to be before the test.  Fix it my moving copy_creds which contains
>> the increment before is_ucounts_overlimit.
>
> This is simpler than my approach and I find it correct too.
>
>> Both the test in fork and the test in set_user were semantically
>> changed when the code moved to ucounts.  The change of the test in
>> fork was bad because it was before the increment.
>>
>> The test in set_user was wrong and the change to ucounts fixed it.  So
>> this fix is only restore the old behavior in one lcatio not two.
>
> Whom should be the task accounted to in the case of set*uid? (The change
> to ucounts made the check against the pre-switch user's ucounts.)

It needs to be post-switch in the case of set*id().

I have that fixed in the next version of my patchset.

>> ---
>>  kernel/fork.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
