Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F40C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 17:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241509AbiESRQ5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 13:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbiESRQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:16:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2F32FFCA;
        Thu, 19 May 2022 10:16:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEFD0616C1;
        Thu, 19 May 2022 17:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2471C385AA;
        Thu, 19 May 2022 17:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652980613;
        bh=NzDa1LM1fArKMIx8GaH8Ju/+45nyxosJyGcCg2/N/N8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OOw1rebPNPjpiCVy97h1ZxdxqiPU29XbDq8OqVbbsoiFTzBbuhTne1C8z0bVyza7o
         Tc3UU3pyIrDlXWAlQpWdhJXB+97LTcMs0YqqKfyEw/pREtYdpj9mLWbpZtfTvCnLA5
         O1hEaOAxJARgyQgzUUmc+6HvqebZb3g8yWhG028kg1IE/tkrMini0fpZy36rla8I6x
         d+nutH/mHWAvKT/15aFEnTl7H4ZxmZ/L775NZTsFXUBHzfCYTLSd4Ul0LkP9i3DNSZ
         bzwNK9nRmr4B8+z6QRj5x4prlEw59MhYW4bDs9wqcuIJuDsaXaNMnnMsHHfCoy5kal
         /pfVjQ1Kfk7EA==
Date:   Thu, 19 May 2022 22:46:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     rgumasta@nvidia.com, pkunapuli@nvidia.com, treding@nvidia.com,
        digetx@gmail.com, akhilrajeev@nvidia.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: tegra: Fix build error without IOMMU_API
Message-ID: <YoZ7gdk06BqC9N+9@matsya>
References: <20220505093236.15076-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220505093236.15076-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-05-22, 17:32, YueHaibing wrote:
> drivers/dma/tegra186-gpc-dma.c: In function ‘tegra_dma_probe’:
> drivers/dma/tegra186-gpc-dma.c:1364:24: error: ‘struct iommu_fwspec’ has no member named ‘ids’
>   stream_id = iommu_spec->ids[0] & 0xffff;
>                         ^~
> 
> Make TEGRA186_GPC_DMA depends on IOMMU_API to fix this.

Applied, thanks

> 
-- 
~Vinod
