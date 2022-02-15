Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E98AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 05:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiBOF0f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 00:26:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiBOF0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:26:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C04F99;
        Mon, 14 Feb 2022 21:26:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9EB5B81732;
        Tue, 15 Feb 2022 05:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3A4C340EC;
        Tue, 15 Feb 2022 05:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644902779;
        bh=Mrc5n5STDODQ2jMunDINBcbrAtfkEKJpZ3JG+krR1YI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gKKOwZ+N0eV8TuLw7amp5W2ll3X9mcTKYxwjuV56J/QgDGf0mIIB0sL8DdxUB4MpS
         EtKIad7aFRfev1rcjOSBZIKqVpt3X/Fuk93NHyg6VvDfEqkhGX4cZZZQ/r2jbzFb1H
         77qSInjQVSuJ3EH1msLWQTZp7oSQPs/UTFIBSApVj5wSVm0uCgTChYTVp0FmPR2x9d
         ZbO2Vp2IKPGKUZs2/kuhrskTU7dheXHfrgzKO37Ez38lwZUP33sYya80eTiSfOta+T
         WS8tYx4PJYnzubrWtbN4MGrD/lLupS8/Hx7YXT/49iMF4nLsdcB8MoYsuLfOOzDTQT
         cjefr0G+0ncWQ==
Date:   Tue, 15 Feb 2022 10:56:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        ludovic.desroches@microchip.com, tudor.ambarus@microchip.com
Subject: Re: [PATCH -next] dmaengine: at_xdmac: Fix missing unlock in
 at_xdmac_tasklet()
Message-ID: <Ygs5d3MFR7R+Z5YA@matsya>
References: <20220107024047.1051915-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107024047.1051915-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-01-22, 10:40, Yang Yingliang wrote:
> Add the missing unlock before return from at_xdmac_tasklet().

Applied, thanks

> 
> Fixes: e77e561925df ("dmaengine: at_xdmac: Fix race over irq_status")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/dma/at_xdmac.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index a1da2b4b6d73..1476156af74b 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -1681,8 +1681,10 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
>  		__func__, atchan->irq_status);
>  
>  	if (!(atchan->irq_status & AT_XDMAC_CIS_LIS) &&
> -	    !(atchan->irq_status & error_mask))
> +	    !(atchan->irq_status & error_mask)) {
> +		spin_unlock_irq(&atchan->lock);
>  		return;
> +	}
>  
>  	if (atchan->irq_status & error_mask)
>  		at_xdmac_handle_error(atchan);
> -- 
> 2.25.1

-- 
~Vinod
