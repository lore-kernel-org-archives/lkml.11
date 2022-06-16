Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150C0C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 16:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377391AbiFPQUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 12:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiFPQU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:20:27 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1060D2FFD1;
        Thu, 16 Jun 2022 09:20:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VGasHmk_1655396420;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VGasHmk_1655396420)
          by smtp.aliyun-inc.com;
          Fri, 17 Jun 2022 00:20:21 +0800
Subject: Re: [PATCH] mm: page_alloc: validate buddy page before using
To:     akpm@linux-foundation.org, ziy@nvidia.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org,
        guoren@kernel.org
Cc:     huanyi.xj@alibaba-inc.com, guohanjun@huawei.com,
        zjb194813@alibaba-inc.com, tianhu.hh@alibaba-inc.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220616161746.3565225-1-xianting.tian@linux.alibaba.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <b08725b1-2f4b-cea0-43fc-1ce0a2a7e8f4@linux.alibaba.com>
Date:   Fri, 17 Jun 2022 00:20:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220616161746.3565225-1-xianting.tian@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore this one.

ÔÚ 2022/6/17 ÉÏÎç12:17, Xianting Tian Ð´µÀ:
> Commit 787af64d05cd ("mm: page_alloc: validate buddy before check its migratetype.")
> fixes a bug in 1dd214b8f21c and there is a similar bug in d9dddbf55667 that
> can be fixed in a similar way too.
>
> In addition, for RISC-V arch the first 2MB RAM could be reserved for opensbi,
> so it would have pfn_base=512 and mem_map began with 512th PFN when
> CONFIG_FLATMEM=y.
> But __find_buddy_pfn algorithm thinks the start pfn 0, it could get 0 pfn or
> less than the pfn_base value. We need page_is_buddy() to verify the buddy to
> prevent accessing an invalid buddy.
>
> Fixes: d9dddbf55667 ("mm/page_alloc: prevent merging between isolated and other pageblocks")
> Cc: stable@vger.kernel.org
> Reported-by: zjb194813@alibaba-inc.com
> Reported-by: tianhu.hh@alibaba-inc.com
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>   mm/page_alloc.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a6e682569e5b..1c423faa4b62 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -864,6 +864,9 @@ static inline void __free_one_page(struct page *page,
>   
>   			buddy_idx = __find_buddy_index(page_idx, order);
>   			buddy = page + (buddy_idx - page_idx);
> +
> +			if (!page_is_buddy(page, buddy, order))
> +				goto done_merging;
>   			buddy_mt = get_pageblock_migratetype(buddy);
>   
>   			if (migratetype != buddy_mt
