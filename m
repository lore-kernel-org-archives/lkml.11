Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE4AC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 21:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiFWVzP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 17:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFWVzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:55:14 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4AA62717
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:55:13 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:43430)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o4UnA-00DKAU-BD; Thu, 23 Jun 2022 15:55:12 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57448 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o4Un9-005Q2k-D8; Thu, 23 Jun 2022 15:55:11 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Robert O'Callahan" <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Keno Fischer <keno@juliacomputing.com>
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
        <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org>
        <YrSC8AxEV24IgSbm@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Date:   Thu, 23 Jun 2022 16:55:05 -0500
In-Reply-To: <YrSC8AxEV24IgSbm@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
        (Alexander Gordeev's message of "Thu, 23 Jun 2022 17:12:48 +0200")
Message-ID: <87ilor9hae.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o4Un9-005Q2k-D8;;;mid=<87ilor9hae.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX193XSh3Yh8PwqT2/ZUtV4oKP1cRYdjigzI=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 0/3] ptrace: Stop supporting SIGKILL for PTRACE_EVENT_EXIT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Gordeev <agordeev@linux.ibm.com> writes:

> On Wed, Jun 22, 2022 at 11:43:37AM -0500, Eric W. Biederman wrote:
>> Recently I had a conversation where it was pointed out to me that
>> SIGKILL sent to a tracee stropped in PTRACE_EVENT_EXIT is quite
>> difficult for a tracer to handle.
>> 
>> Keeping SIGKILL working for anything after the process has been killed
>> is also a real pain from an implementation point of view.
>> 
>> So I am attempting to remove this wart in the userspace API and see
>> if anyone cares.
>
> Hi Eric,
>
> With this series s390 hits the warning exactly same way. Is that expected?

Yes.  I was working on this before I got your mysterious bug report.  I
included you because I am including everyone I know who deals with the
userspace side of this since I am very deliberately changing the user
visible behavior of PTRACE_EVENT_EXIT.

I am going to start seeing if I can find any possible explanation for
your regression report.  Since I don't have much to go on I expect I
will have to revert the last change in my ptrace_stop series that
apparently triggers the WARN_ON you reported.  I really would have
expected the WARN_ON to be triggered in the patch in which it was
introduced, not the final patch in the series.


To the best of my knowledge changing PTRACE_EVENT_EXIT is both desirable
from a userspace semantics standpoint and from a kernel implementation
standpoint.  If someone knows any differently and depends upon sending
SIGKILL to processes in PTRACE_EVENT_EXIT to steal the process away from
the tracer I would love to hear about that case.

Eric

