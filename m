Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BF2CCA47B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 03:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiGLDA5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 23:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGLDAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 23:00:55 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B201D0D1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:00:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VJ6IizN_1657594851;
Received: from 30.97.48.63(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VJ6IizN_1657594851)
          by smtp.aliyun-inc.com;
          Tue, 12 Jul 2022 11:00:52 +0800
Message-ID: <801e4f05-6097-4537-9715-2e00a3990f7d@linux.alibaba.com>
Date:   Tue, 12 Jul 2022 11:00:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] hugetlb: fix memoryleak in hugetlb_mcopy_atomic_pte
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, songmuchun@bytedance.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220709092629.54291-1-linmiaohe@huawei.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220709092629.54291-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/2022 5:26 PM, Miaohe Lin wrote:
> When alloc_huge_page fails, *pagep is set to NULL without put_page first.
> So the hugepage indicated by *pagep is leaked.
> 
> Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/hugetlb.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 06c2d86b1ba3..598c37279fee 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5962,6 +5962,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>   
>   		page = alloc_huge_page(dst_vma, dst_addr, 0);
>   		if (IS_ERR(page)) {
> +			put_page(*pagep);
>   			ret = -ENOMEM;
>   			*pagep = NULL;
>   			goto out;
