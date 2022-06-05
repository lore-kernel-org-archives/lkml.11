Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6616AC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jun 2022 22:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348268AbiFEWLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jun 2022 18:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbiFEWLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:11:35 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBAB4DF7F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 15:11:34 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37948)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nxyT6-00C2pP-7e; Sun, 05 Jun 2022 16:11:32 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:41754 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nxyT5-004SZw-BA; Sun, 05 Jun 2022 16:11:31 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Linux Containers <containers@lists.linux.dev>
References: <875ylh8xxx.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wh0ZYiQuCJmohyYpk99mch=Nb+_m4DWxBX03DQWnsvCZA@mail.gmail.com>
Date:   Sun, 05 Jun 2022 17:11:07 -0500
In-Reply-To: <CAHk-=wh0ZYiQuCJmohyYpk99mch=Nb+_m4DWxBX03DQWnsvCZA@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 3 Jun 2022 15:59:33 -0700")
Message-ID: <87tu8y69s4.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nxyT5-004SZw-BA;;;mid=<87tu8y69s4.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/IcMM5ic1t771lZP5L72ecB8LyxksRPPU=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [GIT PULL] ipc: per namespace ipc sysctl changes for v5.19
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Jun 3, 2022 at 10:21 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> These changes were sent for v5.18[1] but were dropped because some
>> additional cleanups were requested.  Linus has given his nod[2] to the
>> cleanups so I hope enough cleanups are present this time.
>
> Well, I'll be happier still when the next set of cleanups hits:
>
>    https://lore.kernel.org/all/CAHk-=wjJ2CP0ugbOnwAd-=Cw0i-q_xC1PbJ-_1jrvR-aisiAAA@mail.gmail.com/
>
> but yeah, that further cleanup series clearly wasn't quite ready yet.

Yes.  It came in during the merge window.  I have been keeping a weather
eye on it but I really haven't had a chance to look yet.

Eric
