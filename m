Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5324FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 09:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240040AbiDNJGX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 05:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241588AbiDNJGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:06:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBC3C6C1C8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:02:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68D0E139F;
        Thu, 14 Apr 2022 02:02:58 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 953713F5A1;
        Thu, 14 Apr 2022 02:02:55 -0700 (PDT)
Message-ID: <f7913fea-d110-9140-6dfa-72561c3fbefd@arm.com>
Date:   Thu, 14 Apr 2022 11:02:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] [PATCH v2]sched/pelt: Refine the enqueue_load_avg
 calculate method
Content-Language: en-US
To:     Kuyo Chang <kuyo.chang@mediatek.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220414015940.9537-1-kuyo.chang@mediatek.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220414015940.9537-1-kuyo.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2022 03:59, Kuyo Chang wrote:
> From: kuyo chang <kuyo.chang@mediatek.com>

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299d67ab..159274482c4e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3829,10 +3829,12 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  
>  	se->avg.runnable_sum = se->avg.runnable_avg * divider;
>  
> -	se->avg.load_sum = divider;
> -	if (se_weight(se)) {
> +	se->avg.load_sum = se->avg.load_avg * divider;
> +	if (se_weight(se) < se->avg.load_sum) {
>  		se->avg.load_sum =
> -			div_u64(se->avg.load_avg * se->avg.load_sum, se_weight(se));
> +			div_u64(se->avg.load_sum, se_weight(se));

Seems that this will fit on one line now. No braces needed then.


> +	} else {
> +		se->avg.load_sum = 1;
>  	}
>  
>  	enqueue_load_avg(cfs_rq, se);

Looks like taskgroups are not affected since they get always online
with cpu.shares/weight = 1024 (cgroup v1):

cpu_cgroup_css_online() -> online_fair_sched_group() ->
attach_entity_cfs_rq() -> attach_entity_load_avg()

And reweight_entity() does not have this issue.

Tested with `qemu-system-x86_64 ... cores=64 ... -enable-kvm` and
weight=88761 for nice=0 tasks plus forcing se->avg.load_avg = 1 before
the div_u64() in attach_entity_load_avg().

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
