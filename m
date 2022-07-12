Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D11C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 20:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiGLUDY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 16:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiGLUDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:03:21 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19DB3E74B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:03:20 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:58916)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oBM6F-008snJ-KZ; Tue, 12 Jul 2022 14:03:15 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38716 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oBM6B-00EgHA-UL; Tue, 12 Jul 2022 14:03:14 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Robert O'Callahan" <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Oleg Nesterov <oleg@redhat.com>
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
        <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org>
        <87edyvgs2s.fsf@email.froward.int.ebiederm.org>
        <CABV8kRxQNPUzLaJ1tFF8H-E_iqCkz0+Ac5rPBurnmA3GcofMmQ@mail.gmail.com>
Date:   Tue, 12 Jul 2022 15:03:04 -0500
In-Reply-To: <CABV8kRxQNPUzLaJ1tFF8H-E_iqCkz0+Ac5rPBurnmA3GcofMmQ@mail.gmail.com>
        (Keno Fischer's message of "Fri, 8 Jul 2022 19:22:01 -0400")
Message-ID: <875yk22j5z.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oBM6B-00EgHA-UL;;;mid=<875yk22j5z.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+YkQubfrIv1qgyoUMDuaCP6iHCuoPdSL4=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 0/3] ptrace: Stop supporting SIGKILL for PTRACE_EVENT_EXIT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keno Fischer <keno@juliacomputing.com> writes:

> Hi Eric,
>
> On Fri, Jul 8, 2022 at 6:25 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> > Recently I had a conversation where it was pointed out to me that
>> > SIGKILL sent to a tracee stropped in PTRACE_EVENT_EXIT is quite
>> > difficult for a tracer to handle.
>> >
>>
>> RR folks any comments?
>>
>> Did I properly understand what Keno Fischer was asking for when we
>> talked in person?
>
> Yes, this is indeed what I had in mind. I have not yet had the opportunity
> to try out your patch series (sorry), but from visual inspection, it does indeed
> do what I wanted, which is to make sure that a tracee stays in
> PTRACE_EVENT_EXIT for the tracer to inspect, even if there is another
> SIGKILL incoming simultaneously (since otherwise it may be impossible
> for the tracer to observe the PTRACE_EVENT_EXIT if two SIGKILLs
> come in rapid succession). I will try to take this series for a proper spin
> shortly.

Thanks,

I haven't yet figured out how to get the rr test suite to run
successfully.  Something about my test machine and lack of perf counters
seems to be causing problems.  So if you can perform the testing on your
side that would be fantastic.

Eric
