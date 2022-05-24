Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35694C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 14:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238275AbiEXOgY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 10:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbiEXOgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:36:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C06E150E0B
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:36:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FD9F1FB;
        Tue, 24 May 2022 07:36:20 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E7193F66F;
        Tue, 24 May 2022 07:36:17 -0700 (PDT)
Message-ID: <f3170016-4d7f-e78e-db48-68305f683349@arm.com>
Date:   Tue, 24 May 2022 15:36:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-GB
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jacob jun Pan <jacob.jun.pan@intel.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220519072047.2996983-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-19 08:20, Lu Baolu wrote:
[...]
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 106506143896..210c376f6043 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -69,3 +69,51 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>   	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>   }
>   EXPORT_SYMBOL_GPL(iommu_sva_find);
> +
> +/*
> + * IOMMU SVA driver-oriented interfaces
> + */
> +struct iommu_domain *
> +iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm)

Argh, please no new bus-based external interfaces! Domain allocation 
needs to resolve to the right IOMMU instance to solve a number of 
issues, and cleaning up existing users of iommu_domain_alloc() to 
prepare for that is already hard enough. This is arguably even more 
relevant here than for other domain types, since SVA support is more 
likely to depend on specific features that can vary between IOMMU 
instances even with the same driver. Please make the external interface 
take a struct device, then resolve the ops through dev->iommu.

Further nit: the naming inconsistency bugs me a bit - 
iommu_sva_domain_alloc() seems more natural. Also I'd question the 
symmetry vs. usability dichotomy of whether we *really* want two 
different free functions for a struct iommu_domain pointer, where any 
caller which might mix SVA and non-SVA usage then has to remember how 
they allocated any particular domain :/

> +{
> +	struct iommu_sva_domain *sva_domain;
> +	struct iommu_domain *domain;
> +
> +	if (!bus->iommu_ops || !bus->iommu_ops->sva_domain_ops)
> +		return ERR_PTR(-ENODEV);
> +
> +	sva_domain = kzalloc(sizeof(*sva_domain), GFP_KERNEL);
> +	if (!sva_domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mmgrab(mm);
> +	sva_domain->mm = mm;
> +
> +	domain = &sva_domain->domain;
> +	domain->type = IOMMU_DOMAIN_SVA;
> +	domain->ops = bus->iommu_ops->sva_domain_ops;

I'd have thought it would be logical to pass IOMMU_DOMAIN_SVA to the 
normal domain_alloc call, so that driver-internal stuff like context 
descriptors can be still be hung off the domain as usual (rather than 
all drivers having to implement some extra internal lookup mechanism to 
handle all the SVA domain ops), but that's something we're free to come 
back and change later. FWIW I'd just stick the mm pointer in struct 
iommu_domain, in a union with the fault handler stuff and/or iova_cookie 
- those are mutually exclusive with SVA, right?

Cheers,
Robin.

> +
> +	return domain;
> +}
> +
> +void iommu_sva_free_domain(struct iommu_domain *domain)
> +{
> +	struct iommu_sva_domain *sva_domain = to_sva_domain(domain);
> +
> +	mmdrop(sva_domain->mm);
> +	kfree(sva_domain);
> +}
> +
