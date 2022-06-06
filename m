Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BB6C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 07:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiFFHyR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 03:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiFFHyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:54:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BFA12D3D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 00:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lUQxgeaOx1V7BACAiT/2H3YxZOL12gsM6xoyyjRU6Dg=; b=GEjLN8te4doRjDnMvvD+Y/go0p
        UQTGBjb/7Ml2PTLMqaNlV9k9Z5tuMzxnudHCtbs9kPlMOVLUCrl148D9b4PmCVUSffpTNmeu/peek
        i3Y1Yh/DwCHiiiGfeUSRBxROzCXoe2zXodgJ/MqO4NwuXcSYGRRdvpDTbW+8a9zW8OyuUgMVBfVaB
        2cks8R5KY7cjjmAYVVf+5vmGRzn4pdAn/rV5ph23L2jOhkZzZ/PfiucwUEYm00WRQ/Ht+UFAiF5Nl
        qdQBCjrkb4nVmUygpF9z4YRKsMUW89fbVMwhBLRjY9n5dj0ck+3boQ7w4+V6VHMLndkavXLINEoGf
        oFJHezHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ny7Yv-0000fB-68; Mon, 06 Jun 2022 07:54:09 +0000
Date:   Mon, 6 Jun 2022 00:54:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, arnd@arndb.de, anshuman.khandual@arm.com
Subject: Re: [PATCH v4 5/6] arm64: mm: Convert to GENERIC_IOREMAP
Message-ID: <Yp2yoRkHLuONDO9y@infradead.org>
References: <20220606074815.139265-1-wangkefeng.wang@huawei.com>
 <20220606074815.139265-6-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606074815.139265-6-wangkefeng.wang@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define ioremap_wc(addr, size)		ioremap_prot((addr), (size), PROT_NORMAL_NC)
> +#define ioremap_np(addr, size)		ioremap_prot((addr), (size), PROT_DEVICE_nGnRnE)

Please avoid the overly long lines here.  Independt of that having
a non-trivial body on a separate line tends to generlly be a lot more
readable anyway.

> +#define ioremap_cache(addr, size) ({							\
> +	pfn_is_map_memory(__phys_to_pfn(addr)) ?					\
> +	(void __iomem *)__phys_to_virt(addr) : ioremap_prot(addr, size, PROT_NORMAL);	\
> +})

And this really should be an inline function.

> +int iounmap_allowed(void __iomem *addr)
>  {
>  	/*
>  	 * We could get an address outside vmalloc range in case
>  	 * of ioremap_cache() reusing a RAM mapping.
>  	 */
> +	return is_vmalloc_addr(addr) ? 0 : -EINVAL;

As the generic ioremap only returns vmalloc addresses, this check
really should go into common code.
