Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89930C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 17:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiHWReW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 13:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiHWRdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:33:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5441774350
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:12:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9A87113E;
        Tue, 23 Aug 2022 08:12:34 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DE223F70D;
        Tue, 23 Aug 2022 08:12:30 -0700 (PDT)
Message-ID: <f93497ce-7775-9c4c-db0d-714a0e5c5bc5@arm.com>
Date:   Tue, 23 Aug 2022 16:12:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1 1/1] iommu: Do not dereference fwnode in struct device
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20220801164758.20664-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-GB
In-Reply-To: <20220801164758.20664-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2022 5:47 pm, Andy Shevchenko wrote:
> In order to make the underneath API easier to change in the future,
> prevent users from dereferencing fwnode from struct device.
> Instead, use the specific dev_fwnode() API for that.

Seems fair,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/iommu/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 780fb7071577..31b5f4ceb2e9 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -173,7 +173,7 @@ int iommu_device_register(struct iommu_device *iommu,
>   
>   	iommu->ops = ops;
>   	if (hwdev)
> -		iommu->fwnode = hwdev->fwnode;
> +		iommu->fwnode = dev_fwnode(hwdev);
>   
>   	spin_lock(&iommu_device_lock);
>   	list_add_tail(&iommu->list, &iommu_device_list);
