Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE9BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 18:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbiBISev (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 13:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbiBISem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:34:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6B9C05CB92
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 10:34:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2921B82386
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 18:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8671CC340EE;
        Wed,  9 Feb 2022 18:34:40 +0000 (UTC)
Date:   Wed, 9 Feb 2022 18:34:37 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/migration: Define arm64_hugetlb_valid_size()
Message-ID: <YgQJPVUWMruiq74O@arm.com>
References: <1644197468-26755-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644197468-26755-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 07:01:08AM +0530, Anshuman Khandual wrote:
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index ffb9c229610a..dcdc4c0c3bd8 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -56,24 +56,12 @@ void __init arm64_hugetlb_cma_reserve(void)
>  }
>  #endif /* CONFIG_CMA */
>  
> +static bool arm64_hugetlb_valid_size(unsigned long size);
> +
>  #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
>  bool arch_hugetlb_migration_supported(struct hstate *h)
>  {
> -	size_t pagesize = huge_page_size(h);
> -
> -	switch (pagesize) {
> -#ifndef __PAGETABLE_PMD_FOLDED
> -	case PUD_SIZE:
> -		return pud_sect_supported();
> -#endif
> -	case PMD_SIZE:
> -	case CONT_PMD_SIZE:
> -	case CONT_PTE_SIZE:
> -		return true;
> -	}
> -	pr_warn("%s: unrecognized huge page size 0x%lx\n",
> -			__func__, pagesize);
> -	return false;
> +	return arm64_hugetlb_valid_size(huge_page_size(h));
>  }
>  #endif
>  
> @@ -504,7 +492,7 @@ static int __init hugetlbpage_init(void)
>  }
>  arch_initcall(hugetlbpage_init);
>  
> -bool __init arch_hugetlb_valid_size(unsigned long size)
> +static bool arm64_hugetlb_valid_size(unsigned long size)
>  {
>  	switch (size) {
>  #ifndef __PAGETABLE_PMD_FOLDED
> @@ -517,5 +505,12 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
>  		return true;
>  	}
>  
> +	pr_warn("%s: unrecognized huge page size 0x%lx\n",
> +		__func__, size);
>  	return false;
>  }

We already have the warnings in the caller of arch_hugetlb_valid_size(),
I wouldn't add another here. You can keep it in
arch_hugetlb_migration_supported() though.

> +
> +bool __init arch_hugetlb_valid_size(unsigned long size)
> +{
> +	return arm64_hugetlb_valid_size(size);
> +}

What's wrong with keeping the arch_hugetlb_valid_size() name and just
removing __init?

-- 
Catalin
