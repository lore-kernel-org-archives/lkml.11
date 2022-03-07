Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD4CC433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 01:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiCGB53 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Mar 2022 20:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiCGB52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 20:57:28 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DCA13DF8
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 17:56:34 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0V6OHp72_1646618187;
Received: from 30.97.48.83(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V6OHp72_1646618187)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 09:56:29 +0800
Message-ID: <20f47ec9-3b5b-5326-b1c3-4b1a0c38ef46@linux.alibaba.com>
Date:   Mon, 7 Mar 2022 09:57:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 12/16] mm/migration: fix potential page refcounts leak in
 migrate_pages
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     mike.kravetz@oracle.com, shy828301@gmail.com, willy@infradead.org,
        ying.huang@intel.com, ziy@nvidia.com, minchan@kernel.org,
        apopple@nvidia.com, ave.hansen@linux.intel.com,
        o451686892@gmail.com, almasrymina@google.com, jhubbard@nvidia.com,
        rcampbell@nvidia.com, peterx@redhat.com, naoya.horiguchi@nec.com,
        mhocko@suse.com, riel@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-13-linmiaohe@huawei.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220304093409.25829-13-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaohe,

On 3/4/2022 5:34 PM, Miaohe Lin wrote:
> In -ENOMEM case, there might be some subpages of fail-to-migrate THPs
> left in thp_split_pages list. We should move them back to migration
> list so that they could be put back to the right list by the caller
> otherwise the page refcnt will be leaked here. Also adjust nr_failed
> and nr_thp_failed accordingly to make vm events account more accurate.
> 
> Fixes: b5bade978e9b ("mm: migrate: fix the return value of migrate_pages()")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/migrate.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e0db06927f02..6c2dfed2ddb8 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1422,6 +1422,15 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   				}
>   
>   				nr_failed_pages += nr_subpages;
> +				/*
> +				 * There might be some subpages of fail-to-migrate THPs
> +				 * left in thp_split_pages list. Move them back to migration
> +				 * list so that they could be put back to the right list by
> +				 * the caller otherwise the page refcnt will be leaked.
> +				 */
> +				list_splice_init(&thp_split_pages, from);
> +				nr_failed += retry;
> +				nr_thp_failed += thp_retry;

Yes, I think we missed this case before, and your patch looks right. But 
we should also update the 'rc' to return the correct number of pages 
that were not migrated, right?
