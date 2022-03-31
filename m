Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0883C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 11:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiCaLtT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 07:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiCaLtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:49:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C926F20826F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B/zRduQvtiaKtm4fp81K8YIkVw/D3P2vKnzcPBQVppg=; b=n9O7D5VkAfDLSOuzTQhQL79hvu
        NthO6bLDZ08uHcmP0igXjwk4xwMskc9ZrkbR/HJCf+Viyz4MEdZ5gcXpgijEFaskfv2oBFZS6z1sU
        9j+uu2u+dEqUm0FtSmGf54DGK25/AF4LYw7J+OlWV8S5wW9akHZkMFTteaco+GwYuuvz1ZWBR5Ppy
        kZm1up92Nndozycb4X86NKLhJDY6/2ar811JPCASmq99TrEkQGsVAQbTfNJ2pX3zyEjMcRBPwCZsx
        HXcnMvlNIhnWbXtrT1xUhYZbBR+t/HZOnMRPbmAlM3J/2Mx1UXBWhUWcc5LNFojcktWk9tCRJ9vFn
        f8c3JT1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZtGi-0002pI-4C; Thu, 31 Mar 2022 11:47:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE9B89861D6; Thu, 31 Mar 2022 13:47:09 +0200 (CEST)
Date:   Thu, 31 Mar 2022 13:47:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>,
        Juri Lelli <juri.lelli@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Walter Mack <walter.mack@intel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/fair: Simple runqueue order on migrate
Message-ID: <20220331114709.GS8939@worktop.programming.kicks-ass.net>
References: <cover.1648228023.git.tim.c.chen@linux.intel.com>
 <f59f1dfeec4692e7a373cc810168912a2d2f8f3c.1648228023.git.tim.c.chen@linux.intel.com>
 <CAKfTPtBDA1uZ1xvo_uhqnNVg69DPXXJBeo0+aQdVJiosB_qgrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBDA1uZ1xvo_uhqnNVg69DPXXJBeo0+aQdVJiosB_qgrw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


It's been 3 months since I wrote these patches, so memory is vague at
best :/

On Tue, Mar 29, 2022 at 11:03:44AM +0200, Vincent Guittot wrote:

> > +static void place_entity_migrate(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > +{
> > +       if (!sched_feat(PLACE_MIGRATE))
> > +               return;
> > +
> > +       if (cfs_rq->nr_running < se->migrated) {
> > +               /*
> > +                * Migrated to a shorter runqueue, go first because
> > +                * we were under-served on the old runqueue.
> > +                */
> > +               se->vruntime = cfs_rq->min_vruntime;
> > +               return;
> > +       }
> > +
> > +       /*
> > +        * Migrated to a longer runqueue, go last because
> > +        * we got over-served on the old runqueue.
> > +        */
> > +       se->vruntime = cfs_rq->min_vruntime + sched_vslice(cfs_rq, se);
> > +}
> > +
> >  static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
> >
> >  static inline bool cfs_bandwidth_used(void);
> > @@ -4296,6 +4317,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >
> >         if (flags & ENQUEUE_WAKEUP)
> >                 place_entity(cfs_rq, se, 0);
> > +       else if (se->migrated)
> > +               place_entity_migrate(cfs_rq, se);
> >
> >         check_schedstat_required();
> >         update_stats_enqueue_fair(cfs_rq, se, flags);

> > @@ -6973,14 +6997,15 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> >                  * wakee task is less decayed, but giving the wakee more load
> >                  * sounds not bad.
> >                  */
> > -               remove_entity_load_avg(&p->se);
> > +               remove_entity_load_avg(se);
> >         }
> >
> >         /* Tell new CPU we are migrated */
> > -       p->se.avg.last_update_time = 0;
> > +       se->avg.last_update_time = 0;
> >
> >         /* We have migrated, no longer consider this task hot */
> > -       p->se.migrated = 1;
> > +       for_each_sched_entity(se)
> > +               se->migrated = READ_ONCE(cfs_rq_of(se)->nr_running) + !se->on_rq;
> 
> Why do we need to loop on se ? Isn't p->se enough ?

Yeah; I really don't recall why I did that. And looking at it now, it
doesn't really make much sense. I suppose it will trigger
place_entity_migrate() for the group entries, but on the old CPU.


