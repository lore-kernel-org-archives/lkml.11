Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C830BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Apr 2022 11:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378261AbiDTLxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 07:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378252AbiDTLxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:53:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F19611A1B;
        Wed, 20 Apr 2022 04:50:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49BBAB81D03;
        Wed, 20 Apr 2022 11:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66082C385A0;
        Wed, 20 Apr 2022 11:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650455428;
        bh=wG8tmbya06CPHuXCrYxIi0BacRXo9h6kKzxQ63v1SQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=goW7qCzb0qVQ+i8Tl9MVckC5HdTcV77J9bk4vVuQ+jn7j8V1i0usNZd1k0zAgHJ32
         QZL12QXEGFp5yzjlMHi5wt/S7o/4aAxDXTPniexIgN+boLPFlJd/1Kt7YlR9QgoT7t
         pMYjM5kpCPeEscMQBFVWOMLOX9S+SFUhKpfqs5NNazbOP/uhdtVLl7zcO7fj/u0drw
         tS9fii/pMGGyPtSrdW0v6m/zkJdUGLVMCSMtHsbPBuWzrBB08Sx74uQtA2/RAJuEMt
         llYZAYqp28vxsAZQZvqVRHuxtqa4z9QvIGZR+lX72+caha7s3vQVDQ/Jr1bsVqZ8Ti
         ObDJSVkmEzNIA==
Date:   Wed, 20 Apr 2022 17:20:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: mediatek: mtk-hsdma: use NULL instead of
 using plain integer as pointer
Message-ID: <Yl/zgH28KL9zbcQb@matsya>
References: <1649750340-30777-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649750340-30777-1-git-send-email-baihaowen@meizu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-04-22, 15:59, Haowen Bai wrote:
> This fixes the following sparse warnings:
> drivers/dma/mediatek/mtk-hsdma.c:604:26: warning: Using plain integer
> as NULL pointer

Applied, thanks

> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/dma/mediatek/mtk-hsdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
> index 6ad8afbb95f2..358894e72fba 100644
> --- a/drivers/dma/mediatek/mtk-hsdma.c
> +++ b/drivers/dma/mediatek/mtk-hsdma.c
> @@ -601,7 +601,7 @@ static void mtk_hsdma_free_rooms_in_ring(struct mtk_hsdma_device *hsdma)
>  			cb->flag = 0;
>  		}
>  
> -		cb->vd = 0;
> +		cb->vd = NULL;
>  
>  		/*
>  		 * Recycle the RXD with the helper WRITE_ONCE that can ensure
> -- 
> 2.7.4

-- 
~Vinod
