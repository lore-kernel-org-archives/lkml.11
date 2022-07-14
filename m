Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24018C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 12:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbiGNMcN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 08:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239303AbiGNMb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:31:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3272542ACF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:31:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EA8213D5;
        Thu, 14 Jul 2022 05:31:48 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7D0A3F792;
        Thu, 14 Jul 2022 05:31:46 -0700 (PDT)
Message-ID: <fa74892c-2956-6ddf-e022-398b89056e5a@arm.com>
Date:   Thu, 14 Jul 2022 14:31:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 04/10] sched/fair: remove redundant
 cpu_cgrp_subsys->fork()
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-5-zhouchengming@bytedance.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220713040430.25778-5-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 06:04, Chengming Zhou wrote:
> We use cpu_cgrp_subsys->fork() to set task group for the new fair task
> in cgroup_post_fork().
> 
> Since commit b1e8206582f9 ("sched: Fix yet more sched_fork() races")
> has already set task group for the new fair task in sched_cgroup_fork(),
> so cpu_cgrp_subsys->fork() can be removed.
> 
>   cgroup_can_fork()	--> pin parent's sched_task_group
>   sched_cgroup_fork()

Don't we set the task group (`p->sched_task_group = tg`) now directly in
sched_cgroup_fork() and not in __set_task_cpu()?

>     __set_task_cpu	--> set task group
>   cgroup_post_fork()
>     ss->fork() := cpu_cgroup_fork()	--> set again

nit pick:

cpu_cgroup_fork() -> sched_change_group(..., TASK_SET_GROUP)

> After this patch's change, task_change_group_fair() only need to
> care about task cgroup migration, make the code much simplier.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

LGTM too.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]
