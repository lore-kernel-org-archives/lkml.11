Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF77C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 07:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiGOHtj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 03:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbiGOHtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:49:35 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C5D78DC4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:49:30 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 21A4B3D9; Fri, 15 Jul 2022 09:49:29 +0200 (CEST)
Date:   Fri, 15 Jul 2022 09:49:27 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        iommu@lists.linux-foundation.org, will@kernel.org,
        yf.wang@mediatek.com, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH -next] iommu/dma: Fix missing mutex_init() in
 iommu_get_msi_cookie()
Message-ID: <YtEcB6717b3d5suQ@8bytes.org>
References: <20220627085533.1469141-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627085533.1469141-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Robin.

On Mon, Jun 27, 2022 at 04:55:33PM +0800, Yang Yingliang wrote:
> cookie_alloc() is called by iommu_get_dma_cookie() and iommu_get_msi_cookie(),
> but the mutex is only initialized in iommu_get_dma_cookie(), move mutex_init()
> into cookie_alloc() to make sure the mutex will be initialized.
> 
> Fixes: ac9a5d522bb8 ("iommu/dma: Fix race condition during iova_domain initialization")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/iommu/dma-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 1910f4f1612b..e29157380c48 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -294,6 +294,7 @@ static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
>  	if (cookie) {
>  		INIT_LIST_HEAD(&cookie->msi_page_list);
>  		cookie->type = type;
> +		mutex_init(&cookie->mutex);
>  	}
>  	return cookie;
>  }
> @@ -311,7 +312,6 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
>  	if (!domain->iova_cookie)
>  		return -ENOMEM;
>  
> -	mutex_init(&domain->iova_cookie->mutex);
>  	return 0;
>  }
>  
> -- 
> 2.25.1
