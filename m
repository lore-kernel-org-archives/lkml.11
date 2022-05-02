Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DB5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 07:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358527AbiEBH2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 03:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358563AbiEBH2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:28:01 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392C817A94
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:24:33 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id m6so11090697iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 00:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U3yK116U7QtcL5LqxzCgKsq8iaHrCKZT63ym/sXbAKc=;
        b=Bzi+R0R7QaC+1bjX2bo/eUhZOcarNK1lhHQK3BnkDNsZ/YQ2kF65HgubGNE1g9QjAF
         VClt8yFpYSC5oht9s5BVdGzylLx1SGefdWn/yZSkP43v9ZQ/U115ldRP4mIaned4xy+i
         XIOYoMJFeLcWOEhr5AxcXnBEpdEmwdLfO6uO7xJ6U4GX4NaQbgjWU8WH2H/DzUzqOLnG
         Y07pCf3IIYshAUYH77brXREcB5+CeW72v1d84nST1hyzetu4eMbN4GXW/ybvmO2gKA4z
         6cXwi4THka5cWO2I5lnhUndPk6YD5GJn9zIhAtE8MWZojqFyir63YUwehSgoAGHPtqPb
         sMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U3yK116U7QtcL5LqxzCgKsq8iaHrCKZT63ym/sXbAKc=;
        b=1zpblwnFn2JJpfEDn2gtkVbsmT9sZ1X099YleSenV5rukdoewdoTfSYUcyvWjcm5Pq
         0VQAV25uLFIaSZ2vTuczZHW9YWp739YRy7Li/n2Bw2D+G2bJNz5rUbtjzARe4+sgXLJb
         X0RoRViZOMFss12xxB/QaEj/PsxXK9EukDJnAvOKXA+H4NcO4QvU6j+kfUNil2TVla4y
         m44odaFOR24YTVg9fINhKmHMTfpQogoKwKG7QFbFAn+/mgKnlSSaYoeyvgx0yZYC3dN7
         rfpveOBDOfPZdnCjnimAFPimHVrKV7WJ4cYPg1juCawauZK6z0W5wMpciBAJaCx0dYsP
         4EyQ==
X-Gm-Message-State: AOAM531WIJ7p9Q8y7cvFema/5mfFXuYdkKm/PG1DpZuMxGoMwgGlEuLq
        X8uRkUrz28VgfxVhOgzX4QzVvw==
X-Google-Smtp-Source: ABdhPJxeI2hWA90VpSmXaKqPppDo5J6dwWDCrTz4glAq2DiVVqCq9f3COwPcysvhW/KDXqg9MvY5ZQ==
X-Received: by 2002:a05:6638:2643:b0:323:c3e3:fcec with SMTP id n3-20020a056638264300b00323c3e3fcecmr4517508jat.289.1651476272267;
        Mon, 02 May 2022 00:24:32 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id z7-20020a926507000000b002cde6e352e5sm2494262ilb.47.2022.05.02.00.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 00:24:31 -0700 (PDT)
Date:   Mon, 2 May 2022 07:24:28 +0000
From:   Oliver Upton <oupton@google.com>
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
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 4/4] KVM: arm64/mmu: count KVM s2 mmu usage in
 secondary pagetable stats
Message-ID: <Ym+HLD/U0wwrxtaB@google.com>
References: <20220429201131.3397875-1-yosryahmed@google.com>
 <20220429201131.3397875-5-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429201131.3397875-5-yosryahmed@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yosry,

On Fri, Apr 29, 2022 at 08:11:31PM +0000, Yosry Ahmed wrote:
> Count the pages used by KVM in arm64 for stage2 mmu in secondary pagetable
> stats.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  arch/arm64/kvm/mmu.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 53ae2c0640bc..fc5030307cce 100644
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
> +		kvm_account_pgtable_pages(virt, +1);

Sorry I didn't say it last time around, would now be a good time to
clean up the funky sign convention of kvm_mod_used_mmu_pages()? Or limit
the funk to just x86 :)

--
Thanks,
Oliver
