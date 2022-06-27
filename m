Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB77FC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 08:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbiF0Icy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 04:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiF0Icx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:32:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242706267
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:32:51 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LWgtW535ZzkWKZ;
        Mon, 27 Jun 2022 16:31:31 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 16:32:48 +0800
Subject: Re: [PATCH v2 5/9] mm, hwpoison: make unpoison aware of raw error
 info in hwpoisoned hugepage
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-6-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ea1d17d8-89df-04b7-29e8-0da53dbd3312@huawei.com>
Date:   Mon, 27 Jun 2022 16:32:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220623235153.2623702-6-naoya.horiguchi@linux.dev>
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

On 2022/6/24 7:51, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Raw error info list needs to be removed when hwpoisoned hugetlb is
> unpoisioned.  And unpoison handler needs to know how many errors there
> are in the target hugepage. So add them.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

snip

> @@ -2255,7 +2275,7 @@ int unpoison_memory(unsigned long pfn)
>  unlock_mutex:
>  	mutex_unlock(&mf_mutex);
>  	if (!ret || freeit) {
> -		num_poisoned_pages_dec();
> +		num_poisoned_pages_sub(count);

IIUC, num_poisoned_pages will only be incremented once for hugetlb page. If many
subpages are hwpoisoned, they will reach the "else if (res == -EHWPOISON)" path
in try_memory_failure_hugetlb and thus num_poisoned_pages_inc is ignored. Maybe
that should be changed so subpages can contribute to the num_poisoned_pages
or should we just do num_poisoned_pages_dec here? Or am I miss something?

Thanks!

>  		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
>  				 page_to_pfn(p), &unpoison_rs);
>  	}
> 

