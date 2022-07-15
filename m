Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788F9C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 02:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbiGOCvI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 22:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241090AbiGOCvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 22:51:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0094C39BBA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 19:51:04 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LkbQL0QyBzjWy9;
        Fri, 15 Jul 2022 10:48:26 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Jul 2022 10:50:32 +0800
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
To:     Peter Xu <peterx@redhat.com>
CC:     Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
 <Ys2xyCUnqpJt0eIo@monkey> <Ys7ViSsOxLaQJIfy@xz-m1.local>
 <Ys7uXHdzzFezUub5@xz-m1.local>
 <CAJHvVcgqb6R6ePMbgmA8LpMpMgrGWie9ZCTuR4MA77GTvi4XAw@mail.gmail.com>
 <Ys9XAbuxkDUlnmv0@monkey>
 <CAJHvVci9iij+eDV-EWDOtjmWFYo0H+1LkzKBp6=XOpwDA4Jh-g@mail.gmail.com>
 <1a27f20c-ed69-398a-5e6d-bb7ec5f14f5f@huawei.com>
 <YtA6GcRwP7iiJScG@xz-m1.local>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c1b7243c-563f-b260-2a52-f157cf51f080@huawei.com>
Date:   Fri, 15 Jul 2022 10:50:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YtA6GcRwP7iiJScG@xz-m1.local>
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

On 2022/7/14 23:45, Peter Xu wrote:
> On Thu, Jul 14, 2022 at 06:09:49PM +0800, Miaohe Lin wrote:
>> As discussed in another thread, we might call page_dup_file_rmap for newly
>> allocated page (regardless of this patch). So should we come up a seperate
>> patch to call page_add_file_rmap here instead?
> 
> Hmm, why we need page_add_file_rmap() even if a new page allocated?  Say,
> we're at least also using page_dup_file_rmap() in hugetlb_no_page().
> 
> I see majorly two things extra there: memcg accounts on NR_FILE_MAPPED, and
> mlock.  But I assume both of them will not apply to hugetlb pages?

I think you are right. PageDoubleMap is also irrelevant for hugetlb.
page_add_file_rmap shouldn't be called for hugetlb page. It seems
page_dup_file_rmap can be regarded as hugetlb variant of page_add_file_rmap.
Sorry for making noise.

> 

Thanks.
