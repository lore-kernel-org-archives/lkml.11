Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36362C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 17:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiGERFQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 13:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiGERFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:05:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775B71AD82
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:05:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E3425CE1B95
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 17:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5071BC341C7;
        Tue,  5 Jul 2022 17:05:05 +0000 (UTC)
Date:   Tue, 5 Jul 2022 18:05:01 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        "guanghui.fgh" <guanghuifeng@linux.alibaba.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        baolin.wang@linux.alibaba.com, akpm@linux-foundation.org,
        david@redhat.com, jianyong.wu@arm.com, james.morse@arm.com,
        quic_qiancai@quicinc.com, christophe.leroy@csgroup.eu,
        jonathan@marek.ca, mark.rutland@arm.com,
        thunder.leizhen@huawei.com, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        geert+renesas@glider.be, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v4] arm64: mm: fix linear mem mapping access performance
 degradation
Message-ID: <YsRvPTORdvIwzShL@arm.com>
References: <20220704142313.GE31684@willie-the-truck>
 <6977c692-78ca-5a67-773e-0389c85f2650@linux.alibaba.com>
 <20220704163815.GA32177@willie-the-truck>
 <CAMj1kXEvY5QXOUrXZ7rBp9As=65uTTFRSSq+FPt-n4M2P-_VtQ@mail.gmail.com>
 <20220705095231.GB552@willie-the-truck>
 <5d044fdd-a61a-d60f-d294-89e17de37712@linux.alibaba.com>
 <20220705121115.GB1012@willie-the-truck>
 <YsRSajyMxahXe7ZS@kernel.org>
 <YsRZ8V8mQ+HM31D6@arm.com>
 <YsRfgX7FFZLxQU50@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsRfgX7FFZLxQU50@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 06:57:53PM +0300, Mike Rapoport wrote:
> On Tue, Jul 05, 2022 at 04:34:09PM +0100, Catalin Marinas wrote:
> > On Tue, Jul 05, 2022 at 06:02:02PM +0300, Mike Rapoport wrote:
> > > +void __init remap_crashkernel(void)
> > > +{
> > > +#ifdef CONFIG_KEXEC_CORE
> > > +	phys_addr_t start, end, size;
> > > +	phys_addr_t aligned_start, aligned_end;
> > > +
> > > +	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
> > > +	    return;
> > > +
> > > +	if (!crashk_res.end)
> > > +	    return;
> > > +
> > > +	start = crashk_res.start & PAGE_MASK;
> > > +	end = PAGE_ALIGN(crashk_res.end);
> > > +
> > > +	aligned_start = ALIGN_DOWN(crashk_res.start, PUD_SIZE);
> > > +	aligned_end = ALIGN(end, PUD_SIZE);
> > > +
> > > +	/* Clear PUDs containing crash kernel memory */
> > > +	unmap_hotplug_range(__phys_to_virt(aligned_start),
> > > +			    __phys_to_virt(aligned_end), false, NULL);
> > 
> > What I don't understand is what happens if there's valid kernel data
> > between aligned_start and crashk_res.start (or the other end of the
> > range).
> 
> Data shouldn't go anywhere :)
> 
> There is 
> 
> +	/* map area from PUD start to start of crash kernel with large pages */
> +	size = start - aligned_start;
> +	__create_pgd_mapping(swapper_pg_dir, aligned_start,
> +			     __phys_to_virt(aligned_start),
> +			     size, PAGE_KERNEL, early_pgtable_alloc, 0);
> 
> and 
> 
> +	/* map area from end of crash kernel to PUD end with large pages */
> +	size = aligned_end - end;
> +	__create_pgd_mapping(swapper_pg_dir, end, __phys_to_virt(end),
> +			     size, PAGE_KERNEL, early_pgtable_alloc, 0);
> 
> after the unmap, so after we tear down a part of a linear map we
> immediately recreate it, just with a different page size.
> 
> This all happens before SMP, so there is no concurrency at that point.

That brief period of unmap worries me. The kernel text, data and stack
are all in the vmalloc space but any other (memblock) allocation to this
point may be in the unmapped range before and after the crashkernel
reservation. The interrupts are off, so I think the only allocation and
potential access that may go in this range is the page table itself. But
it looks fragile to me.

-- 
Catalin
