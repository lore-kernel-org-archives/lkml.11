Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A95ECAAD3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 18:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbiIASL1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 14:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiIASLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:11:03 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A018D23BEC;
        Thu,  1 Sep 2022 11:10:38 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BF7E06CD;
        Thu,  1 Sep 2022 20:10:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662055837;
        bh=yisMqaoWBDsbWebXqcpHBHBjvKY6q+kjKiEmjB4kfeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LzKug78Jh6jAwH5sL52x6kMBrm941Z72a6IYapStVAuwe5lJ92fR5S4wTK6jAZWKc
         1ziH80WGYihPVFmtuqImuWOKECc6zGrlG23uVu9B46N0MuL3zuh0Ls5W6W0U4eH8xM
         cua6gl/RILJerjkUSreHo/7jOnJ1tM7++0dn0qf4=
Date:   Thu, 1 Sep 2022 21:10:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp-verdin: add dsi to lvds
 functionality
Message-ID: <YxD1kecBOaqG+GNh@pendragon.ideasonboard.com>
References: <20220901154051.1885509-1-max.oss.09@gmail.com>
 <20220901154051.1885509-2-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220901154051.1885509-2-max.oss.09@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

Thank you for the patch.

On Thu, Sep 01, 2022 at 05:40:51PM +0200, Max Krummenacher wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> Add a panel-lvds node and use the correct dsi to lvds chip name.
> Both to be later extended in a dt overlay according to the exact
> board HW configuration.

Same as with patch 1/2, this doesn't look right. The panel isn't part of
the Verdin SoM, it's not even part of the base board. It should be moved
to an overlay, and the SN65DSI83, which I understand isn't on the SoM
either, should be moved somewhere else too..

> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> ---
> 
>  arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> index bd84a0d135dc..a3e20c7add3e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> @@ -67,6 +67,13 @@ hdmi_connector: hdmi-connector {
>  		status = "disabled";
>  	};
>  
> +	panel_lvds: panel-lvds {
> +		compatible = "panel-lvds";
> +		backlight = <&backlight>;
> +		data-mapping = "vesa-24";
> +		status = "disabled";
> +	};
> +
>  	/* Carrier Board Supplies */
>  	reg_1p8v: regulator-1p8v {
>  		compatible = "regulator-fixed";
> @@ -690,8 +697,8 @@ gpio_expander_21: gpio-expander@21 {
>  		status = "disabled";
>  	};
>  
> -	lvds_ti_sn65dsi83: bridge@2c {
> -		compatible = "ti,sn65dsi83";
> +	lvds_ti_sn65dsi84: bridge@2c {
> +		compatible = "ti,sn65dsi84";
>  		/* Verdin GPIO_9_DSI (SN65DSI84 IRQ, SODIMM 17, unused) */
>  		/* Verdin GPIO_10_DSI (SODIMM 21) */
>  		enable-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;

-- 
Regards,

Laurent Pinchart
