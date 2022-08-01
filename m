Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850C6C19F2C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 02:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbiHACdk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Jul 2022 22:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbiHACdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:33:38 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D7C11821
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:33:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VL-EnUW_1659321212;
Received: from 30.97.48.40(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VL-EnUW_1659321212)
          by smtp.aliyun-inc.com;
          Mon, 01 Aug 2022 10:33:33 +0800
Message-ID: <294083c1-2049-350c-52a8-5a39a7a7d229@linux.alibaba.com>
Date:   Mon, 1 Aug 2022 10:33:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm: migrate: Do not retry 10 times for the subpages of
 fail-to-migrate THP
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, ziy@nvidia.com, shy828301@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1658405108-100658-1-git-send-email-baolin.wang@linux.alibaba.com>
 <875yjhoj7g.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <875yjhoj7g.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2022 2:16 PM, Huang, Ying wrote:
> Hi, Baolin,
> 
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> If THP is failed to migrate due to -ENOSYS or -ENOMEM case, the THP will
>> be split, and the subpages of fail-to-migrate THP will be tried to migrate
>> again, so we should not account the retry counter in the second loop, since
>> we already accounted 'nr_thp_failed' in the first loop.
>>
>> Moreover we also do not need retry 10 times for -EAGAIN case for the subpages
>> of fail-to-migrate THP in the second loop, since we already regarded the
>> THP as migration failure, and save some migration time (for the worst case,
>> will try 512 * 10 times) according to previous discussion [1].
>>
>> [1] https://lore.kernel.org/linux-mm/87r13a7n04.fsf@yhuang6-desk2.ccr.corp.intel.com/
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> I have tested this patch, and it works as expected.
> 
> Tested-by: "Huang, Ying" <ying.huang@intel.com>

Thanks.

> 
>> ---
>> Note, this patch is based on the patch set [1] from Huang Ying.
>> [1] https://lore.kernel.org/linux-mm/20220711084948.274787-1-ying.huang@intel.com/
> 
> Please this patch is based on my patchset that hasn't been merged.  I
> can add it as the last patch of my migrate_pages failure path fixing
> patchset if you don't object.

Sure, please fold it into your series. Thanks for helping.
