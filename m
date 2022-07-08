Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65613C43334
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 21:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240047AbiGHV0W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 17:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238520AbiGHV0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:26:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF9C23BF9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 14:26:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC6CCB82915
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 21:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EBEC341C0;
        Fri,  8 Jul 2022 21:26:16 +0000 (UTC)
Date:   Fri, 8 Jul 2022 17:26:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        zhaohui.shi@horizon.ai
Subject: Re: [PATCH v4 1/2] sched/rt: fix bad task migration for rt tasks
Message-ID: <20220708172614.14191089@gandalf.local.home>
In-Reply-To: <20220708211755.73637-1-schspa@gmail.com>
References: <20220708211755.73637-1-schspa@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Jul 2022 05:17:54 +0800
Schspa Shi <schspa@gmail.com> wrote:

> +++ b/kernel/sched/rt.c
> @@ -1998,11 +1998,14 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  			 * the mean time, task could have
>  			 * migrated already or had its affinity changed.
>  			 * Also make sure that it wasn't scheduled on its rq.
> +			 * It is possible the task has running for a while,

I don't understand the "running for a while" part. That doesn't make sense.

The only way this can happen is that it was scheduled, set
"migrate_disabled" and then got preempted where it's no longer on the run
queue.

-- Steve


> +			 * And we check task migration disable flag here.
>  			 */
>  			if (unlikely(task_rq(task) != rq ||
>  				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
>  				     task_running(rq, task) ||
>  				     !rt_task(task) ||
> +				     is_migration_disabled(task) ||
>  				     !task_on_rq_queued(task))) {
>  
>  				double_unlock_balance(rq, lowest_rq);
