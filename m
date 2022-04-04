Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A41C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 10:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350304AbiDDKxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 06:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245571AbiDDKxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:53:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB5993CFDD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:51:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D93B1FB;
        Mon,  4 Apr 2022 03:51:16 -0700 (PDT)
Received: from [10.57.41.120] (unknown [10.57.41.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAF1F3F718;
        Mon,  4 Apr 2022 03:51:14 -0700 (PDT)
Message-ID: <14d1bb4c-f58b-12d6-1034-c851263acafd@arm.com>
Date:   Mon, 4 Apr 2022 11:51:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: mm: fix pmd_leaf()
Content-Language: en-GB
To:     Will Deacon <will@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, aneesh.kumar@linux.ibm.com,
        lengxujun2007@126.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        smuchun@gmail.com, duanxiongchun@bytedance.com,
        Qian Cai <quic_qiancai@quicinc.com>
References: <20220403024928.4125-1-songmuchun@bytedance.com>
 <20220404091957.GA22790@willie-the-truck>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20220404091957.GA22790@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2022 10:19, Will Deacon wrote:
> On Sun, Apr 03, 2022 at 10:49:28AM +0800, Muchun Song wrote:
>> The pmd_leaf() is used to test a leaf mapped PMD, however, it misses
>> the PROT_NONE mapped PMD on arm64.  Fix it.  A real world issue [1]
>> caused by this was reported by Qian Cai.
>>
>> Link: https://patchwork.kernel.org/comment/24798260/ [1]
>> Fixes: 8aa82df3c123 ("arm64: mm: add p?d_leaf() definitions")
>> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>  arch/arm64/include/asm/pgtable.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 94e147e5456c..09eaae46a19b 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -535,7 +535,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>>  				 PMD_TYPE_TABLE)
>>  #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
>>  				 PMD_TYPE_SECT)
>> -#define pmd_leaf(pmd)		pmd_sect(pmd)
>> +#define pmd_leaf(pmd)		(pmd_present(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
>>  #define pmd_bad(pmd)		(!pmd_table(pmd))
>>  
>>  #define pmd_leaf_size(pmd)	(pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
> 
> A bunch of the users of pmd_leaf() already check pmd_present() -- is it
> documented that we need to handle this check inside the macro? afaict x86
> doesn't do this either.

The documentation is with the fallback implementations that always
return 0:

> /*
>  * p?d_leaf() - true if this entry is a final mapping to a physical address.
>  * This differs from p?d_huge() by the fact that they are always available (if
>  * the architecture supports large pages at the appropriate level) even
>  * if CONFIG_HUGETLB_PAGE is not defined.
>  * Only meaningful when called on a valid entry.
>  */

I guess the term "valid entry" is a bit vague but my intention was that
meant p?d_present().

I have to admit I hadn't considered PROT_NONE mappings before.

Steve
