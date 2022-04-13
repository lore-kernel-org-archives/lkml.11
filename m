Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95517C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 13:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbiDMNnF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 09:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbiDMNm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:42:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3042B5EDFD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:40:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAB2C1596;
        Wed, 13 Apr 2022 06:40:37 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15A933F73B;
        Wed, 13 Apr 2022 06:40:35 -0700 (PDT)
Message-ID: <37c02fc4-d793-b003-f612-206c987a8a42@arm.com>
Date:   Wed, 13 Apr 2022 14:40:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] iommu/arm-smmu-v3: Align size in __arm_smmu_tlb_inv_range
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
        joro@8bytes.org
Cc:     thunder.leizhen@huawei.com, jgg@ziepe.ca, tglx@linutronix.de,
        john.garry@huawei.com, jean-philippe@linaro.org,
        christophe.jaillet@wanadoo.fr,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220413041745.35174-1-nicolinc@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220413041745.35174-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-13 05:17, Nicolin Chen wrote:
> To calculate num_pages, the size should be aligned with
> "page size", determined by the tg value. Otherwise, its
> following "while (iova < end)" might become an infinite
> loop if unaligned size is slightly greater than 1 << tg.

Hmm, how does a non-page-aligned invalidation request get generated in 
the first place?

Robin.

> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 627a3ed5ee8f..8249dad5ae44 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1879,7 +1879,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>   		/* Determine what level the granule is at */
>   		cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
>   
> -		num_pages = size >> tg;
> +		num_pages = ALIGN(size, 1 << tg) >> tg;
>   	}
>   
>   	cmds.num = 0;
