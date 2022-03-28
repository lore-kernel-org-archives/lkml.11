Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6606C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 19:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245694AbiC1T21 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 15:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245699AbiC1T1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:27:50 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734785E767
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:26:09 -0700 (PDT)
Date:   Mon, 28 Mar 2022 12:26:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648495567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HI+dsvmjaN/rkGaZbNLF+cKlPT7DGdpfJYFLeEXc0Ts=;
        b=jpOSnpVGPf5/gLaSmGsNc0vn5N+hBHUR9ky2eGwEPwKeNEvqUDPzzpVpElXTK/7f/6q5Le
        tMd6dnJTD9Q1coxYQspQN9x0xJsA/tLuqTgnm4C8ado5C/3SWuMh6pO0nLk9xPmTr7SYeL
        5NECd/RNfvdD7AVIFQwhXx4BEP33vzU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com
Subject: Re: [PATCH v2] mm: kfence: fix objcgs vector allocation
Message-ID: <YkILyqc1WIfQLCTI@carbon.dhcp.thefacebook.com>
References: <20220328132843.16624-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328132843.16624-1-songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 09:28:43PM +0800, Muchun Song wrote:
> If the kfence object is allocated to be used for objects vector, then
> this slot of the pool eventually being occupied permanently since
> the vector is never freed.  The solutions could be 1) freeing vector
> when the kfence object is freed or 2) allocating all vectors statically.
> Since the memory consumption of object vectors is low, it is better to
> chose 2) to fix the issue and it is also can reduce overhead of vectors
> allocating in the future.
> 
> Fixes: d3fb45f370d9 ("mm, kfence: insert KFENCE hooks for SLAB")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> v2:
>  - Fix compiler error reported by kernel test robot <lkp@intel.com>.

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

LGTM, thanks!


> 
>  mm/kfence/core.c   | 11 ++++++++++-
>  mm/kfence/kfence.h |  3 +++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 13128fa13062..d4c7978cd75e 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -555,6 +555,8 @@ static bool __init kfence_init_pool(void)
>  	 * enters __slab_free() slow-path.
>  	 */
>  	for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
> +		struct slab *slab = page_slab(&pages[i]);
> +
>  		if (!i || (i % 2))
>  			continue;
>  
> @@ -562,7 +564,11 @@ static bool __init kfence_init_pool(void)
>  		if (WARN_ON(compound_head(&pages[i]) != &pages[i]))
>  			goto err;
>  
> -		__SetPageSlab(&pages[i]);
> +		__folio_set_slab(slab_folio(slab));
> +#ifdef CONFIG_MEMCG
> +		slab->memcg_data = (unsigned long)&kfence_metadata[i / 2 - 1].objcg |
> +				   MEMCG_DATA_OBJCGS;
> +#endif

We can probably put CONFIG_MEMCG_KMEM here, but it doesn't matter that much.
In the long run we should get rid of CONFIG_MEMCG_KMEM anyway.
