Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AA7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 14:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiC2O2J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 10:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiC2O1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:27:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBA96FA1E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648563968; x=1680099968;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y0Q8yMD+JJl3osszETSO8IwoxGDjW7MHZzj6dJbYL/g=;
  b=BKHan/P08LieBfEWBUVQlYD/Px0cFd99mzSt+zHY1HAM8jKmpg4Tpnjd
   uuHmsVvCsRhNrRyiNbQfVml3xVjg6nnQEDiFTiI5QMRaq8SXkbbEWP5My
   m90EFHXBf8tsozq+wdzHOqGw1hRV6s9xLJR2eDueadynB+HCtfVqH5o0Z
   +YEawazNEBA2fQdkrFBGbmYCpMABBBUDelj9HUoR9YhkvLIt5ucW6WwW0
   /+lnqhrwfYCb4hbOmp5vafGEneQ9J1+QyMLAV7j3KyriDcgsAXPlTn3TS
   Yz3cO1ILd1f9R7kwh6ta2UprX8YM8ze9maOTifHbwuA7AtRNEcGrnq6bC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259233288"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="259233288"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 07:26:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="518955505"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.200.19])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 07:26:05 -0700
Message-ID: <ebc9718f41b9294fe46129cafe3edffdbcc024e3.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] sched/fair: Simple runqueue order on migrate
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@elte.hu>, Juri Lelli <juri.lelli@redhat.com>
Cc:     Yu Chen <yu.c.chen@intel.com>, Walter Mack <walter.mack@intel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Date:   Tue, 29 Mar 2022 07:26:05 -0700
In-Reply-To: <3a24ba8c-b00d-2f9b-95c9-b8aba1b51493@bytedance.com>
References: <cover.1648228023.git.tim.c.chen@linux.intel.com>
         <f59f1dfeec4692e7a373cc810168912a2d2f8f3c.1648228023.git.tim.c.chen@linux.intel.com>
         <3a24ba8c-b00d-2f9b-95c9-b8aba1b51493@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-03-29 at 18:09 +0800, Abel Wu wrote:
> > 
> 
> >   
> > +static void place_entity_migrate(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > +{
> > +	if (!sched_feat(PLACE_MIGRATE))
> > +		return;
> > +
> > +	if (cfs_rq->nr_running < se->migrated) {
> > +		/*
> > +		 * Migrated to a shorter runqueue, go first because
> > +		 * we were under-served on the old runqueue.
> > +		 */
> > +		se->vruntime = cfs_rq->min_vruntime;
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * Migrated to a longer runqueue, go last because
> > +	 * we got over-served on the old runqueue.
> > +	 */
> > +	se->vruntime = cfs_rq->min_vruntime + sched_vslice(cfs_rq, se);
> > +}
> 
> Should se->migrated be cleared after place_entity_migrate?
> 

It is cleared in update_stats_curr_start() before we actually run the task.
If the task gets migrated again before we run it, the se->migrated will also
be updated in migrate_task_rq_fair().  Looks like there is no need to
clear it here.

Tim

