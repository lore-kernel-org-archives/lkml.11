Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88794C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 14:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbiBXOEM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 09:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbiBXOEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:04:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6951C20D83C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 06:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645711419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rrg9S+e1z9ycGVjwf8FshYc7srhCJ2Jl2HeTSgf5H9U=;
        b=aXPoaFIm9iIbICVft973jjTm32mwCc2DWAOSZjRz481JSrP8JoPs1zCFw81fMDYUzYJ8Yx
        cS1LjHcZc9N4C/2N5yHRCPh02K/Sn8rW83YnMytauI5fscu9SbVjXV35+oBAdTMju3TOZG
        SRytBGsDTCi1Xb9udv562QvoNPClG6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-4j-thfZ1NDuYbevR9MlnSw-1; Thu, 24 Feb 2022 09:03:36 -0500
X-MC-Unique: 4j-thfZ1NDuYbevR9MlnSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A96861854E2A;
        Thu, 24 Feb 2022 14:03:34 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.33.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9D86842D7;
        Thu, 24 Feb 2022 14:03:15 +0000 (UTC)
Date:   Thu, 24 Feb 2022 09:03:13 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/sched: Update schedstats when migrating threads
Message-ID: <YheQIU7oFDcaPoD7@lorien.usersys.redhat.com>
References: <20220126152222.5429-1-carlos.bilbao@amd.com>
 <YhYKL4hxx4TNKHGD@hirez.programming.kicks-ass.net>
 <aac8f860-c01f-bda0-9f1b-029b234213c2@amd.com>
 <YhZSqd+d03oWUPP6@lorien.usersys.redhat.com>
 <0e42c46a-ccc4-e793-00b8-ae407e06846f@amd.com>
 <YhZXGv34YTV5omKq@lorien.usersys.redhat.com>
 <b7a28537-8bfb-7f0d-5ed3-f301983e4e30@amd.com>
 <3c6224ca-c0da-7ba9-1396-a2e74c4a40e8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c6224ca-c0da-7ba9-1396-a2e74c4a40e8@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 10:13:50AM -0600 Carlos Bilbao wrote:
> The kernel manages per-task scheduler statistics or schedstats. Update
> function migrate_task_to() to increase the counter for migrations.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
> Changelog:
> 	v2: Update commit message, don't reinitialize sched fields.
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fcf0c180617c..1360e501c737 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8751,7 +8751,7 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
>  	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
>  		return -EINVAL;
>  
> -	/* TODO: This is not properly updating schedstats */
> +	schedstat_inc(p->stats.nr_migrations_cold);
>

I was going to give a reviewed by since I was looking at this,
but I can't convince myself that nr_migrations_cold is right.
This looks more like a "hot" migration (using stop_cpu to force
it). But nr_migrations_cold is not incremented anywhere else so
maybe it's a terminology thing.

Can you tell me why this is the right counter?


Thanks,
Phil


>  	trace_sched_move_numa(p, curr_cpu, target_cpu);
>  	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
> -- 
> 2.27.0
> 

-- 

