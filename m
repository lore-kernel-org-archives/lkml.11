Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961A5C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Jul 2022 10:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiGBKMq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Jul 2022 06:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiGBKMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 06:12:41 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD38918B2F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 03:12:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VI6PZke_1656756754;
Received: from 30.39.96.230(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VI6PZke_1656756754)
          by smtp.aliyun-inc.com;
          Sat, 02 Jul 2022 18:12:35 +0800
Message-ID: <0bcb98ed-0e35-7242-377a-fee4eb751452@linux.alibaba.com>
Date:   Sat, 2 Jul 2022 18:12:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] arm64: mm: fix linear mapping mem access performance
 degradation
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     baolin.wang@linux.alibaba.com, will@kernel.org,
        akpm@linux-foundation.org, david@redhat.com, jianyong.wu@arm.com,
        james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org,
        geert+renesas@glider.be, ardb@kernel.org, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
References: <1656586222-98555-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <Yr8tzOJi5CGBl767@arm.com>
From:   "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <Yr8tzOJi5CGBl767@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

在 2022/7/2 1:24, Catalin Marinas 写道:
> On Thu, Jun 30, 2022 at 06:50:22PM +0800, Guanghui Feng wrote:
>> +static void init_pmd_remap(pud_t *pudp, unsigned long addr, unsigned long end,
>> +			   phys_addr_t phys, pgprot_t prot,
>> +			   phys_addr_t (*pgtable_alloc)(int), int flags)
>> +{
>> +	unsigned long next;
>> +	pmd_t *pmdp;
>> +	phys_addr_t map_offset;
>> +	pmdval_t pmdval;
>> +
>> +	pmdp = pmd_offset(pudp, addr);
>> +	do {
>> +		next = pmd_addr_end(addr, end);
>> +
>> +		if (!pmd_none(*pmdp) && pmd_sect(*pmdp)) {
>> +			phys_addr_t pte_phys = pgtable_alloc(PAGE_SHIFT);
>> +			pmd_clear(pmdp);
>> +			pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN;
>> +			if (flags & NO_EXEC_MAPPINGS)
>> +				pmdval |= PMD_TABLE_PXN;
>> +			__pmd_populate(pmdp, pte_phys, pmdval);
>> +			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> 
> This doesn't follow the architecture requirements for "break before
> make" when changing live page tables. While it may work, it risks
> triggering a TLB conflict abort. The correct sequence normally is:
> 
> 	pmd_clear();
> 	flush_tlb_kernel_range();
> 	__pmd_populate();
> 
> However, do we have any guarantees that the kernel doesn't access the
> pmd range being unmapped temporarily? The page table itself might live
> in one of these sections, so set_pmd() etc. can get a translation fault.
> 
Thanks. I'll follow this.
I'll resend the path as soon as possible.
