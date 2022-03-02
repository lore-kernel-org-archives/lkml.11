Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18431C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 09:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbiCBJtq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 04:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiCBJtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:49:43 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D550CB91DC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:48:59 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DA30F200004;
        Wed,  2 Mar 2022 09:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646214538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XONB/+Q2uIiRe6FA91u/IHYG5GnofPRpfBepye8euXo=;
        b=UqmIVn9aM+peXOb7taEyk50/TbWkselngS71kTQC+m6EVIR91a3vgS/LXkLSm4VbNJRHAt
        mRQnkT8cXd1Yqq+4gVX1CDoeqVrXpe7xdXY53Lqcww4gScaa0V7j3vp6Rmk4rdcupp8mDh
        A3zrblyHzHHVfSYi8atnh5kBYM09Dl533z9/2FmoYTN/5m+MfBoj4ZlXvKArsAyYwpm4Co
        US/BGQkjPd/N6gjexmmlEEXwzBA8aBOPkiAWzo1s36RktWKKWdbos5ymX1RY+NXV5rnKEF
        sSYvsaF/ZVbwb3ItryvGFG0gltIvsHlCReVVS8dxtX9XBxulXsqZ201bm6cLPQ==
Date:   Wed, 2 Mar 2022 10:48:57 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     codrin.ciubotariu@microchip.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: atmel-ssc: Handle error for clk_prepare_enable
Message-ID: <Yh89idAr6BiqqdaM@piout.net>
References: <20220302084319.96435-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302084319.96435-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2022 16:43:19+0800, Jiasheng Jiang wrote:
> As the potential failure of the clk_prepare_enable(),
> it should be better to check it and return error if fails.
> 

this will never ever fail, this patch doesn't fix any actual issue

> Fixes: eb1f2930609b ("Driver for the Atmel on-chip SSC on AT32AP and AT91")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/misc/atmel-ssc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
> index d6cd5537126c..c76ca234af4b 100644
> --- a/drivers/misc/atmel-ssc.c
> +++ b/drivers/misc/atmel-ssc.c
> @@ -192,6 +192,7 @@ static int ssc_probe(struct platform_device *pdev)
>  	struct resource *regs;
>  	struct ssc_device *ssc;
>  	const struct atmel_ssc_platform_data *plat_dat;
> +	int ret;
>  
>  	ssc = devm_kzalloc(&pdev->dev, sizeof(struct ssc_device), GFP_KERNEL);
>  	if (!ssc) {
> @@ -226,7 +227,10 @@ static int ssc_probe(struct platform_device *pdev)
>  	}
>  
>  	/* disable all interrupts */
> -	clk_prepare_enable(ssc->clk);
> +	ret = clk_prepare_enable(ssc->clk);
> +	if (ret)
> +		return ret;
> +
>  	ssc_writel(ssc->regs, IDR, -1);
>  	ssc_readl(ssc->regs, SR);
>  	clk_disable_unprepare(ssc->clk);
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
