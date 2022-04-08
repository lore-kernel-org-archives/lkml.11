Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30838C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 13:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbiDHNqE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 09:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiDHNqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:46:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173066CBE;
        Fri,  8 Apr 2022 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U3X29t3+VLz2WJJhQemUxxtklWikOyMxuqcodamWqYc=; b=WVV+3pnhzr+qRY8PinZ3kgCl8A
        L2NS6NDs0RVQapzxIBSFRHEwCZ8Rl7MgJflCcTj8c9QGennVYL5NxvvWo40KpmvWCNZzYdVLJwO6W
        CSKnYny73Hve66dvz0w3keewkRrefPg274P7xpJPfy3ReqbUnu1Z0QB8iZgXLag/2CA8OperiAbfj
        tRFBBXoc5mX8RbGpHC/t6CSP6tUAn61uH+pwi9NjX5ww6J0w5Lhyk2kzgZ+repbquFUkD6C8TMalN
        C2gZ+xJZP4+GNrFNqZ6oiMBl3y7F7QKODMFPLQL3lmrAbZLydS6eKMbQ5zFTL7zv6fQUUaR8CzcrM
        ySqEMQow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncotf-002vyl-HT; Fri, 08 Apr 2022 13:43:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F05963001D0;
        Fri,  8 Apr 2022 15:43:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C60BC201C63B3; Fri,  8 Apr 2022 15:43:28 +0200 (CEST)
Date:   Fri, 8 Apr 2022 15:43:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "brookxu.cn" <brookxu.cn@gmail.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] docs/scheduler: Change unit of cpu_time and rq_time to
 nanoseconds
Message-ID: <YlA8AEfqK6eRnAPO@hirez.programming.kicks-ass.net>
References: <1649410266-32360-1-git-send-email-brookxu.cn@gmail.com>
 <YlAub2NXBPeNcyAS@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlAub2NXBPeNcyAS@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 01:45:35PM +0100, Matthew Wilcox wrote:
> On Fri, Apr 08, 2022 at 05:31:06PM +0800, brookxu.cn wrote:
> > From: Chunguang Xu <brookxu@tencent.com>
> > 
> > In the current implementation, cpu_time and rq_time should be
> > in nanoseconds, so this document needs to be modified.
> 
> I agree that this is wrong, but we shouldn't be changing the units
> of measurement reported to userspace without changing the schedstats
> version.  I suspect this was an inadvertent change, and we should be
> converting from sched_clock() time (~= ns) to jiffies in show_schedstat().
> Adding scheduler experts.

Seems to have happend at 425e0968a25f ("sched: move code into
kernel/sched_stats.h").

Before that we have:

-static inline void
-rq_sched_info_depart(struct rq *rq, unsigned long delta_jiffies)
-{
-       if (rq)
-               rq->rq_sched_info.cpu_time += delta_jiffies;
-}

-static inline void sched_info_depart(struct task_struct *t)
-{
-       unsigned long delta_jiffies = jiffies - t->sched_info.last_arrival;
-
-       t->sched_info.cpu_time += delta_jiffies;
-       rq_sched_info_depart(task_rq(t), delta_jiffies);
-}

afterwards we have:

+static inline void sched_info_depart(struct task_struct *t)
+{
+       unsigned long long delta = sched_clock() - t->sched_info.last_arrival;
+
+       t->sched_info.cpu_time += delta;
+       rq_sched_info_depart(task_rq(t), delta);
+}

And that's 15 years and at least one SCHEDSTAT_VERSION ago (although
this change itself didn't bump the version).

So I'm thinking we can update the documentation and forget about this.
