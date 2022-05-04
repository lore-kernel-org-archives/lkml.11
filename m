Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1715FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 18:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376690AbiEDSKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 14:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359530AbiEDSKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:10:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9AE5A143
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4776560A27
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 17:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13756C385A4;
        Wed,  4 May 2022 17:26:46 +0000 (UTC)
Date:   Wed, 4 May 2022 18:26:43 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v6 5/6] arm64/mm: Enable
 ARCH_SUPPORTS_PAGE_TABLE_CHECK
Message-ID: <YnK3U3qDhhgwaULb@arm.com>
References: <20220426081036.1374452-1-tongtiangen@huawei.com>
 <20220426081036.1374452-6-tongtiangen@huawei.com>
 <ae74ea7c-9014-b162-f1e7-a66f402aee49@arm.com>
 <80f6c347-db5d-8836-bc79-60c7b2a6eed8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80f6c347-db5d-8836-bc79-60c7b2a6eed8@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 09:13:20AM +0800, Tong Tiangen wrote:
> 在 2022/4/29 14:18, Anshuman Khandual 写道:
> > On 4/26/22 13:40, Tong Tiangen wrote:
> > > @@ -884,7 +928,11 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> > >   static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
> > >   					    unsigned long address, pmd_t *pmdp)
> > >   {
> > > -	return pte_pmd(ptep_get_and_clear(mm, address, (pte_t *)pmdp));
> > > +	pmd_t pmd = pte_pmd(__pte(xchg_relaxed(&pte_val(*(pte_t *)pmdp), 0)));
> > 
> > Why there is any change here ? Why not just the following instead, like what you did
> > in ptep_get_and_clear() above. The page table entry return value here just needs to
> > be preserved for subsequent page table check helpers.
> > 
> > 	pmd_t pmd = pte_pmd(ptep_get_and_clear(mm, address, (pte_t *)pmdp));
> 
> The purpose of what I do here is to avoid doing page_table_check_pte_clear()
> in ptep_get_and_clear(). there is no functional change here.

I'm fine with using xchg here but I'd go for pmd_val directly, no need
for conversion to pte_t:

	pmd_t pmd = __pmd(xchg_relaxed(&pmd_val(*pmdp), 0));

-- 
Catalin
