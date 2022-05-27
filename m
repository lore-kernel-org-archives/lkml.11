Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D87C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 01:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiE0BLB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 21:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiE0BK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 21:10:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF990EABBC
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 18:10:56 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L8RXd5NnvzgYQC;
        Fri, 27 May 2022 09:09:21 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 09:10:54 +0800
Subject: Re: [PATCH] mm/page_table_check: fix accessing unmapped ptep
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <zhengqi.arch@bytedance.com>, Matthew Wilcox <willy@infradead.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220526113350.30806-1-linmiaohe@huawei.com>
 <Yo+B4b0nF+kI35pG@casper.infradead.org>
 <CA+CK2bBBLjr3kGqc=zA6M5773G6gj83LB_kwwOCNuFX8YoUp+w@mail.gmail.com>
 <20220526111546.50102da288cccbe913cadbf4@linux-foundation.org>
 <CA+CK2bBJ3baj2Qt+9Wy1r==_Uym_UZJ+S-HRwFAsspPamctk_Q@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <fe21e0c9-50d3-0a4b-00b4-22a5dfd6711e@huawei.com>
Date:   Fri, 27 May 2022 09:10:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bBJ3baj2Qt+9Wy1r==_Uym_UZJ+S-HRwFAsspPamctk_Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/27 2:31, Pasha Tatashin wrote:
>>> Miaohe, please store the ptep, or maybe drop this patch entirely.
>>
>> I think it's best to fix it.  I rewrote the changelog as
>>
>> : ptep is unmapped too early, so ptep could theoretically be accessed while
>> : it's unmapped.  This might become a problem if/when CONFIG_HIGHPTE becomes
>> : available on riscv.
>> :
>> : Fix it by deferring pte_unmap() until page table checking is done.
>>
>> I'll retain the Fixes:.  This doesn't imply cc:stable in MM, and anyone
>> who backports the original patchset will want to know about this fixup.
> Makes sense.
> 
> 
>> And I queued a fixup for the thing Matthew noticed.
> Thank you Andrew.
> 

Many thanks for all of your comments, review and fixup! :)

> Pasha
> .
> 

