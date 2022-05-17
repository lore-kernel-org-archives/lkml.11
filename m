Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01163C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 18:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352362AbiEQSr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 14:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352353AbiEQSrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:47:55 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C28387B1;
        Tue, 17 May 2022 11:47:52 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nr2ET-0003v4-Q5; Tue, 17 May 2022 20:47:45 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: enable the gpu on BPI-R2-Pro
Date:   Tue, 17 May 2022 20:47:44 +0200
Message-ID: <5858497.iIbC2pHGDl@phil>
In-Reply-To: <20220415104951.27104-4-linux@fw-web.de>
References: <20220415104951.27104-1-linux@fw-web.de> <20220415104951.27104-4-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 15. April 2022, 12:49:51 CEST schrieb Frank Wunderlich:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Enable the GPU core on the Rockchip RK3568 BananaPi R2 Pro
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> index cc3591251bab..10f68d054f76 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> @@ -196,6 +196,11 @@ &gmac1m1_rgmii_clk
>  	status = "okay";
>  };
>  
> +&gpu {
> +	mali-supply = <&vdd_gpu>;
> +	status = "okay";
> +};
> +
>  &hdmi {
>  	avdd-0v9-supply = <&vdda0v9_image>;
>  	avdd-1v8-supply = <&vcca1v8_image>;
> @@ -566,6 +571,8 @@ &spi3 {
>  };
>  
>  &tsadc {
> +	rockchip,hw-tshut-mode = <1>;
> +	rockchip,hw-tshut-polarity = <0>;

This is not gpu-specific, so if needed should be a separate patch.

>  	status = "okay";
>  };
>  
> 




