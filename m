Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CEAC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jul 2022 02:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiGMCLE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 22:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGMCK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 22:10:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DD3C748C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 19:10:58 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LjLdT3r0tzkWbm;
        Wed, 13 Jul 2022 10:08:45 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 10:10:56 +0800
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <akpm@linux-foundation.org>, <songmuchun@bytedance.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
 <Ys2xyCUnqpJt0eIo@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1f9e8378-f61c-5bfe-1c47-fbaf0dc4f51a@huawei.com>
Date:   Wed, 13 Jul 2022 10:10:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Ys2xyCUnqpJt0eIo@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/13 1:39, Mike Kravetz wrote:
> On 07/12/22 21:05, Miaohe Lin wrote:
>> In MCOPY_ATOMIC_CONTINUE case with a non-shared VMA, pages in the page
>> cache are installed in the ptes. But hugepage_add_new_anon_rmap is called
>> for them mistakenly because they're not vm_shared. This will corrupt the
>> page->mapping used by page cache code.
>>
>> Fixes: f619147104c8 ("userfaultfd: add UFFDIO_CONTINUE ioctl")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/hugetlb.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This looks correct to me.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Many thanks for review.

> 
> However, I am having a hard time wrapping my head around how UFFDIO_CONTINUE
> should work on non-anon private mappings.  For example, a private mapping of
> a hugetlbfs file.  I think we just map the page in the file/cache and do not
> set the write bit in the pte.  So, yes we would want page_dup_file_rmap()
> in this case as shown below.

+1

> 
> Adding Axel and Peter on Cc: as they were more involved in adding that code
> and the design of UFFDIO_CONTINUE.

That would be really helpful.

Thanks.

> 

