Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33A3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 21:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346371AbiEaVJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 17:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbiEaVJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:09:15 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6253AD10C
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:09:11 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id m82so20056oif.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qb2wixBAjOfrO+JOD8eyJ0+vEIh8pCY+Kx7wsN+KSX4=;
        b=OzDnQolDyMK1izGSIjT5nsZBludLaNcdoJg43sKfxNYGltjlC+/TDJ2D638nIeVJha
         Xm2PRJOpBlLatOqcds304zOEJLM364xvcTBVAkMAzIz69KWVJ//6PLHocWQCH+4IEp8z
         DMwFT1GN+HlNjPgHjj+TmwsTiHywgn9IaK7kI6XOcfxpLeL7KJDSy2pYI8HWTnh0p0+A
         cLwBL3NsZkm0yfG0egBSwAW4TdUGlAhQ+z1B/0vk5NYSudigQ7c07cAl0MamS48/1vGl
         1d7xeoYvBRKzfqsUH2ULMe/63M+qSc0p2CLfKUPrNzRwtyUGJG4/NevGLlN87cxqmbzu
         xtIw==
X-Gm-Message-State: AOAM530zy9Uj2JcpapimrYXcWs/Q0x91k7XmL64YyUoR7Y2IUTaT703s
        +NH0h+/vK2KBB+V+KaIN38XAaNgHgRVsI2ceXgY=
X-Google-Smtp-Source: ABdhPJw+4euKjCEAvccDRUS4y+xMPtwxJU5wejnlr96AdbSTKHx2aIGS4gpfGRf8fCwrzV3WgbQBSgH52YSUe5c9FaI=
X-Received: by 2002:a05:6808:1a01:b0:32b:1f24:9213 with SMTP id
 bk1-20020a0568081a0100b0032b1f249213mr12838802oib.92.1654031350741; Tue, 31
 May 2022 14:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220427155241.26410-1-dave@stgolabs.net> <CAM9d7ciQnUcefR-hLBHSDhu6zZovxXvGYW-CdSBiub_GAOfAiA@mail.gmail.com>
 <20220429184513.vftv4pj72fxzrpm2@offworld>
In-Reply-To: <20220429184513.vftv4pj72fxzrpm2@offworld>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 31 May 2022 14:08:59 -0700
Message-ID: <CAM9d7cjO2zXS3hcaGA+eanM3fDsG0sXgQFHDUC6fpBq5RpBorA@mail.gmail.com>
Subject: Re: [PATCH] locking/rwsem: Teach contention tracing about optimistic spinning
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davidlohr,

On Fri, Apr 29, 2022 at 11:56 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> Sorry for the late reply.
>
> On Wed, 27 Apr 2022, Namhyung Kim wrote:
>
> >Hi Davidlohr,
> >
> >On Wed, Apr 27, 2022 at 9:04 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
> >>
> >> Similar to the mutex counterpart, we can further distinguish the
> >> types of contention. Similarly this patch also introduces potentially
> >> various _begin() tracepoints with a single respective _end().
> >
> >Thanks for doing this.  I was thinking about it as well.
>
> I really like your work on this. I've always wanted a low overhead
> equivalent-ish of lock_stat, which could be used in production and
> look forward to see these tracepoints put to good use.
>
> >> @@ -115,7 +116,8 @@ TRACE_EVENT(contention_begin,
> >>                                 { LCB_F_WRITE,          "WRITE" },
> >>                                 { LCB_F_RT,             "RT" },
> >>                                 { LCB_F_PERCPU,         "PERCPU" },
> >> -                               { LCB_F_MUTEX,          "MUTEX" }
> >> +                               { LCB_F_MUTEX,          "MUTEX" },
> >> +                               { LCB_F_RWSEM,          "RWSEM" }
> >>                           ))
> >>  );
> >
> >Well I'm ok with this but it'd be better if we can do this
> >without adding a new flag.  Originally a mutex can be
> >identified with 0, and a rwsem with either of READ or WRITE.
> >
> >The MUTEX flag was added to note optimistic spins
> >on mutex and now we need something similar for
> >rwsem.  Then can we change the MUTEX to OPTIMISTIC
> >if it's not too late?
>
> Ok. Perhaps name it OSQ? I had thought of that but at the
> time was also thinking about potentially the rtmutex and
> rt spinlock spinning too - which don't use osq so the name
> would fit in that sense.
>
> While not in Linus' tree, I wouldn't think it's too late.

Any updates?  It's now in Linus' tree so we should change
this before the official release.  Or we can keep the current
flags and then add one like in your original code.


>
> >>         for (;;) {
> >>                 if (rwsem_try_write_lock(sem, &waiter)) {
> >> @@ -1161,18 +1167,25 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
> >>                 if (waiter.handoff_set) {
> >>                         enum owner_state owner_state;
> >>
> >> +                       trace_contention_begin(sem, LCB_F_RWSEM |
> >> +                                              LCB_F_WRITE | LCB_F_SPIN);
> >>                         preempt_disable();
> >>                         owner_state = rwsem_spin_on_owner(sem);
> >>                         preempt_enable();
> >>
> >> -                       if (owner_state == OWNER_NULL)
> >> -                               goto trylock_again;
> >> +                       if (owner_state == OWNER_NULL) {
> >> +                               raw_spin_lock_irq(&sem->wait_lock);
> >> +                               if (rwsem_try_write_lock(sem, &waiter))
> >> +                                       break;
> >> +                               raw_spin_unlock_irq(&sem->wait_lock);
> >> +                       }
> >> +
> >> +                       trace_contention_begin(sem, LCB_F_RWSEM | LCB_F_WRITE);
> >
> >I'm afraid that it'd generate many contention_begin
> >trace events for a single lock acquisition.
>
> You are right, lets just trace the "normal" optimistic spinning
> at the start of the write slowpath.

I have to admit that I overlooked the mutex code already
has the same logic.  I still prefer having less number of
events but you might want to have the same with the
mutex for the precise tracking of the spins.

Thanks,
Namhyung
