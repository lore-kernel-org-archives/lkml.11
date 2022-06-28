Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490B4CCA479
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 18:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiF1SyH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 14:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiF1SyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:54:05 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A81A22BD3;
        Tue, 28 Jun 2022 11:54:03 -0700 (PDT)
Date:   Tue, 28 Jun 2022 18:53:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656442441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=htPFhHOsa3d7/VGnFqnbz5VFkkx8xDdtzMvjjntEVQQ=;
        b=d6djTxUwEkHGAYEqJ+FSn4G/FZeJSZoQaoOZxxQhJaqcI2qvYIgXT+trdlZ0GWC661TwyO
        1oiSHS8oHUyMAMhElHKJhcjJFylgZXvccpHWWmhbSO2Tv35HgJpLHoM6RfUaZ/baIXg/yK
        KB8JzslXVDM8K4q77AikRR+g7gpG87A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 4/4] KVM: arm64/mmu: count KVM s2 mmu usage in
 secondary pagetable stats
Message-ID: <YrtOQxEi8fijGwSQ@google.com>
References: <20220606222058.86688-1-yosryahmed@google.com>
 <20220606222058.86688-5-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606222058.86688-5-yosryahmed@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yosry,

On Mon, Jun 06, 2022 at 10:20:58PM +0000, Yosry Ahmed wrote:
> Count the pages used by KVM in arm64 for stage2 mmu in secondary pagetable
> stats.

You could probably benefit from being a bit more verbose in the commit
message here as well, per Sean's feedback.

> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  arch/arm64/kvm/mmu.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index f5651a05b6a85..80bc92601fd96 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -92,9 +92,13 @@ static bool kvm_is_device_pfn(unsigned long pfn)
>  static void *stage2_memcache_zalloc_page(void *arg)
>  {
>  	struct kvm_mmu_memory_cache *mc = arg;
> +	void *virt;
>  
>  	/* Allocated with __GFP_ZERO, so no need to zero */
> -	return kvm_mmu_memory_cache_alloc(mc);
> +	virt = kvm_mmu_memory_cache_alloc(mc);
> +	if (virt)
> +		kvm_account_pgtable_pages(virt, 1);
> +	return virt;
>  }
>  
>  static void *kvm_host_zalloc_pages_exact(size_t size)
> @@ -102,6 +106,21 @@ static void *kvm_host_zalloc_pages_exact(size_t size)
>  	return alloc_pages_exact(size, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
>  }
>  
> +static void *kvm_s2_zalloc_pages_exact(size_t size)
> +{
> +	void *virt = kvm_host_zalloc_pages_exact(size);
> +
> +	if (virt)
> +		kvm_account_pgtable_pages(virt, (size >> PAGE_SHIFT));
> +	return virt;
> +}
> +
> +static void kvm_s2_free_pages_exact(void *virt, size_t size)
> +{
> +	kvm_account_pgtable_pages(virt, -(size >> PAGE_SHIFT));
> +	free_pages_exact(virt, size);
> +}
> +
>  static void kvm_host_get_page(void *addr)
>  {
>  	get_page(virt_to_page(addr));
> @@ -112,6 +131,15 @@ static void kvm_host_put_page(void *addr)
>  	put_page(virt_to_page(addr));
>  }
>  
> +static void kvm_s2_put_page(void *addr)
> +{
> +	struct page *p = virt_to_page(addr);
> +	/* Dropping last refcount, the page will be freed */
> +	if (page_count(p) == 1)
> +		kvm_account_pgtable_pages(addr, -1);
> +	put_page(p);

Probably more of a note to myself with the parallel fault series, but
this is a race waiting to happen. This only works because stage 2 pages
are dropped behind the write lock.

Besides the commit message nit:

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
