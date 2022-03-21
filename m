Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237E2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 10:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346526AbiCUK7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 06:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346524AbiCUK7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:59:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5D21ADB8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:58:25 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nWFjs-0007N4-Vq; Mon, 21 Mar 2022 11:58:17 +0100
Message-ID: <73570ee11ddbbda96463e8fad3ad533c83716782.camel@pengutronix.de>
Subject: Re: [PATCH V2] soc: imx: imx8m-blk-ctrl: Fix IMX8MN_DISPBLK_PD_ISI
 hang
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 21 Mar 2022 11:58:15 +0100
In-Reply-To: <20220320205212.701548-1-aford173@gmail.com>
References: <20220320205212.701548-1-aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, dem 20.03.2022 um 15:52 -0500 schrieb Adam Ford:
> The imx8mn clock list for the ISI lists four clocks, but DOMAIN_MAX_CLKS
> was set to 3.  Because of this, attempts to enable the fourth clock failed,
> threw some splat, and ultimately hung.
> 
> Fixes: 7f511d514e8c ("soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> 
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> index a0a0d2d7ca4a..7109f0d508e2 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -50,7 +50,7 @@ struct imx8m_blk_ctrl_domain_data {
>  	u32 mipi_phy_rst_mask;
>  };
>  
> -#define DOMAIN_MAX_CLKS 3
> +#define DOMAIN_MAX_CLKS 4
>  
>  struct imx8m_blk_ctrl_domain {
>  	struct generic_pm_domain genpd;


