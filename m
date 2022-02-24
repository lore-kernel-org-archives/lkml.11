Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF76DC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 02:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiBXCZc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 21:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiBXCZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:25:30 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E3B22C6CE;
        Wed, 23 Feb 2022 18:25:02 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:38890)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nN3oT-00ASE8-D0; Wed, 23 Feb 2022 19:25:01 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:55894 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nN3oS-004Cj9-JM; Wed, 23 Feb 2022 19:25:01 -0700
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
        <878ru1umcu.fsf@email.froward.int.ebiederm.org>
        <CAM7-yPTPZXPxhtwvvH6KqpRng2idxZiNCLsJHXbWM4ge1wqsBQ@mail.gmail.com>
Date:   Wed, 23 Feb 2022 20:24:54 -0600
In-Reply-To: <CAM7-yPTPZXPxhtwvvH6KqpRng2idxZiNCLsJHXbWM4ge1wqsBQ@mail.gmail.com>
        (Yun Levi's message of "Thu, 24 Feb 2022 09:51:21 +0900")
Message-ID: <87h78pknm1.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nN3oS-004Cj9-JM;;;mid=<87h78pknm1.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Lg3tki/J1nTErPJ3vlLOPCxPazKPvyjQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] fs/exec.c: Avoid a race in formats
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yun Levi <ppbuk5246@gmail.com> writes:

>> Mostly of what has been happening with binary formats lately is code
>> removal.
>>
>> So I humbly suggest the best defense against misuse by modules is to
>> simply remove "EXPORT_SYMBOL(__register_binfmt)".
>
> It could be a solution. but that means the kernel doesn't allow
> dynamic binfmt using modules too.
> I think the best safe way to remove registered binfmt is ...
>
> unregister binfmt list first ---- (1)
> synchronize_rcu_task();
> // tasklist stack-check...
> unload module.
>
> But for this, there shouldn't happen in the above situation of (1).
> If unregister_binfmt has this problem.. I think there is no way to
> unload safely for dynamic registered binfmt via module.

I took a quick look and unregistering in the module exit routine looks
safe, as set_binfmt takes a module reference, and so prevents the module
from being unloaded.

If you can find a bug with existing in-kernel code that would be
interesting.  Otherwise you are making up assumptions that don't current
match the code and saying the code is bugging with respect to
assumptions that do not hold.

The code in the kernel is practical not an implementation of some
abstract that is robust for every possible use case.

Eric
