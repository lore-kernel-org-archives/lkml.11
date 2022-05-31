Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EB3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 22:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244841AbiEaWAi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 18:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348378AbiEaWA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:00:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B006753B72;
        Tue, 31 May 2022 15:00:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 773DC23A;
        Tue, 31 May 2022 15:00:25 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 640F93F66F;
        Tue, 31 May 2022 15:00:24 -0700 (PDT)
Message-ID: <39d1fa65-8e82-721c-171e-ef36bda1c561@arm.com>
Date:   Tue, 31 May 2022 23:00:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dma-debug: Make things less spammy under memory pressure
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>
References: <20220531215106.192271-1-robdclark@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220531215106.192271-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-31 22:51, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Ratelimit the error msg to avoid flooding the console.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   kernel/dma/debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index f8ff598596b8..683966f0247b 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -564,7 +564,7 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
>   
>   	rc = active_cacheline_insert(entry);
>   	if (rc == -ENOMEM) {
> -		pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
> +		pr_err_ratelimited("cacheline tracking ENOMEM, dma-debug disabled\n");
>   		global_disable = true;

Given that it's supposed to disable itself entirely if it ever gets 
here, just how spammy is it exactly?

Thanks,
Robin.

>   	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
>   		err_printk(entry->dev, entry,
