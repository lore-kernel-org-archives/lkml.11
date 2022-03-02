Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8B4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 12:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241725AbiCBMTe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239514AbiCBMTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:19:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F06037A1A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:18:49 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 98597218E4;
        Wed,  2 Mar 2022 12:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646223527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j1HKAw1houAM0FOwreoChzGYlYJbkEiguoOSO4Ij0mk=;
        b=LPbeqbPuJ1J4REL6P36Z4hWA1IupS4vOQUYodT2RbM2+duGJJCpnjmquhuIbXe6MeuCg6d
        InIMlK57yXDqCvaDnhs+9Gr+pTOup7f0YHpHnRh9zeyjp2WT71cOe2af84Qym6izb1+Dkd
        kCwlUAqOzKP7Gv0WnrGmOXvmKqbsuKQ=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6FA2FA3B84;
        Wed,  2 Mar 2022 12:18:47 +0000 (UTC)
Date:   Wed, 2 Mar 2022 13:18:46 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [RFC 1/1] mm: page_alloc: replace mm_percpu_wq with kthreads in
 drain_all_pages
Message-ID: <Yh9gpg2bgnXGGt5s@alley>
References: <20220225012819.1807147-1-surenb@google.com>
 <20220301122520.GB23924@pathway.suse.cz>
 <CAJuCfpGYugkzoGvD4cXBLBWxUfwcge5Gx9PTEk-EuSAX=KSMzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGYugkzoGvD4cXBLBWxUfwcge5Gx9PTEk-EuSAX=KSMzw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-03-01 13:12:19, Suren Baghdasaryan wrote:
> On Tue, Mar 1, 2022 at 4:25 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Thu 2022-02-24 17:28:19, Suren Baghdasaryan wrote:
> > > Sending as an RFC to confirm if this is the right direction and to
> > > clarify if other tasks currently executed on mm_percpu_wq should be
> > > also moved to kthreads. The patch seems stable in testing but I want
> > > to collect more performance data before submitting a non-RFC version.
> > >
> > >
> > > Currently drain_all_pages uses mm_percpu_wq to drain pages from pcp
> > > list during direct reclaim. The tasks on a workqueue can be delayed
> > > by other tasks in the workqueues using the same per-cpu worker pool.
> > > This results in sizable delays in drain_all_pages when cpus are highly
> > > contended.
> > > Memory management operations designed to relieve memory pressure should
> > > not be allowed to block by other tasks, especially if the task in direct
> > > reclaim has higher priority than the blocking tasks.
> > > Replace the usage of mm_percpu_wq with per-cpu low priority FIFO
> > > kthreads to execute draining tasks.
> > >
> > > Suggested-by: Petr Mladek <pmladek@suse.com>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > The patch looks good to me. See few comments below about things
> > where I was in doubts. But I do not see any real problem with
> > this approach.
> 
> Thanks for the review, Petr. One question inline.

Answering just this question.

> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 3589febc6d31..c9ab2cf4b05b 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > +static void __init init_drain_workers(void)
> > > +{
> > > +     unsigned int cpu;
> > > +
> > > +     for_each_online_cpu(cpu)
> > > +             alloc_drain_worker(cpu);
> >
> > I though whether this need to be called under cpus_read_lock();
> > And I think that the code should be safe as it is. There
> > is this call chain:
> >
> >   + kernel_init_freeable()
> >     + page_alloc_init_late()
> >       + init_drain_workers()
> >
> > It is called after smp_init() but before the init process
> > is executed. I guess that nobody could trigger CPU hotplug
> > at this state. So there there is no need to synchronize
> > against it.
> 
> Should I add a comment here to describe why we don't need
> cpus_read_lock here (due to init process not being active at this
> time)?

I would add the comment. That said, I hope that I am right and
lock is not really needed ;-)

Best Regards,
Petr
