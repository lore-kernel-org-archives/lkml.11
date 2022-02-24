Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24017C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 13:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbiBXNAt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 08:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiBXNAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:00:47 -0500
Received: from p3plsmtpa07-05.prod.phx3.secureserver.net (p3plsmtpa07-05.prod.phx3.secureserver.net [173.201.192.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986E928F949
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:00:17 -0800 (PST)
Received: from localhost ([82.17.115.212])
        by :SMTPAUTH: with ESMTPA
        id NDjDncYtGSdTcNDjEn8e1s; Thu, 24 Feb 2022 06:00:17 -0700
X-CMAE-Analysis: v=2.4 cv=FbvyeLy6 c=1 sm=1 tr=0 ts=62178161
 a=9gipVNR6X1CoIeAWHwLoWw==:117 a=9gipVNR6X1CoIeAWHwLoWw==:17
 a=IkcTkHD0fZMA:10 a=WuPJb5gop3dDKBQA4PsA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: atomlin@atomlin.com
Date:   Thu, 24 Feb 2022 13:00:14 +0000
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <20220224130014.rmhtx3xlepybuxn2@ava.usersys.com>
References: <20220203214339.1889971-1-atomlin@redhat.com>
 <20220217124729.GA743618@lothringen>
 <20220217142615.xqtiydixvnumyvei@ava.usersys.com>
 <20220217163205.GA748087@lothringen>
 <20220218125454.utlgmuhijklzr3if@ava.usersys.com>
 <20220219154616.pwsvh445x3vn7ltf@ava.usersys.com>
 <Yhd5olg9CjXSAf2s@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yhd5olg9CjXSAf2s@fuller.cnet>
X-CMAE-Envelope: MS4xfP0vK9DSGV5SIh2kUNZqMVu9AIg84RjBxwiFE2Lfa7WDplvPCD4odOwpqDjkzL8o0tQN0jSY+6cJ1WqmElk5F1OAbeQwDWXRORpdMr+K55pgYprFRPJo
 D2Q6z1mOPYqhXPMfUnG6dVKEAjdjpfBSQpf49xSAM6N5mK+AQpr8sZx0lyL8tgnV8Fj66nvy7byT8H+YXY5T0CZwq7MNdXyyTjDP2WPP/ztAu7H/HXHLj+Qg
 d5ap0AzidIXiUAUNZjM6aFsJGig/edQZCvRxYNrUUXpavhK1NmLNmpXgVvaLvGQWkTXvoeQerNp7AdExmGCVC8Axr7J5Jlgh8YTCeMv5oI6CEBKQk4pMtv3V
 Z4rLU8T6YWCXdTeeAMXBfOqOxa1H+wFU0IZ44wVNjHygYbQczho=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-24 09:27 -0300, Marcelo Tosatti wrote:
> But Aaron, vmstat_shepherd should be ensuring that per-CPU vmstat_update
> work are queued, if the per-CPU vmstat are out of sync.

Hi Marcelo,

Yes, I agree; albeit, as far as I understand, in the context of a nohz_full
CPU that has its scheduling-clock tick stopped, we cannot rely on any
deferred work.

The purpose of my patch was to prevent a nohz_full CPU from entering idle
state when CPU-specific vmstat data is non-zero.

> And:
> 
> static void
> trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
> {
>         if (!is_timers_nohz_active())
>                 return;
> 
>         /*
>          * TODO: This wants some optimizing similar to the code below, but we
>          * will do that when we switch from push to pull for deferrable timers.
>          */
>         if (timer->flags & TIMER_DEFERRABLE) {
>                 if (tick_nohz_full_cpu(base->cpu))
>                         wake_up_nohz_cpu(base->cpu);
>                 return;
>         }
> 
>  * @TIMER_DEFERRABLE: A deferrable timer will work normally when the
>  * system is busy, but will not cause a CPU to come out of idle just
>  * to service it; instead, the timer will be serviced when the CPU
>  * eventually wakes up with a subsequent non-deferrable timer.
> 
> You'd want that vmstat_update to execute regardless of whether there are 
> armed non-deferrable timers.
> 
> Should fix both 1 and 2 AFAICS.
> 

If I understand correctly, you are suggesting to switch to a non-deferred
timer for such work when the scheduling-clock tick is stopped? Indeed, it
would address both scenarios yet I'm not sure we'd want that due to the
performance impact which might be more than negligible.


Kind regards,

-- 
Aaron Tomlin
