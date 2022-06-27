Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB03C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 05:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiF0F5B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 01:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiF0F46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 01:56:58 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750E055A8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 22:56:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VHTLmIl_1656309413;
Received: from 30.97.48.150(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VHTLmIl_1656309413)
          by smtp.aliyun-inc.com;
          Mon, 27 Jun 2022 13:56:53 +0800
Message-ID: <7b98cabf-9a8f-2dcb-a410-9a8f9611ae88@linux.alibaba.com>
Date:   Mon, 27 Jun 2022 13:56:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/7] migrate_pages(): fix failure counting for THP
 subpages retrying
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
References: <20220624025309.1033400-1-ying.huang@intel.com>
 <20220624025309.1033400-5-ying.huang@intel.com>
 <f2e1ea63-d0ca-7a80-fc16-90622ef2017d@linux.alibaba.com>
 <87zghy7ua0.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <22f7b831-7734-2969-a477-473c4367f61e@linux.alibaba.com>
 <87r13a7n04.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87r13a7n04.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/2022 12:23 PM, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> On 6/27/2022 9:46 AM, Huang, Ying wrote:
>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>>
>>>> On 6/24/2022 10:53 AM, Huang Ying wrote:
>>>>> If THP is failed to be migrated for -ENOSYS and -ENOMEM, the THP will
>>>>> be split into thp_split_pages, and after other pages are migrated,
>>>>> pages in thp_split_pages will be migrated with no_subpage_counting ==
>>>>> true, because its failure have been counted already.  If some pages in
>>>>> thp_split_pages are retried during migration, we should not count
>>>>> their failure if no_subpage_counting == true too.  This is done this
>>>>> patch to fix the failure counting for THP subpages retrying.
>>>>
>>>> Good catch. Totally agree with you. It seems we can move the condition
>>>> into -EAGAIN case like other cases did?
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 1ece23d80bc4..491c2d07402b 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -1463,7 +1463,7 @@ int migrate_pages(struct list_head *from,
>>>> new_page_t get_new_page,
>>>>                           case -EAGAIN:
>>>>                                   if (is_thp)
>>>>                                           thp_retry++;
>>>> -                               else
>>>> +                               else if (!no_subpage_counting)
>>>>                                           retry++;
>>>>                                   break;
>>> This has another effect except fixing the failure counting.  That
>>> is,
>>> the split subpages of THP will not be retried for 10 times for -EAGAIN.
>>
>> Ah, yes.
>>
>>> TBH, I think that we should do that.  But because this has some behavior
>>
>> OK. So you afraid that 10 times retry for each subpage of THP will
>> waste lots of time?
> 
> I just think that it's unnecessary.  We have already regarded the
> migration as failed.  And for the worst case, we will try 512 * 10 =
> 5120 times in total.
> 
>>> change, it's better to be done in a separate patch?  Do you have
>>> interest to do that on top of this patchset?
>>
>> Sure. I can send a patch which can be folded into your series. Is this
>> OK for you?
>>
>> By the way, if I do like I said, the patch 4 can be avoided.
> 
> I tend to keep both.  [4/7] is just a fix.  You patch will introduce the
> behavior change.  And your patch needn't to be folded into this series.
> You can send it and push it separately.

OK. Thanks.
