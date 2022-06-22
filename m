Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8C3CCA473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 02:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbiFVCOm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 22:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFVCOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:14:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D612B19A;
        Tue, 21 Jun 2022 19:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ORveCGym512RighQmyJ26uQ7Z38tEMS5jxlZdRzFA0Q=; b=Q7LfXcfM66qM2ZE6ZtDOCsVX9e
        kMsBRa3Z3eceP8zsLvQg40WnFWBHhJQ6yxgoxnBy5WZTQVppD/4GxA/Kfu56zw6VZXCHH9MQmhQ75
        TKDpfFYuTRTNtimXzdV4nwHmTDgFecSjLdynmneJsID+G1JByy83Y562K4jUhBO7SYjRymx9J5CTI
        ceRuscfMK9Jvpog2Xi36ira6n1gF1Vdt7LHxe8g8sl/dxW1hk7keL33aNKMbKncWwxNbrjM7Wd8x9
        ZMoBo0HluFzzqPppIgYBOeUotvAICwenA7LXtaFDCTfrpLp1aotWJLXU2aBdzLlI7N7P4JVRBpq+Z
        iSYb03CQ==;
Received: from [2601:1c0:6280:3f0::6c43]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3pmh-00AnHm-9p; Wed, 22 Jun 2022 02:09:20 +0000
Message-ID: <862ed496-921f-b21e-48e8-123422b33b4a@infradead.org>
Date:   Tue, 21 Jun 2022 19:06:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] sched: RT bandwidth interface for cgroup unified
 hierarchy
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220622015557.7497-1-zhouchengming@bytedance.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220622015557.7497-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/22 18:55, Chengming Zhou wrote:
> We need to run RT threads in cgroup unified hierarchy, but we can't
> since the default rt_bandwidth.rt_runtime of non-root task_group is 0
> and we haven't interface to update it.
> 
> This patch add RT bandwidth interface "cpu.max.rt" and update the
> documentation accordingly.
> 
> Signed-off-by: Chengming Zhou<zhouchengming@bytedance.com>
> ---
> v2:
>   - minor fix for documentation per Randy's review. Thanks.

Documentation changes look good. Thanks.

> ---
>   Documentation/admin-guide/cgroup-v2.rst | 13 +++++++++++
>   kernel/sched/core.c                     | 31 +++++++++++++++++++++++++
>   kernel/sched/rt.c                       |  2 +-
>   kernel/sched/sched.h                    |  1 +
>   4 files changed, 46 insertions(+), 1 deletion(-)
