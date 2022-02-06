Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F0FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Feb 2022 19:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiBFT1B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Feb 2022 14:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiBFT07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 14:26:59 -0500
Received: from mx2.smtp.larsendata.com (mx2.smtp.larsendata.com [91.221.196.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF7DC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 11:26:56 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx2.smtp.larsendata.com (Halon) with ESMTPS
        id e3284930-8782-11ec-ac19-0050568cd888;
        Sun, 06 Feb 2022 19:27:56 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 014B5194BDB;
        Sun,  6 Feb 2022 20:26:52 +0100 (CET)
Date:   Sun, 6 Feb 2022 20:26:50 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, ~okias/devicetree@lists.sr.ht,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: JDI LT070ME05000 remove useless warning
Message-ID: <YgAg+lklFqPhVgS8@ravnborg.org>
References: <20220206190702.450643-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206190702.450643-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Sun, Feb 06, 2022 at 08:07:02PM +0100, David Heidelberg wrote:
> Do as most of panel and in case of deffered probe, don't print error.
> 
> Fixes warning:
> panel-jdi-lt070me05000 4700000.dsi.0: cannot get enable-gpio -517
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/gpu/drm/panel/panel-jdi-lt070me05000.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
> index ea0e7221e706..b5c0b51dc146 100644
> --- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
> +++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
> @@ -408,7 +408,8 @@ static int jdi_panel_add(struct jdi_panel *jdi)
>  	jdi->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
>  	if (IS_ERR(jdi->enable_gpio)) {
>  		ret = PTR_ERR(jdi->enable_gpio);
> -		dev_err(dev, "cannot get enable-gpio %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "cannot get enable-gpio %d\n", ret);
>  		return ret;
>  	}

Thanks for submitting a fix for this.
Please look into the use of dev_err_probe() for this as this is the
preferred way to fix it now.

	Sam
