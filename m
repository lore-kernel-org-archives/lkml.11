Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD26C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 17:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiGARYl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 13:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiGARYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:24:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA218344DC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 10:24:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83BFBB830FA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 17:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BB2C3411E;
        Fri,  1 Jul 2022 17:24:32 +0000 (UTC)
Date:   Fri, 1 Jul 2022 18:24:28 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc:     baolin.wang@linux.alibaba.com, will@kernel.org,
        akpm@linux-foundation.org, david@redhat.com, jianyong.wu@arm.com,
        james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org,
        geert+renesas@glider.be, ardb@kernel.org, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v3] arm64: mm: fix linear mapping mem access performance
 degradation
Message-ID: <Yr8tzOJi5CGBl767@arm.com>
References: <1656586222-98555-1-git-send-email-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656586222-98555-1-git-send-email-guanghuifeng@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 06:50:22PM +0800, Guanghui Feng wrote:
> +static void init_pmd_remap(pud_t *pudp, unsigned long addr, unsigned long end,
> +			   phys_addr_t phys, pgprot_t prot,
> +			   phys_addr_t (*pgtable_alloc)(int), int flags)
> +{
> +	unsigned long next;
> +	pmd_t *pmdp;
> +	phys_addr_t map_offset;
> +	pmdval_t pmdval;
> +
> +	pmdp = pmd_offset(pudp, addr);
> +	do {
> +		next = pmd_addr_end(addr, end);
> +
> +		if (!pmd_none(*pmdp) && pmd_sect(*pmdp)) {
> +			phys_addr_t pte_phys = pgtable_alloc(PAGE_SHIFT);
> +			pmd_clear(pmdp);
> +			pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN;
> +			if (flags & NO_EXEC_MAPPINGS)
> +				pmdval |= PMD_TABLE_PXN;
> +			__pmd_populate(pmdp, pte_phys, pmdval);
> +			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);

This doesn't follow the architecture requirements for "break before
make" when changing live page tables. While it may work, it risks
triggering a TLB conflict abort. The correct sequence normally is:

	pmd_clear();
	flush_tlb_kernel_range();
	__pmd_populate();

However, do we have any guarantees that the kernel doesn't access the
pmd range being unmapped temporarily? The page table itself might live
in one of these sections, so set_pmd() etc. can get a translation fault.

-- 
Catalin
