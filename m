Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBA3C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 14:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbiF2ODA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 10:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiF2OC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:02:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D9C23156
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:02:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o6YHG-0002O8-QV; Wed, 29 Jun 2022 16:02:46 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o6YHA-003PQA-9a; Wed, 29 Jun 2022 16:02:43 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o6YHD-0009tN-4w; Wed, 29 Jun 2022 16:02:43 +0200
Message-ID: <c6794e78b9425c84f090d3058b93319bbb17e10f.camel@pengutronix.de>
Subject: Re: [PATCH RESEND v5 1/8] reset: Fix devm bulk optional exclusive
 control getter
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 29 Jun 2022 16:02:43 +0200
In-Reply-To: <20220624141853.7417-2-Sergey.Semin@baikalelectronics.ru>
References: <20220624141853.7417-1-Sergey.Semin@baikalelectronics.ru>
         <20220624141853.7417-2-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On Fr, 2022-06-24 at 17:18 +0300, Serge Semin wrote:
> Most likely due to copy-paste mistake the device managed version of the
> denoted reset control getter has been implemented with invalid semantic,
> which can be immediately spotted by having "WARN_ON(shared && acquired)"
> warning in the system log as soon as the method is called. Anyway let's
> fix it by altering the boolean arguments passed to the
> __devm_reset_control_bulk_get() method from
> - shared = true, optional = false, acquired = true
> to
> + shared = false, optional = true, acquired = true
> That's what they were supposed to be in the first place (see the non-devm
> version of the same method: reset_control_bulk_get_optional_exclusive()).
> 
> Fixes: 48d71395896d ("reset: Add reset_control_bulk API")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v4:
> - This is a new patch added on v4 lap of the series.
> ---
>  include/linux/reset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index 8a21b5756c3e..514ddf003efc 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -731,7 +731,7 @@ static inline int __must_check
>  devm_reset_control_bulk_get_optional_exclusive(struct device *dev, int num_rstcs,
>  					       struct reset_control_bulk_data *rstcs)
>  {
> -	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, true, false, true);
> +	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, false, true, true);
>  }

You are right, thank you. I'll take this as a sign that the internal
functions should probably switch from collecting ever more boolean
arguments to a flags parameter, similar to enum gpiod_flags.

I'll pick this up separately into the reset/fixes branch.

regards
Philipp
