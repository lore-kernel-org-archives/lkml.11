Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A3CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 15:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbiBRPZS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 10:25:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiBRPZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:25:17 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249672B1A9B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:24:59 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E894D1C0009;
        Fri, 18 Feb 2022 15:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645197898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bH9jFFMUpeu1jlpFnHW5Tq0sYFAnVpCE7f4kf0gx5uo=;
        b=EJbQ27ckGECJAr6ecUFCTGJJDDfnsaIrk8a2yf+1Vp7ZYZWk5Wv1UIpVhciwT1im2jJIXc
        ZhUhKZb27ghHjdsKI0lQ7MYZlQ+c+iPxvMhGNDEYQYPbr1hXTjTnoIQ4MC25lXQCINH7fm
        BetfPA3+IZAEtPa/mLRfrlavDGR0EJdgSecEyf4ucfjM1S2RzY3x3i9/E3QQEZOWx70Xdx
        ZbEOgnkJBfQ6U6ycTk3iY+RFPsEBIOZeRhYnp2hHWD0JbJXtXWeQCiuxaBUbM8Jq/aUFKb
        QgDoVbUeyWD7fUVU1SvrFJnRi/EtVfCd/OS2aruX7xecOcjhIPDKB2P1+CVWcw==
Date:   Fri, 18 Feb 2022 16:24:55 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mpm@selenic.com, herbert@gondor.apana.org.au,
        nicolas.ferre@microchip.com, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] hwrnd: atmel - add runtime pm support
Message-ID: <Yg+6R52is+0tQk3d@piout.net>
References: <20220218101712.530576-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218101712.530576-1-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2022 12:17:05+0200, Claudiu Beznea wrote:
> Hi,
> 
> This series adds runtime PM support for atmel-rng driver. Along with
> this some cleanup and fixes patches were added to the series.
> 
> Thank you,
> Claudiu Beznea
> 
> Claudiu Beznea (7):
>   hwrng: atmel - add wait for ready support on read
>   hwrnd: atmel - disable trng on failure path
>   hwrnd: atmel - rename enable/disable functions to init/cleanup
>   hwrng: atmel - move set of TRNG_HALFR in atmel_trng_init()
>   hwrnd: atmel - use __maybe_unused and pm_ptr() for pm ops
>   hwrnd: atmel - add runtime pm support
>   hwrnd: atmel - remove extra line
>

I don't mind too much but you are mixing hwrng and hwrnd ;)
 
>  drivers/char/hw_random/atmel-rng.c | 148 ++++++++++++++++++-----------
>  1 file changed, 91 insertions(+), 57 deletions(-)
> 
> -- 
> 2.32.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
