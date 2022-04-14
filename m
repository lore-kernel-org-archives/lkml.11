Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD10C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 17:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbiDNR3D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 13:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbiDNR26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:28:58 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E383CC9B65
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:26:32 -0700 (PDT)
Date:   Fri, 15 Apr 2022 01:27:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649957190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/+VSutvUSiv//xHeSteJ4KSmEkceAWe5O0V0zQQ96dU=;
        b=B7Njgway+nohBCEYxnkEA/beYuTbirwMhnAKBflq1zgYG2Qg+QK8Db+lHGK9Hp1TMn3zbD
        /umjhIaIrrIpSR4X46Yp1hQsmyN3T45YQzNI6QcvujI1EezeJwnPXfsKDMtCNCL5LiOjQ+
        A41Xmqspb6U0vSx7IqVwapim8BYYqQc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Revise comment about lb decision matrix
Message-ID: <YlhZbOCJ8nhebOzG@geo.homenetwork>
References: <20220403175946.7323-1-tao.zhou@linux.dev>
 <a443f8ed-7bc9-5ded-89de-b19fad014359@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a443f8ed-7bc9-5ded-89de-b19fad014359@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 12:33:06PM +0200,
Dietmar Eggemann wrote:
> On 03/04/2022 19:59, Tao Zhou wrote:
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
> > So, change the decision matrix to:
> > 
> > busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
> > has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
> > fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
> > misfit_task      force     N/A        N/A    N/A  *N/A*      *N/A*
> > asym_packing     force     force      N/A    N/A  force      force
> > imbalanced       force     force      N/A    N/A  force      force
> > overloaded       force     force      N/A    N/A  force      avg_load
> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 5146163bfabb..5765d96202c7 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9441,7 +9441,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> >   * busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
> >   * has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
> >   * fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
> > - * misfit_task      force     N/A        N/A    N/A  force      force
> > + * misfit_task      force     N/A        N/A    N/A  N/A        N/A
> >   * asym_packing     force     force      N/A    N/A  force      force
> >   * imbalanced       force     force      N/A    N/A  force      force
> >   * overloaded       force     force      N/A    N/A  force      avg_load
> 
> You should put people you find in `./scripts/get_maintainer.pl
> kernel/sched/fair.c` on To/Cc to attract more attention.
> 
> Otherwise, LGTM.
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

I will send based on latest rc version..

Thanks,
Tao
