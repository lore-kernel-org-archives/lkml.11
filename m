Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C14AECAAD3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 09:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiIAJ7U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 05:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiIAJ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:59:17 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FD71377A7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:59:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VO.DDU5_1662026352;
Received: from 30.97.49.1(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0VO.DDU5_1662026352)
          by smtp.aliyun-inc.com;
          Thu, 01 Sep 2022 17:59:13 +0800
Message-ID: <acc065a2-9378-e4fe-9033-d46ebadf2d16@linux.alibaba.com>
Date:   Thu, 1 Sep 2022 17:59:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] sched/core: Fix the bug that sched_core_find() may return
 throttled task
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <1661928558-108473-1-git-send-email-CruzZhao@linux.alibaba.com>
 <YxB1Eu9wTPel8LWu@hirez.programming.kicks-ass.net>
From:   cruzzhao <cruzzhao@linux.alibaba.com>
In-Reply-To: <YxB1Eu9wTPel8LWu@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/1 下午5:02, Peter Zijlstra 写道:
> On Wed, Aug 31, 2022 at 02:49:18PM +0800, Cruz Zhao wrote:
>> When a cfs_rq is throttled, the cookie'd task in this cfs_rq wouldn't
>> dequeue from the core tree, and sched_core_find() may return this task,
>> which will result that the throttled task running on the cpu.
>>
>> To resolve this problem, we pick the first cookie matched task and
>> unthrottled task.
> 
> You mean: first that that both matches the cookie and is not throttled.
> 

Yeah, I mean "the first cookie matched and not throttled task".

> Except I think you can have the same problem with the RT crud.

Sure, there's the same problem with the RT crud.

There's also a problem that the priority of the tasks in the core_tree
won't change since sched_core_enqueue(), but the priority of cfs tasks
will change as vruntime changes. And sched_core_find() may not pick the
cookie matched task with the highest priority.

I tried to combine the core_tree with cfs_rq (dl_rq, rt_rq should also
be considered) to solve this problem, but I haven't come up with a
simple and graceful solution yet.
