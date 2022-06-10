Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF1DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 07:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346832AbiFJHX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 03:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346820AbiFJHXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:23:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BECA3391
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:23:26 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LKC7c4m4jz1GCCL;
        Fri, 10 Jun 2022 15:21:32 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 15:23:23 +0800
Subject: Re: [v3 PATCH 3/7] mm: khugepaged: remove the redundant anon vma
 check
To:     Yang Shi <shy828301@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <vbabka@suse.cz>, <kirill.shutemov@linux.intel.com>,
        <willy@infradead.org>, <akpm@linux-foundation.org>
References: <20220606214414.736109-1-shy828301@gmail.com>
 <20220606214414.736109-4-shy828301@gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3f485480-9474-4401-bc4f-fb66aac1e591@huawei.com>
Date:   Fri, 10 Jun 2022 15:23:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220606214414.736109-4-shy828301@gmail.com>
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

On 2022/6/7 5:44, Yang Shi wrote:
> The hugepage_vma_check() already checked it, so remove the redundant
> check.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/khugepaged.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index d0f8020164fc..7a5d1c1a1833 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -966,9 +966,6 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>  		return SCAN_ADDRESS_RANGE;
>  	if (!hugepage_vma_check(vma, vma->vm_flags))
>  		return SCAN_VMA_CHECK;
> -	/* Anon VMA expected */
> -	if (!vma->anon_vma || !vma_is_anonymous(vma))
> -		return SCAN_VMA_CHECK;

Is it possible that hugepage_vma_check returns true due to the shmem check, or file thp check since
we dropped mmap_lock ? So anon vma is explicitly checked again here?

Thanks!

>  	return 0;
>  }
>  
> 

