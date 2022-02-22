Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CE5C4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 21:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbiBVV15 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 16:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbiBVV1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:27:31 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC807B55B;
        Tue, 22 Feb 2022 13:27:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 85AAE1F43C9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645565223;
        bh=9taHBRKeDVk3pqAcIWviMl4FP9lPlYjt9sExErI2Two=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OI6vcjXnKEAap1oo7yLdLSKaq/zJtCvz1L565DXez7v46BufwMQtbDe4C/cTevSFm
         n95HxUQQcgERx76OqyKtISyrunX5ZASrc5P3luaIxgwBwc7MjnTLYvElFVa0sxso+B
         qJMPcsTyvp2pn1g7AYMD+QNzZcI63z+a+xKQtM7m78+gpkoZ9/pBXvWte9O7zOBI7o
         k6O70T3iFLIYkkgT8AxH1z5BuoD0S+eyIqxjWTBL/AfIuQVyNa7vSP75p28B9TEyzM
         92KxVT4xPThFwEpkASPbuB6YCRc02wFTaKJb4qb4nfNGqtwCGkKwQw2vjWrZtEUQe+
         442F7NoxtQdQQ==
Date:   Tue, 22 Feb 2022 16:26:58 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
Subject: Re: [PATCH v2 14/23] arm64: dts: mt8192: Add mipi_tx node
Message-ID: <20220222212658.xuau6t3xcvu7m4uz@notapiano>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-15-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218091633.9368-15-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:16:24PM +0800, Allen-KH Cheng wrote:
> Add mipi_tx node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index cfc2db501108..f5e5af949f19 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1114,6 +1114,16 @@
>  			};
>  		};
>  
> +		mipi_tx0: mipi-dphy@11e50000 {

According to Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml, this
node's name should be dsi-phy, not mipi-dphy.

> +			compatible = "mediatek,mt8183-mipi-tx";
> +			reg = <0 0x11e50000 0 0x1000>;
> +			clocks = <&apmixedsys CLK_APMIXED_MIPID26M>;
> +			clock-names = "ref_clk";
> +			#clock-cells = <0>;
> +			#phy-cells = <0>;
> +			clock-output-names = "mipi_tx0_pll";
> +		};
> +
>  		i2c0: i2c@11f00000 {
>  			compatible = "mediatek,mt8192-i2c";
>  			reg = <0 0x11f00000 0 0x1000>,
> -- 
> 2.18.0
> 
> 
