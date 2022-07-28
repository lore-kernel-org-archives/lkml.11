Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7D3C19F29
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jul 2022 12:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiG1MKu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jul 2022 08:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbiG1MKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:10:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06ED49B6A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:10:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oH2Li-0004UP-J0; Thu, 28 Jul 2022 14:10:42 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oH2Lh-000Ir3-J5; Thu, 28 Jul 2022 14:10:41 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oH2Lg-0005lS-Qa; Thu, 28 Jul 2022 14:10:40 +0200
Message-ID: <7e39f714f6e06c48889dacb35579e7d498e4cf0f.camel@pengutronix.de>
Subject: Re: [PATCH][next] reset: tps380x: Fix spelling mistake "Voltags" ->
 "Voltage"
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 28 Jul 2022 14:10:40 +0200
In-Reply-To: <20220728110554.18320-1-colin.i.king@gmail.com>
References: <20220728110554.18320-1-colin.i.king@gmail.com>
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

Hi Colin,

On Do, 2022-07-28 at 12:05 +0100, Colin Ian King wrote:
> There is a spelling mistake in the MODULE_DESCRIPTION text. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/reset/reset-tps380x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/reset-tps380x.c b/drivers/reset/reset-tps380x.c
> index e07f5865fe30..09d511f069ba 100644
> --- a/drivers/reset/reset-tps380x.c
> +++ b/drivers/reset/reset-tps380x.c
> @@ -122,5 +122,5 @@ static struct platform_driver tps380x_reset_driver = {
>  module_platform_driver(tps380x_reset_driver);
>  
> 
>  MODULE_AUTHOR("Marco Felsch <kernel@pengutronix.de>");
> -MODULE_DESCRIPTION("TI TPS380x Supply Voltags Supervisor and Reset Driver");
> +MODULE_DESCRIPTION("TI TPS380x Supply Voltage Supervisor and Reset Driver");
>  MODULE_LICENSE("GPL v2");

Thank you, applied to reset/next.

regards
Philipp
