Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F36EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 12:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384815AbiDUMdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Apr 2022 08:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384629AbiDUMdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:33:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AD0820BE3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:30:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 338171480;
        Thu, 21 Apr 2022 05:30:12 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6C773F5A1;
        Thu, 21 Apr 2022 05:30:10 -0700 (PDT)
Message-ID: <13b9fa7f-7ac9-5c1e-a0ff-6b57cb38f28c@arm.com>
Date:   Thu, 21 Apr 2022 14:30:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] sched/core: Avoid obvious double update_rq_clock warning
Content-Language: en-US
To:     Hao Jia <jiahao.os@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220418090929.54005-1-jiahao.os@bytedance.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220418090929.54005-1-jiahao.os@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2022 11:09, Hao Jia wrote:

[...]

> -	/*
> -	 * Update the later_rq clock here, because the clock is used
> -	 * by the cpufreq_update_util() inside __add_running_bw().
> -	 */
> -	update_rq_clock(later_rq);
> -	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
> +	activate_task(later_rq, next_task, 0);

IMHO, this change should go in a separate deadline patch.

The change to call update_rq_clock() before activate_task()
(840d719604b09) is no longer needed since f4904815f97a removed the
add_running_bw() before the activate_task().

[...]
