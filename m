Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C20BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 19:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiDFT6v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 15:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiDFT4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:56:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CD9619C80A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 10:26:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0399612FC;
        Wed,  6 Apr 2022 10:26:10 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 890FA3F5A1;
        Wed,  6 Apr 2022 10:26:08 -0700 (PDT)
Message-ID: <44ca58cf-3daa-bec5-2c52-eb5a6dd305b9@arm.com>
Date:   Wed, 6 Apr 2022 19:25:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] sched/fair: Return the busiest group only if imbalance is
 meaningful
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?B?5b2t5b+X5Yia?= <zgpeng.linux@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, Benjamin Segall <bsegall@google.com>,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
References: <1649244204-23471-1-git-send-email-zgpeng@tencent.com>
 <CAKfTPtDh7qFpdjsEBvT34WEgW8uGbdwsZnyXjq4KpAcOse9Pew@mail.gmail.com>
 <CAE5vP3=ZPGV=PuYb-WJsoQ8tX4yDAjajT_WRU+7gAiW54XgX_g@mail.gmail.com>
 <CAKfTPtA8VjZ-F3vdiKJtpij6PUxu_OR7-54cG6NcS_K7guHF6g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKfTPtA8VjZ-F3vdiKJtpij6PUxu_OR7-54cG6NcS_K7guHF6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2022 17:33, Vincent Guittot wrote:
> On Wed, 6 Apr 2022 at 17:07, 彭志刚 <zgpeng.linux@gmail.com> wrote:

[...]

> I think that this case should be covered by an additional test in
> calculate_imbalance because we should not try to pull load in groupA
> if it's already above  the average load. Something like below should
> cover this
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9469,6 +9469,16 @@ static inline void calculate_imbalance(struct
> lb_env *env, struct sd_lb_stats *s
> 
>                 sds->avg_load = (sds->total_load * SCHED_CAPACITY_SCALE) /
>                                 sds->total_capacity;
> +
> +               /*
> +                * Don't pull any tasks if this group is already above the
> +                * domain average load.
> +                */
> +               if (local->avg_load >= sds->avg_load) {
> +                       env->imbalance = 0;
> +                       return;
> +               }
> +

LGTM. Like for the `local->group_type == group_overloaded` case in
find_busiest_group() where we force `goto out_balanced`.

[...]
