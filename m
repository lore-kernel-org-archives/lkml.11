Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9F7CCA479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 06:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbiFTGQQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 02:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiFTGQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:16:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5404BBF48;
        Sun, 19 Jun 2022 23:16:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DA9576732D; Mon, 20 Jun 2022 08:16:07 +0200 (CEST)
Date:   Mon, 20 Jun 2022 08:16:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, hch@lst.de, samuel@sholland.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org, rdunlap@infradead.org,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 3/4] riscv: Implement Zicbom-based cache management
 operations
Message-ID: <20220620061607.GB10485@lst.de>
References: <20220619203212.3604485-1-heiko@sntech.de> <20220619203212.3604485-4-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619203212.3604485-4-heiko@sntech.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 10:32:11PM +0200, Heiko Stuebner wrote:
> +#ifdef CONFIG_RISCV_DMA_NONCOHERENT
> +#define ARCH_DMA_MINALIGN L1_CACHE_BYTES
> +#endif

This needs to be greater or equal to riscv_cbom_block_size, but the
core code requires a compile time constant here.  So we'll need a big
fat comment here, and panic if riscv_cbom_block_size is >
L1_CACHE_BYTES/ARCH_DMA_MINALIGN in the code that queries
riscv_cbom_block_size.

Note that the arm64 folks are looking into making this variable or
killing it off in this current form, so things might be getting better
soon.

> +void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
> +			      enum dma_data_direction dir)
> +{
> +	void *vaddr = phys_to_virt(paddr);
> +
> +	switch (dir) {
> +	case DMA_TO_DEVICE:
> +		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> +		break;
> +	case DMA_FROM_DEVICE:
> +		ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
> +		break;

For this also see:

https://lore.kernel.org/all/20220606152150.GA31568@willie-the-truck/

and

https://lore.kernel.org/linux-arm-kernel/20220610151228.4562-1-will@kernel.org/T/

> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +		const struct iommu_ops *iommu, bool coherent)
> +{
> +	dev->dma_coherent = coherent;
> +}

This probably wants a sanity check warn if coherent if false without
any support for cache flushing as that will cause data corruption.
