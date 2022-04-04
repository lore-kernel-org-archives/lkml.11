Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364A3C4332F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 10:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357078AbiDDKUQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 06:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356962AbiDDKUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:20:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901ED3C717
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:18:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbJmo-0002A5-Ki; Mon, 04 Apr 2022 12:18:14 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbJmm-0010WZ-M1; Mon, 04 Apr 2022 12:18:11 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbJmk-0006k3-H6; Mon, 04 Apr 2022 12:18:10 +0200
Message-ID: <b8ca583f3fbd4e0a25181d2ccdd0c05034561c74.camel@pengutronix.de>
Subject: Re: [PATCH] reset: simple: Add AST2600 compatible
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 Apr 2022 12:18:10 +0200
In-Reply-To: <20220221072650.129348-1-joel@jms.id.au>
References: <20220221072650.129348-1-joel@jms.id.au>
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

On Mo, 2022-02-21 at 17:56 +1030, Joel Stanley wrote:
> Similar to the 2400 and 2500, the LPC controller has some simple
> reset
> lines that are used by the UART devices.
> 
> This is already documented in LPC bindings document.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/reset/reset-simple.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-
> simple.c
> index 4dda0daf2c6f..361a68314265 100644
> --- a/drivers/reset/reset-simple.c
> +++ b/drivers/reset/reset-simple.c
> @@ -144,6 +144,7 @@ static const struct of_device_id
> reset_simple_dt_ids[] = {
>                 .data = &reset_simple_active_low },
>         { .compatible = "aspeed,ast2400-lpc-reset" },
>         { .compatible = "aspeed,ast2500-lpc-reset" },
> +       { .compatible = "aspeed,ast2600-lpc-reset" },
>         { .compatible = "bitmain,bm1880-reset",
>                 .data = &reset_simple_active_low },
>         { .compatible = "brcm,bcm4908-misc-pcie-reset",

Thank you, applied to reset/next.

regards
Philipp
