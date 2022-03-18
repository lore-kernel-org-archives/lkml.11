Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B12C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 14:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbiCROMa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 10:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbiCROMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:12:24 -0400
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A6F95484
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:11:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V7WdvNv_1647612657;
Received: from 30.0.159.17(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V7WdvNv_1647612657)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Mar 2022 22:10:58 +0800
Message-ID: <ecc17ef5-1ae8-823c-e4f6-0a1dc4d71201@linux.alibaba.com>
Date:   Fri, 18 Mar 2022 22:12:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm/damon: Make the sampling more accurate
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220318121543.26861-1-sj@kernel.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220318121543.26861-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2022 8:15 PM, sj@kernel.org wrote:
> On Fri, 18 Mar 2022 19:58:07 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>>
>>
>> On 3/18/2022 6:49 PM, sj@kernel.org wrote:
>>> On Fri, 18 Mar 2022 18:01:19 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>
>>>>
>>>> On 3/18/2022 5:40 PM, sj@kernel.org wrote:
>>>>> Hi Baolin,
>>>>>
>>>>> On Fri, 18 Mar 2022 17:23:13 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>>>
>>>>>> When I try to sample the physical address with DAMON to migrate pages
>>>>>> on tiered memory system, I found it will demote some cold regions mistakenly.
>>>>>> Now we will choose an physical address in the region randomly, but if
>>>>>> its corresponding page is not an online LRU page, we will ignore the
>>>>>> accessing status in this cycle of sampling, and actually will be treated
>>>>>> as a non-accessed region. Suppose a region including some non-LRU pages,
>>>>>> it will be treated as a cold region with a high probability, and may be
>>>>>> merged with adjacent cold regions, but there are some pages may be
>>>>>> accessed we missed.
>>>>>>
>>>>>> So instead of ignoring the access status of this region if we did not find
>>>>>> a valid page according to current sampling address, we can use last valid
>>>>>> sampling address to help to make the sampling more accurate, then we can do
>>>>>> a better decision.
>>>>>
>>>>> Well...  Offlined pages are also a valid part of the memory region, so treating
>>>>> those as not accessed and making the memory region containing the offlined
>>>>> pages looks colder seems legal to me.  IOW, this approach could make memory
>>>>> regions containing many non-online-LRU pages as hot.
>>>>
>>>> IMO I don't think this is a problem, since if this region containing
>>>> many non-online-LRU pages is treated as hot, which means threre are aome
>>>> pages are hot, right? We can find them and promote them to fast memory
>>>> (or do other schemes). Meanwhile, for non-online-LRU pages, we can
>>>> filter them and do nothing for them, since we can not get a valid page
>>>> struct for them.
>>>
>>> For some of DAMOS actions that you mentioned, that could make sense.  However,
>>> that wouldn't make much sense for some other cases, especially for manual
>>> DAMON-based access pattern profiling.
>>
>> I am not sure about this case, could you elaborate on how this can worse
>> the case you mentioned?
> 
> For an example, let's suppose a user using DAMON to know the working set size
> of the system.  And further suppose there is a region that containing many
> offlined pages and one online hot page.  With this patch, once DAMON sampled
> the one hot page, the entire region will be reported as hot, though the other
> offlined pages has not accessed.  As a result, the user will think the working
> set size is bigger than real.

OK, sounds reasonable. Seems I need add a flag to indicate if we should 
ignore offline or non-lru pages when monitoring for some schemes, which 
can help to do a good decision.

