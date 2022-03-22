Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C052C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 15:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiCVQA7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 12:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiCVQAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:00:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE0777B135
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:59:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62D77ED1;
        Tue, 22 Mar 2022 08:59:27 -0700 (PDT)
Received: from [10.0.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E95C93F73B;
        Tue, 22 Mar 2022 08:59:25 -0700 (PDT)
Message-ID: <bc66bee6-7c99-b289-f5e9-ccaf03d5605d@arm.com>
Date:   Tue, 22 Mar 2022 15:59:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2] cpu/hotplug: Set st->cpu earlier
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20220316153637.288199-1-steven.price@arm.com>
 <878rt2atre.ffs@tglx>
From:   Vincent Donnefort <vincent.donnefort@arm.com>
In-Reply-To: <878rt2atre.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/03/2022 15:31, Thomas Gleixner wrote:
> On Wed, Mar 16 2022 at 15:36, Steven Price wrote:
>> Setting the 'cpu' member of struct cpuhp_cpu_state in cpuhp_create() is
>> too late as other callbacks can be made before that point.
> 
> What?
> 
>          CPUHP_OFFLINE = 0,
>          CPUHP_CREATE_THREADS,
> 
> The create threads callback is the very first callback which is invoked
> for a to be plugged CPU on the control CPU. So which earlier callback
> can be invoked and fail?
> 
> Thanks,
> 
>          tglx


CPUHP_CREATE_THREADS itself can fail, before st->cpu is set. Also, that 
value is used outside of the callbacks (cpuhp_set_state() in _cpu_up()).

But indeed this description could be refined a bit.
