Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44044C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 22:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbiGHWZn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 18:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbiGHWZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:25:41 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD0FA2E61
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 15:25:40 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:59826)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o9wPq-004o3a-Ov; Fri, 08 Jul 2022 16:25:38 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:43408 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o9wPp-00AEXn-O8; Fri, 08 Jul 2022 16:25:38 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        bigeasy@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Robert O'Callahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Oleg Nesterov <oleg@redhat.com>
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
        <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org>
Date:   Fri, 08 Jul 2022 17:25:31 -0500
In-Reply-To: <87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Wed, 22 Jun 2022 11:43:37 -0500")
Message-ID: <87edyvgs2s.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o9wPp-00AEXn-O8;;;mid=<87edyvgs2s.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/stSDpTvjFDPy2IhraphYlslMz8o/ejjI=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 0/3] ptrace: Stop supporting SIGKILL for PTRACE_EVENT_EXIT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Recently I had a conversation where it was pointed out to me that
> SIGKILL sent to a tracee stropped in PTRACE_EVENT_EXIT is quite
> difficult for a tracer to handle.
>
> Keeping SIGKILL working for anything after the process has been killed
> is also a real pain from an implementation point of view.
>
> So I am attempting to remove this wart in the userspace API and see
> if anyone cares.
>
> Eric W. Biederman (3):
>       signal: Ensure SIGNAL_GROUP_EXIT gets set in do_group_exit
>       signal: Guarantee that SIGNAL_GROUP_EXIT is set on process exit
>       signal: Drop signals received after a fatal signal has been processed
>
>  fs/coredump.c                |  2 +-
>  include/linux/sched/signal.h |  1 +
>  kernel/exit.c                | 20 +++++++++++++++++++-
>  kernel/fork.c                |  2 ++
>  kernel/signal.c              |  3 ++-
>  5 files changed, 25 insertions(+), 3 deletions(-)

RR folks any comments?

Did I properly understand what Keno Fischer was asking for when we
talked in person?

Eric
