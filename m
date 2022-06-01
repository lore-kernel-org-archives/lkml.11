Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517ABC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jun 2022 07:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350411AbiFAHpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jun 2022 03:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350408AbiFAHpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:45:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD7AA0056
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:45:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5C30021A9B;
        Wed,  1 Jun 2022 07:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654069527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c+kKVH4gdDZYbxjzcOg+jvGZrV/KqgQJdzEt6yLtxiw=;
        b=S4LQzg4KaKuueGjKKTJTztLQBLTVTM/c3TROtrfcIiBWV1r0FZshxfMF8/d5hLWUwKxQ/T
        VoY7CuPuR1DTfo6SjQ9XqCX6B9b7Yce7+pfomnSKgOshcw/3dIrbIJ9zsrHIYWSDWeDyWn
        K0rMKoc/3Et8Cd5W6tATzOYhsy7r6Ao=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1FF002C141;
        Wed,  1 Jun 2022 07:45:27 +0000 (UTC)
Date:   Wed, 1 Jun 2022 09:45:26 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhaoyu Liu <zackary.liu.pro@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/oom_kill: break evaluation when a task has been
 selected
Message-ID: <YpcZFvVZRPTyTQ7s@dhcp22.suse.cz>
References: <20220514075223.GA11384@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514075223.GA11384@pc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 14-05-22 15:52:28, Zhaoyu Liu wrote:
> oom points no longer need to be calculated if a task is oom_task_origin(),
> so return 1 to stop the oom_evaluate_task().

This doesn't really explain why this is really desired. Is this a fix,
optimization?

Please also note that this change has some side effects. For one, the
task marked as oom origin will get killed even if there is still a
pending oom victim which hasn't been fully dismantled. Is this
intentional?

> Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>
> ---
>  mm/oom_kill.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 3996301450e8..b407fba21d19 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -308,7 +308,7 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
>  static int oom_evaluate_task(struct task_struct *task, void *arg)
>  {
>  	struct oom_control *oc = arg;
> -	long points;
> +	long points = 0;
>  
>  	if (oom_unkillable_task(task))
>  		goto next;
> @@ -349,7 +349,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
>  	oc->chosen = task;
>  	oc->chosen_points = points;
>  next:
> -	return 0;
> +	return points == LONG_MAX;
>  abort:
>  	if (oc->chosen)
>  		put_task_struct(oc->chosen);
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
