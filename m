Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC48C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 10:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352066AbiDOKFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 06:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiDOKE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:04:57 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19316BB08A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 03:02:28 -0700 (PDT)
Date:   Fri, 15 Apr 2022 18:03:05 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650016946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l24SRURrZaOrna4LFT1+c4+6yM66QDm3iL5iU6iEqm4=;
        b=oPTcnvzL0dwOgR4bzD6k9/ZTKFj2jRMGsds+bT1fsJMJ1EHhZbT0MthNTIb8hMENs04fOK
        os/HPIqY0SE4keuIX+k26bhGdKHgmXp6K3twKJD+VE9EH36LhBmSi+o+1pxV2UHueiPRTx
        GGBKOlAS1zjF4vBWHBxYm4JvRPx1kfw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Tao Zhou <tao.zhou@linux.dev>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH V1 RESEND]: sched/fair: Revise comment about lb decision
 matrix
Message-ID: <YllC2VNdu5dmnrbb@geo.homenetwork>
References: <20220415022246.14902-1-tao.zhou@linux.dev>
 <CAKfTPtAbxAerbV-LBcpm_qHAphhD3uU47k0hu=DDX3k6LS-Aow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAbxAerbV-LBcpm_qHAphhD3uU47k0hu=DDX3k6LS-Aow@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 10:32:09AM +0200,
Vincent Guittot wrote:

> On Fri, 15 Apr 2022 at 04:22, Tao Zhou <tao.zhou@linux.dev> wrote:
> >
> > If busiest group type is group_misfit_task, the local
> > group type must be group_has_spare according to below
> > code in update_sd_pick_busiest():
> >
> > if (sgs->group_type == group_misfit_task &&
> >     (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
> >      sds->local_stat.group_type != group_has_spare))
> >          return false;
> >
> > group type imbalanced and overloaded and fully_busy are filtered in here.
> > misfit and asym are filtered before in update_sg_lb_stats().
> 
> The behavior has changed with
> cad68e552e77 ("sched/fair: Consider misfit tasks when load-balancing")
> But we haven't updated the matrix
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

I send a version just now but forget to change the version number.

Thanks,
Tao

> > So, change the decision matrix to:
> >
> > busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
> > has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
> > fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
> > misfit_task      force     N/A        N/A    N/A  *N/A*      *N/A*
> > asym_packing     force     force      N/A    N/A  force      force
> > imbalanced       force     force      N/A    N/A  force      force
> > overloaded       force     force      N/A    N/A  force      avg_load
> >
> > Fixes: 0b0695f2b34a ("sched/fair: Rework load_balance()")
> > Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Signed-off-by: Tao Zhou <tao.zhou@linux.dev>
> > ---
> >
> > v1 changelog:
> > (1) Send to MAINTAINERS/REVIEWS get from `./scripts/get_maintainer.pl`
> >     suggested by Dietmar Eggemann.
> > (2) Based on v5.18-rc2
> >
> >
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d4bd299d67ab..b8c67e7c8cf3 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9495,7 +9495,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> >   * busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
> >   * has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
> >   * fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
> > - * misfit_task      force     N/A        N/A    N/A  force      force
> > + * misfit_task      force     N/A        N/A    N/A  N/A        N/A
> >   * asym_packing     force     force      N/A    N/A  force      force
> >   * imbalanced       force     force      N/A    N/A  force      force
> >   * overloaded       force     force      N/A    N/A  force      avg_load
> > --
> > 2.35.2
> >
