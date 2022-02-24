Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E94C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 00:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiBXAnH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiBXAnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:43:05 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA67D24F1D;
        Wed, 23 Feb 2022 16:42:31 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:45334)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nN2D6-00GEzI-QL; Wed, 23 Feb 2022 17:42:23 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:51728 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nN2D4-003rP5-OE; Wed, 23 Feb 2022 17:42:20 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220223231752.52241-1-ppbuk5246@gmail.com>
        <YhbCGDzlTWp2OJzI@zeniv-ca.linux.org.uk>
        <CAM7-yPTM6FNuT4vs2EuKAKitTWMTHw_XzKVggxQJzn5hqbBHpw@mail.gmail.com>
        <CAM7-yPSk35UoGmRY_rCo2=RryBvwbQEjeWfL2tz1ADUosCXNjw@mail.gmail.com>
Date:   Wed, 23 Feb 2022 18:41:53 -0600
In-Reply-To: <CAM7-yPSk35UoGmRY_rCo2=RryBvwbQEjeWfL2tz1ADUosCXNjw@mail.gmail.com>
        (Yun Levi's message of "Thu, 24 Feb 2022 09:10:43 +0900")
Message-ID: <878ru1umcu.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nN2D4-003rP5-OE;;;mid=<878ru1umcu.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19E7m5cfdNbK2Kadeox25wwXYPVTo6knKU=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] fs/exec.c: Avoid a race in formats
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yun Levi <ppbuk5246@gmail.com> writes:

> On Thu, Feb 24, 2022 at 8:59 AM Yun Levi <ppbuk5246@gmail.com> wrote:
>>
>> On Thu, Feb 24, 2022 at 8:24 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>> >
>> > On Thu, Feb 24, 2022 at 08:17:52AM +0900, Levi Yun wrote:
>> > > Suppose a module registers its own binfmt (custom) and formats is like:
>> > >
>> > > +---------+    +----------+    +---------+
>> > > | custom  | -> |  format1 | -> | format2 |
>> > > +---------+    +----------+    +---------+
>> > >
>> > > and try to call unregister_binfmt with custom NOT in __exit stage.
>> >
>> > Explain, please.  Why would anyone do that?  And how would such
>> > module decide when it's safe to e.g. dismantle data structures
>> > used by methods of that binfmt, etc.?
>> > Could you give more detailed example?
>>
>> I think if someone wants to control their own binfmt via "ioctl" not
>> on time on LOAD.
>> For example, someone wants to control exec (notification,
>> allow/disallow and etc..)
>> and want to enable and disable own's control exec via binfmt reg / unreg
>> In that situation, While the module is loaded, binfmt is still live
>> and can be reused by
>> reg/unreg to enable/disable his exec' control.
>>
>> module can decide it's safe to unload by tracing the stack and
>> confirming whether some tasks in the custom binfmt's function after it
>> unregisters its own binfmt.
>>
>> > Because it looks like papering over an inherently unsafe use of binfmt interfaces..
>>
>> I think the above example it's quite a trick and stupid.  it's quite
>> unsafe to use as you mention.
>> But, misuse allows that situation to happen without any warning.
>> As a robustness, I just try to avoid above situation But,
>> I think it's better to restrict unregister binfmt unregister only when
>> there is no module usage.
>
> And not only stupid exmaple,
> if someone loadable custom binfmt register in __init and __exit via
> register and unregister_binfmt,
> I think that situation could happen.

Mostly of what has been happening with binary formats lately is code
removal.

So I humbly suggest the best defense against misuse by modules is to
simply remove "EXPORT_SYMBOL(__register_binfmt)".

Eric
