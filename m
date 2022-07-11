Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6BEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 16:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiGKQhk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 12:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGKQhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:37:38 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F612D1EC;
        Mon, 11 Jul 2022 09:37:38 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BC040326;
        Mon, 11 Jul 2022 18:37:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1657557456;
        bh=H0/PNeex08QqGr77w/wMDcNvV0zS5pcv6Pf6XA2aPDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RTHbug2ivmL13wgsm46BJgzLm1/MJcV9RJDHMvgLRee/0y/XcCP8UrOI/QFYWzh7o
         VBeOT83TvBUmCJy96bBLw+V1gyotx/TrwsBWvuuMLg1i0oawFcQFLqu9ASdrVxTWKv
         I1eUUiE1uCEt2xlOowiTWy+2JnZouYBDZntKP/1I=
Date:   Mon, 11 Jul 2022 19:37:09 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     XueBing Chen <chenxuebing@jari.cn>
Cc:     hyun.kwon@xilinx.com, vkoul@kernel.org, michal.simek@xilinx.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: xilinx: use strscpy to replace strlcpy
Message-ID: <YsxRtSDbRK+lCnnD@pendragon.ideasonboard.com>
References: <39aa840f.e31.181ed9461c2.Coremail.chenxuebing@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39aa840f.e31.181ed9461c2.Coremail.chenxuebing@jari.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi XueBing,

Thank you for the patch.

On Mon, Jul 11, 2022 at 10:05:33PM +0800, XueBing Chen wrote:
> 
> The strlcpy should not be used because it doesn't limit the source
> length. Preferred is strscpy.
> 
> Signed-off-by: XueBing Chen <chenxuebing@jari.cn>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/dma/xilinx/xilinx_dpdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index b0f4948b00a5..f5815465e83b 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -376,7 +376,7 @@ static ssize_t xilinx_dpdma_debugfs_read(struct file *f, char __user *buf,
>  		if (ret < 0)
>  			goto done;
>  	} else {
> -		strlcpy(kern_buff, "No testcase executed",
> +		strscpy(kern_buff, "No testcase executed",
>  			XILINX_DPDMA_DEBUGFS_READ_MAX_SIZE);
>  	}
>  
-- 
Regards,

Laurent Pinchart
