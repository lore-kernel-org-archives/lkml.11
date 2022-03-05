Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978BAC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Mar 2022 13:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiCEN3x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Mar 2022 08:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiCEN3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 08:29:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1517B2ADF;
        Sat,  5 Mar 2022 05:29:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF398B80BE7;
        Sat,  5 Mar 2022 13:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F4AC004E1;
        Sat,  5 Mar 2022 13:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646486939;
        bh=vYvP7056BHk7rl1Y96vla2BZ2Uo/2Pb6tDGrV6v4z4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1Nzq1ovp65BGoS79tdDDeAGZcrYlvcwIP+/fBBgTc52YdLqizvBCULP6O5lwf/7V
         0XacYp/4qgfISo9A8lDOnzUftO/fLmhvkvLZAvx6tgy7i+cd5UESXi7cccPQ8saNgS
         0AS4gcygqiwqxV8Ek5nbD7xCHnw8vd20zQDG56T50uGPrx3qwvlhDjjp0rU2Jr2Kur
         cA0k3skgVYTrK/jRqpNgGeXPXhA55dT8/Lx9XpbijQcNXOQbgcOch5oOElwLOn2nqi
         GF20tc+6krwNMKkYOBRXj0W/S7jr9ZKn4eyImSnSLKgxoDs2TjO9uCtBTLvqX8rcp7
         xpVfCV+20Hgtw==
Date:   Sat, 5 Mar 2022 15:28:51 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] memblock: Introduce
 memblock_mem_range_remove_map()
Message-ID: <YiNlkwZkdVSpAbgO@kernel.org>
References: <1646461289-31992-1-git-send-email-yangtiezhu@loongson.cn>
 <1646461289-31992-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646461289-31992-2-git-send-email-yangtiezhu@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 02:21:26PM +0800, Tiezhu Yang wrote:
> This is preparation for supporting mem=limit@base and memmap=limit@base
> parameters, no functionality change.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

NAK.

We already have enough memory capping interfaces in memblock, we don't need
yet another one.

> ---
>  include/linux/memblock.h | 1 +
>  mm/memblock.c            | 9 +++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 50ad196..e558d2c 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -482,6 +482,7 @@ phys_addr_t memblock_end_of_DRAM(void);
>  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
>  void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
>  void memblock_mem_limit_remove_map(phys_addr_t limit);
> +void memblock_mem_range_remove_map(phys_addr_t base, phys_addr_t limit);
>  bool memblock_is_memory(phys_addr_t addr);
>  bool memblock_is_map_memory(phys_addr_t addr);
>  bool memblock_is_region_memory(phys_addr_t base, phys_addr_t size);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 1018e50..2476d15d 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1723,7 +1723,7 @@ void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
>  			base + size, PHYS_ADDR_MAX);
>  }
>  
> -void __init memblock_mem_limit_remove_map(phys_addr_t limit)
> +void __init memblock_mem_range_remove_map(phys_addr_t base, phys_addr_t limit)
>  {
>  	phys_addr_t max_addr;
>  
> @@ -1736,7 +1736,12 @@ void __init memblock_mem_limit_remove_map(phys_addr_t limit)
>  	if (max_addr == PHYS_ADDR_MAX)
>  		return;
>  
> -	memblock_cap_memory_range(0, max_addr);
> +	memblock_cap_memory_range(base, max_addr);
> +}
> +
> +void __init memblock_mem_limit_remove_map(phys_addr_t limit)
> +{
> +	memblock_mem_range_remove_map(0, limit);
>  }
>  
>  static int __init_memblock memblock_search(struct memblock_type *type, phys_addr_t addr)
> -- 
> 2.1.0
> 

-- 
Sincerely yours,
Mike.
