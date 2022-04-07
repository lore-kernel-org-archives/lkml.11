Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CE7C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 13:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343560AbiDGNJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 09:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbiDGNJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:09:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59B6518F23C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:07:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4E6712FC;
        Thu,  7 Apr 2022 06:07:27 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68ACE3F73B;
        Thu,  7 Apr 2022 06:07:26 -0700 (PDT)
Message-ID: <06570238-04a9-47ca-e6e2-c69606635446@arm.com>
Date:   Thu, 7 Apr 2022 14:07:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] dma-iommu: Check that swiotlb is active before
 trying to use it
Content-Language: en-GB
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Hegde Vasant <Vasant.Hegde@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
References: <20220404204723.9767-1-mario.limonciello@amd.com>
 <20220404204723.9767-3-mario.limonciello@amd.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220404204723.9767-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-04 21:47, Mario Limonciello via iommu wrote:
> If the IOMMU is in use and an untrusted device is connected to an external
> facing port but the address requested isn't page aligned will cause the
> kernel to attempt to use bounce buffers.
> 
> If for some reason the bounce buffers have not been allocated this is a
> problem that should be made apparent to the user.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>   * Move error message into the caller
> 
>   drivers/iommu/dma-iommu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 09f6e1c0f9c0..1ca85d37eeab 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -971,6 +971,11 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   		void *padding_start;
>   		size_t padding_size, aligned_size;
>   
> +		if (!is_swiotlb_active(dev)) {
> +			dev_warn_once(dev, "DMA bounce buffers are inactive, unable to map unaligned transaction.\n");
> +			return DMA_MAPPING_ERROR;
> +		}
> +
>   		aligned_size = iova_align(iovad, size);
>   		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
>   					      iova_mask(iovad), dir, attrs);
