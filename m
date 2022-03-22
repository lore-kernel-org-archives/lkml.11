Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61E0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 11:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiCVLjp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 07:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiCVLjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:39:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE69BB66
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:38:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95691153B;
        Tue, 22 Mar 2022 04:38:12 -0700 (PDT)
Received: from [10.57.21.112] (unknown [10.57.21.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5DE83F66F;
        Tue, 22 Mar 2022 04:38:10 -0700 (PDT)
Message-ID: <6bc9d1d5-ed33-cc9b-274f-d894c2e2044e@arm.com>
Date:   Tue, 22 Mar 2022 11:38:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2] cpu/hotplug: Set st->cpu earlier
Content-Language: en-US
To:     Steven Price <steven.price@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20220316153637.288199-1-steven.price@arm.com>
From:   Vincent Donnefort <vincent.donnefort@arm.com>
In-Reply-To: <20220316153637.288199-1-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/03/2022 15:36, Steven Price wrote:
> Setting the 'cpu' member of struct cpuhp_cpu_state in cpuhp_create() is
> too late as other callbacks can be made before that point. In particular
> if one of the earlier callbacks fails and triggers a rollback that
> rollback will be done with st->cpu==0 causing CPU0 to be erroneously set
> to be dying, causing the scheduler to get mightily confused and throw
> its toys out of the pram.
> 
> Move the assignment earlier before any callbacks have a chance to run.
> 
> Fixes: 2ea46c6fc945 ("cpumask/hotplug: Fix cpu_dying() state tracking")
> Signed-off-by: Steven Price <steven.price@arm.com>
> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
> Changes since v1[1]:
> 
>   * Added a Fixes: tag.
>   * Moved the assignment to just before cpuhp_set_state() which is the
>     first place it is needed.
> 
> [1]: https://lore.kernel.org/r/20220225134918.105796-1-steven.price%40arm.com
> 
>   kernel/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 407a2568f35e..c1324c8677cf 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -720,7 +720,6 @@ static void cpuhp_create(unsigned int cpu)
>   
>   	init_completion(&st->done_up);
>   	init_completion(&st->done_down);
> -	st->cpu = cpu;
>   }
>   
>   static int cpuhp_should_run(unsigned int cpu)
> @@ -1351,6 +1350,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
>   
>   	cpuhp_tasks_frozen = tasks_frozen;
>   
> +	st->cpu = cpu;
>   	cpuhp_set_state(st, target);
>   	/*
>   	 * If the current CPU state is in the range of the AP hotplug thread,

Reviewed-by: Vincent Donnefort <vincent.donnefort@arm.com>

I also gave a try with LISA's HotplugRollback test.
