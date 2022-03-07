Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBF0C433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 12:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiCGMMs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbiCGMMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:12:44 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042AE7B56B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:11:49 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KBy2p53RtzdZlC;
        Mon,  7 Mar 2022 20:10:26 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 20:11:46 +0800
Subject: Re: [PATCH 12/16] mm/migration: fix potential page refcounts leak in
 migrate_pages
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <shy828301@gmail.com>, <willy@infradead.org>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <ave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-13-linmiaohe@huawei.com>
 <87r17e5pat.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3a93cba2-c877-73c6-e355-0b73fcb02cc6@huawei.com>
Date:   Mon, 7 Mar 2022 20:11:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87r17e5pat.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/7 13:01, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> In -ENOMEM case, there might be some subpages of fail-to-migrate THPs
>> left in thp_split_pages list. We should move them back to migration
>> list so that they could be put back to the right list by the caller
>> otherwise the page refcnt will be leaked here. Also adjust nr_failed
>> and nr_thp_failed accordingly to make vm events account more accurate.
>>
>> Fixes: b5bade978e9b ("mm: migrate: fix the return value of migrate_pages()")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/migrate.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index e0db06927f02..6c2dfed2ddb8 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1422,6 +1422,15 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  				}
>>  
>>  				nr_failed_pages += nr_subpages;
>> +				/*
>> +				 * There might be some subpages of fail-to-migrate THPs
>> +				 * left in thp_split_pages list. Move them back to migration
>> +				 * list so that they could be put back to the right list by
>> +				 * the caller otherwise the page refcnt will be leaked.
>> +				 */
>> +				list_splice_init(&thp_split_pages, from);
>> +				nr_failed += retry;
> 
> It appears that we don't need to change nr_failed, because we don't use
> it for this situation.  Otherwise looks good to me.
> 

You're right. nr_failed is not used for this case.

> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Many thanks for your review.

> 
> Best Regards,
> Huang, Ying
> 
>> +				nr_thp_failed += thp_retry;
>>  				goto out;
>>  			case -EAGAIN:
>>  				if (is_thp)
> .
> 

