Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754C3ECAAD1
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 20:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiHaUtB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiHaUs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E78F23CC
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 13:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661978937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/L4MBexlSyJbnVsUjpwEPN+8nGbH3CY4BBC56zylys8=;
        b=a7xRDp8R8E/zKY6BccCWFM1oFfGNNeERnyYE/BEcjtrCmCmhsc8D0AYgpVK7yAiyUHKrMn
        xXoGzNa9QRyrjItgtzDr80kUxJsC+QXVrl9vRIvtarZc2QypDA6nz/cXYGtC6nb34T/xUy
        4Kh9DxVPjOTjneVFhDNGnLt6IJ0BaHc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-CuLNu4B0MJutHIQzxWyTfw-1; Wed, 31 Aug 2022 16:48:53 -0400
X-MC-Unique: CuLNu4B0MJutHIQzxWyTfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 478C3800124;
        Wed, 31 Aug 2022 20:48:52 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C507A40E7F28;
        Wed, 31 Aug 2022 20:48:51 +0000 (UTC)
Message-ID: <9ccb1100-295e-a99b-949b-a400f177c947@redhat.com>
Date:   Wed, 31 Aug 2022 16:48:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 3/5] sched: Enforce user requested affinity
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <20220826010119.1265764-1-longman@redhat.com>
 <20220826010119.1265764-4-longman@redhat.com>
 <Yw8nXttOnNjK/1y4@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yw8nXttOnNjK/1y4@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/31/22 05:18, Peter Zijlstra wrote:
> On Thu, Aug 25, 2022 at 09:01:17PM -0400, Waiman Long wrote:
>
>> @@ -9352,6 +9381,11 @@ int sched_cpu_activate(unsigned int cpu)
>>   		sched_update_numa(cpu, true);
>>   		sched_domains_numa_masks_set(cpu);
>>   		cpuset_cpu_active();
>> +		/*
>> +		 * Preallocated scratch cpumask
>> +		 */
>> +		if (!rq->scratch_mask)
>> +			rq->scratch_mask = kmalloc(cpumask_size(), GFP_KERNEL);
>>   	}
> this is too late; I think you'll have to add a sched_cpu_prepare() and
> simply fail the cpu-up when the allocation fails.
>
That is the reason why I have a fallback allocation in 
__set_cpus_allowed_ptr(). Thanks for the suggestion, I will looking into 
doing that.

Cheers,
Longman

