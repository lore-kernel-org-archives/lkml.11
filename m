Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C34C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Jul 2022 14:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiGCOuF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Jul 2022 10:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGCOuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:50:03 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3834F10DC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 07:50:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VIBbbSf_1656859791;
Received: from 30.0.187.160(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VIBbbSf_1656859791)
          by smtp.aliyun-inc.com;
          Sun, 03 Jul 2022 22:49:53 +0800
Message-ID: <8118e1b7-ba6c-ef7d-3f9f-98dd2e489dee@linux.alibaba.com>
Date:   Sun, 3 Jul 2022 22:49:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v3 2/3] mm: Add PUD level pagetable account
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
 <6a6a768634b9ce8537154264e35e6a66a79b6ca8.1656586863.git.baolin.wang@linux.alibaba.com>
 <Yr2wlqQkpsffTvd/@linux.ibm.com>
 <1234a28a-dca0-5836-9066-4ab2d4fbcc95@linux.alibaba.com>
 <YsEPwvgUd0sIjso/@casper.infradead.org>
 <17df0d3c-caaf-ee34-f702-1d4e7674887f@linux.alibaba.com>
 <YsGnf33G/z1NOql1@linux.ibm.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YsGnf33G/z1NOql1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/2022 10:28 PM, Mike Rapoport wrote:
> On Sun, Jul 03, 2022 at 10:06:32PM +0800, Baolin Wang wrote:
>>
>>
>> On 7/3/2022 11:40 AM, Matthew Wilcox wrote:
>>> On Fri, Jul 01, 2022 at 04:04:21PM +0800, Baolin Wang wrote:
>>>>> Using pgtable_pud_page_ctor() and pgtable_pud_page_dtor() would be
>>>>> consistent with what we currently have for PTEs and PMDs.
>>>>>
>>>>> This applies to all the additions of pgtable_page_dec() and
>>>>> pgtable_page_inc().
>>>>
>>>> OK. I can add pgtable_pud_page_ctor() and pgtable_pud_page_dtor() helpers to
>>>> keep consistent, which are just wrappers of pgtable_page_inc() and
>>>> pgtable_page_dec().
>>>
>>> I think you misunderstand Mike.
>>>
>>> Don't add pgtable_page_inc() and pgtable_page_dec().  Just add
>>> pgtable_pud_page_ctor() and pgtable_pud_page_dtor().  At least, that
>>> was what I said last time you posted these patches.
>>
>> My concern is that I need another helpers for kernel page table allocation
>> helpers, if only adding pgtable_pud_page_ctor() and pgtable_pud_page_dtor()
>> like below:
>>
>> static inline void pgtable_pud_page_ctor(struct page *page)
>> {
>> 	__SetPageTable(page);
>> 	inc_lruvec_page_state(page, NR_PAGETABLE);
>> }
>>
>> static inline void pgtable_pud_page_dtor(struct page *page)
>> {
>> 	__ClearPageTable(page);
>> 	dec_lruvec_page_state(page, NR_PAGETABLE);
>> }
>>
>> So for kernel pte page table allocation, I need another similar helpers like
>> below. However they do the samething with
>> pgtable_pud_page_ctor/pgtable_pud_page_dtor, so I am not sure this is good
>> for adding these duplicate code.
>>
>> static inline void pgtable_kernel_pte_page_ctor(struct page *page)
>> {
>> 	__SetPageTable(page);
>> 	inc_lruvec_page_state(page, NR_PAGETABLE);
>> }
>>
>> static inline void pgtable_kernel_pte_page_dtor(struct page *page)
>> {
>> 	__ClearPageTable(page);
>> 	dec_lruvec_page_state(page, NR_PAGETABLE);
>> }
>>
>> Instead adding a common helpers seems more readable to me, which can also
>> simplify original pgtable_pmd_page_dtor()/pgtable_pmd_page_ctor(). Something
>> like below.
>>
>> static inline void pgtable_page_inc(struct page *page)
>> {
>> 	__SetPageTable(page);
>> 	inc_lruvec_page_state(page, NR_PAGETABLE);
>> }
>>
>> static inline void pgtable_page_dec(struct page *page)
>> {
>> 	__ClearPageTable(page);
>> 	dec_lruvec_page_state(page, NR_PAGETABLE);
>> }
>>
>> static inline void pgtable_pud_page_ctor(struct page *page)
>> {
>> 	pgtable_page_inc(page);
>> }
>>
>> static inline void pgtable_pud_page_dtor(struct page *page)
>> {
>> 	pgtable_page_dec(page);
>> }
>>
>> For kernel pte page table, we can just use
>> pgtable_page_inc/pgtable_page_dec(), or adding
>> pgtable_kernel_pte_page_ctor/pgtable_kernel_pte_page_dtor, which just
>> wrappers of pgtable_page_inc() and pgtable_page_dec().
>>
>> Matthew and Mike, how do you think? Thanks.
> 
> I actually meant to add pgtable_pud_page_ctor/dtor() as a wrapper for the
> new helper to keep pud tables allocation consistent with pmd and pte and
> as a provision for the time we'll have per-page pud locks.
> 
> For the accounting of the kernel page tables a new helper does make sense
> because there are no locks to initialize for the kernel page tables.

Thanks for clarification. That is also my thought.

> 
> I can't say that I'm happy with the pgtable_page_inc/dec names, though.
> 
> Maybe page_{set,clear}_pgtable()?

Sounds better than pgtable_page_inc/dec() for me. I will use them in 
next version if no other objections. Thanks.
