Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D6FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Feb 2022 02:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiBMCHY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Feb 2022 21:07:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiBMCHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 21:07:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAF95FF1D;
        Sat, 12 Feb 2022 18:07:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 270E060EF0;
        Sun, 13 Feb 2022 02:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3731DC340E7;
        Sun, 13 Feb 2022 02:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644718036;
        bh=I7BX+pR8ZnHF7tEuOEia/wz+P7KBxhiUse/dorazwY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rXU+SiH/EmxpZcGVUX1ykXJ1Ewb0dzWYn/FUvvxBXi0U2KnuZ0jKwGHFjaeTP/Jqj
         cBvNpWmkWs4Y0MZUP/8HHyUi6X8QAsiAH5r5ZceE6YgBpibl2JKu00tV/vWe78IjSV
         nWxkDaSqmbx/aVDlB8EQ/lYOcrL7i7MabWhTMGmKVxo/ToUrcghXHZybwpquyHDGOP
         tpgT+TZOBXrVUVbsJ5xjvfaY0xqnnxTNQvSeq2eXopTeyzevzb6gxBWTi0wFKsHH6P
         hDvYxS3XleNJLJo3v8wH1DdT4d16NzvwLsVzFOdKlkSjmRSOKAiMoHKeLQ8UoEPB2w
         GdEu1ggBh01+g==
Date:   Sun, 13 Feb 2022 10:07:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Changming Huang <jerry.huang@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianchao Wang <jianchao.wang@nxp.com>
Subject: Re: [PATCH] arm64: dts: fsl-ls1028a: add dspi2 support
Message-ID: <20220213020710.GH4909@dragon>
References: <20220208042610.2026531-1-jerry.huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208042610.2026531-1-jerry.huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 12:26:10PM +0800, Changming Huang wrote:
> Enable MikroBUS SPI port.
> 
> Signed-off-by: Jianchao Wang <jianchao.wang@nxp.com>
> Signed-off-by: Changming Huang <jerry.huang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index 68c31cb8eead..af2c7eb07eaf 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -93,6 +93,19 @@ simple-audio-card,codec {
>  	};
>  };
>  
> +&dspi2 {

Sort the labeling node alphabetically.

> +	bus-num = <2>;
> +	status = "okay";
> +
> +	mikrobus@0 {
> +		compatible = "semtech,sx1301";

Did you run dtbs_check?

Shawn

> +		reg = <0>;
> +		spi-max-frequency = <2000000>;
> +		fsl,spi-cs-sck-delay = <1000000>;
> +		fsl,spi-sck-cs-delay = <50>;
> +	};
> +};
> +
>  &can0 {
>  	status = "okay";
>  
> -- 
> 2.25.1
> 
