Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D310C19F28
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Aug 2022 09:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbiHCJ0D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Aug 2022 05:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbiHCJZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:25:57 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891C55A14F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:25:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VLGENyx_1659518750;
Received: from 30.178.80.143(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VLGENyx_1659518750)
          by smtp.aliyun-inc.com;
          Wed, 03 Aug 2022 17:25:51 +0800
Message-ID: <10f7d339-c451-8284-ccd8-ce9a0fe14f48@linux.alibaba.com>
Date:   Wed, 3 Aug 2022 17:25:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [PATCH] sched/debug: avoid executing show_state and causing rcu
 stall warning
To:     Ingo Molnar <mingo@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <1659489525-82994-1-git-send-email-liusong@linux.alibaba.com>
 <Yuo0U2aWUZRLBAsA@gmail.com>
 <c4058896-947d-c802-ac57-bf03eb986378@linux.alibaba.com>
 <Yuo7eYzQnzqx4u7F@gmail.com>
From:   Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <Yuo7eYzQnzqx4u7F@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> * Liu Song <liusong@linux.alibaba.com> wrote:
>
>>> * Liu Song <liusong@linux.alibaba.com> wrote:
>>>
>>>> From: Liu Song <liusong@linux.alibaba.com>
>>>>
>>>> If the number of CPUs is large, "sysrq_sched_debug_show" will execute for
>>>> a long time. Every time I execute "echo t > /proc/sysrq-trigger" on my
>>>> 128-core machine, the rcu stall warning will be triggered. Moreover,
>>>> sysrq_sched_debug_show does not need to be protected by rcu_read_lock,
>>>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>> and no rcu stall warning will appear after adjustment.
>>>>
>>> That doesn't mean it doesn't have to be protected by *any* lock - which
>>> your patch implements AFAICS.
>>>
>>> There's a couple of lines such as:
>>>
>>>           for_each_online_cpu(cpu) {
>> Hi,
>>
>> Here I refer to the implementation of "sysrq_timer_list_show", and I don't
>> see any lock.
>>
>> Maybe there is a problem with the implementation of "sysrq_timer_list_show".
> But we are talking about sysrq_sched_debug_show(), which your patch tries
> to relax the RCU locking of.

Hi,

I'm not sure for_each_online_cpu && print_cpu must need a lock to 
protect, so I refer to other codes

under kernel that reference the implementation. It looks like some 
places use "get_online_cpus" to prevent

cpu hotplug, but many places don't have obvious protection, so I'm also 
confused if protection is necessarily

required.


Thanks

>
> Thanks,
>
> 	Ingo
