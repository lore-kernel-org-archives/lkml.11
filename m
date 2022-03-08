Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64ADC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 12:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346717AbiCHMNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 07:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236809AbiCHMN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:13:29 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4026062E6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 04:12:32 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KCYxB56Xdzbc92;
        Tue,  8 Mar 2022 20:07:42 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 20:12:29 +0800
Subject: Re: [PATCH 13/16] mm/migration: return errno when isolate_huge_page
 failed
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
 <20220304093409.25829-14-linmiaohe@huawei.com>
 <87ilsq5p0x.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <85acb60f-76a6-2cbc-0896-a593531dfc27@huawei.com>
Date:   Tue, 8 Mar 2022 20:12:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87ilsq5p0x.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/7 13:07, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> We should return errno (-EBUSY here) when failed to isolate the huge page
>> rather than always return 1 which could confuse the user.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/migrate.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 6c2dfed2ddb8..279940c0c064 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1618,10 +1618,8 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>>  		goto out_putpage;
>>  
>>  	if (PageHuge(page)) {
>> -		if (PageHead(page)) {
>> -			isolate_huge_page(page, pagelist);
>> -			err = 1;
>> -		}
>> +		if (PageHead(page))
>> +			err = isolate_huge_page(page, pagelist) ? 1 : -EBUSY;
> 
> IMHO, it's better to determine the proper errno inside
> isolate_huge_page() instead of in the caller.  If you think it's
> necessary to get errno here.  How about change isolate_huge_page()
> instead?

IMO, -EBUSY should be enough for the user (as they could not do much) and this
errno keeps consistent with the non-hugetlb page case. What do you think?

Thanks.

> 
> Best Regards,
> Huang, Ying
> 
>>  	} else {
>>  		struct page *head;
> .
> 

