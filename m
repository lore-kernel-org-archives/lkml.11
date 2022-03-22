Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB688C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 03:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiCVDI6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 23:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbiCVDIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:08:54 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DD83FDBF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:07:27 -0700 (PDT)
Received: from kwepemi100001.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KMxHB2qKtz1GCpk;
        Tue, 22 Mar 2022 11:07:18 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100001.china.huawei.com (7.221.188.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 11:07:24 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 11:07:23 +0800
Message-ID: <d5c5e2fa-a09b-bf1b-295b-8ed99fc85e57@huawei.com>
Date:   Tue, 22 Mar 2022 11:07:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH -next 3/4] arm64: mm: add support for page table check
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Will Deacon" <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>
References: <20220317141203.3646253-1-tongtiangen@huawei.com>
 <20220317141203.3646253-4-tongtiangen@huawei.com> <YjOFNEvj7EfBasCI@arm.com>
 <cb91532b-c0cd-034c-2f93-4f76fabf5fc1@huawei.com> <YjS+2FVpq8D4Gx0S@arm.com>
 <d3006048-f737-439e-b985-cfbab69c4167@huawei.com> <Yjiqm6tQB5To5Jd9@arm.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <Yjiqm6tQB5To5Jd9@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/3/22 0:40, Catalin Marinas 写道:
> On Mon, Mar 21, 2022 at 02:15:36PM +0800, Tong Tiangen wrote:
>> Considering all your suggestions, The final logic should be:
>>
>> +#define pte_user(pte)          (!!(pte_val(pte) & PTE_USER))
>>
>> +#define pmd_user(pmd)		pte_user(pmd_pte(pmd))
>> +#define pmd_user_exec(pmd)	pte_user_exec(pmd_pte(pmd))
>>
>> +#define pud_user(pud)          pte_user(pud_pte(pud))
>>
>> +static inline bool pte_user_accessible_page(pte_t pte)
>> +{
>> +	return pte_present(pte) && (pte_user(pte)|| pte_user_exec(pte));
>> +}
> 
> This is fine.
> 
>> +static inline bool pmd_user_accessible_page(pmd_t pmd)
>> +{
>> +	return pmd_present(pmd) && (pmd_user(pmd)|| pmd_user_exec(pmd));
>> +}
> 
> That's fine as well assuming that the function is only called on the
> set_pmd_at() path where we know that the pmd would be a block mapping
> (huge page). I think that's the case from a quick look at the current
> x86 implementation.

Yeah, PTC only check pmd block mapping(huge page) and pud is similar.
These code logic will be included in V2.

Thanks.

> 
>> +static inline bool pud_user_accessible_page(pud_t pud)
>> +{
>> +	return pud_present(pud) && pud_user(pud);
>> +}
> 
> Same here.
> 
