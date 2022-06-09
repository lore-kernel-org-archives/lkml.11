Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBF9C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 05:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbiFIFsY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 01:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiFIFsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:48:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CE723B70A;
        Wed,  8 Jun 2022 22:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D51A1B82C20;
        Thu,  9 Jun 2022 05:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C35C34114;
        Thu,  9 Jun 2022 05:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654753697;
        bh=srvycSML/3DtXuGTOU81tu/ONwTrX8FWExQdjZdpSHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PpU8+4R5/EkFK7UvLyHRVyIZ8XCh8GpzDaIeagtOUeiI4TpXM1CfKmuss5/zoDqsg
         8QoXCaAlyJqBSB7sBXLYpo4N7iv71diwLmmxUCnUcPdGzDm9JTwfER1LOQgajba8d6
         00Y5qiZY/F34QkvvUDJHm6RdrQYT85L20QXje5VuPUi5XfInM4m5PUol30TjD1HNY8
         tkhV3b1moxJAW+a+/y5Gpsql5phAM1DL/3iSbCif6wLEZ3gbZugCydsA7fJLCPHAkO
         gTgp23USO6LkjmbXiuPbWI28cx4cASf4FPdCMWk6NDHILxR/AL9jxDE1pafnCtAndb
         7FrojzZRPyajw==
Date:   Thu, 9 Jun 2022 11:18:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com, stable@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v2] dmaengine: mxs: fix driver registering
Message-ID: <YqGJnORzbp2xiEU3@matsya>
References: <20220607095829.1035903-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607095829.1035903-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-22, 11:58, Dario Binacchi wrote:
> Driver registration fails on SOC imx8mn as its supplier, the clock
> control module, is not ready. Since platform_driver_probe(), as
> reported by its description, is incompatible with deferred probing,
> we have to use platform_driver_register().
> 
> Fixes: a580b8c5429a ("dmaengine: mxs-dma: add dma support for i.MX23/28")
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Cc: stable@vger.kernel.org
> 
> ---
> 
> Changes in v2:
> - Add the tag "Cc: stable@vger.kernel.org" in the sign-off area.
> 
>  drivers/dma/mxs-dma.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> index 994fc4d2aca4..b8a3e692330d 100644
> --- a/drivers/dma/mxs-dma.c
> +++ b/drivers/dma/mxs-dma.c
> @@ -670,7 +670,7 @@ static enum dma_status mxs_dma_tx_status(struct dma_chan *chan,
>  	return mxs_chan->status;
>  }
>  
> -static int __init mxs_dma_init(struct mxs_dma_engine *mxs_dma)
> +static int mxs_dma_init(struct mxs_dma_engine *mxs_dma)

why drop __init for these...?

>  {
>  	int ret;
>  
> @@ -741,7 +741,7 @@ static struct dma_chan *mxs_dma_xlate(struct of_phandle_args *dma_spec,
>  				     ofdma->of_node);
>  }
>  
> -static int __init mxs_dma_probe(struct platform_device *pdev)
> +static int mxs_dma_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
>  	const struct mxs_dma_type *dma_type;
> @@ -839,10 +839,7 @@ static struct platform_driver mxs_dma_driver = {
>  		.name	= "mxs-dma",
>  		.of_match_table = mxs_dma_dt_ids,
>  	},
> +	.probe = mxs_dma_probe,
>  };
>  
> -static int __init mxs_dma_module_init(void)
> -{
> -	return platform_driver_probe(&mxs_dma_driver, mxs_dma_probe);
> -}

> -subsys_initcall(mxs_dma_module_init);
> +module_platform_driver(mxs_dma_driver);
> -- 
> 2.32.0

-- 
~Vinod
