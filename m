Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78568C6FA82
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 14:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbiIBOtk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 10:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbiIBOtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:49:04 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED4AA59AF;
        Fri,  2 Sep 2022 07:10:27 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6C826C0019;
        Fri,  2 Sep 2022 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662127826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=foJpWALHT8diJKC3gFfZMbMqoru/vx4Wr7PWfEagvV4=;
        b=PHSLSiuqG5UA4f2xzslzfJoJD9vCTjbkRTmN71HPkQjM7uegoDXSjNqjJadcvC8H/8LxGy
        82pNAgcEX0WCuAMdRdKt4L9Q/vwKSlqxBhsTZ9MJP0o0pfcqGD3fRFt7850zT+IbONqFmz
        jFvVrIhfVJntZR3kIKUWjbfcZQF7rdNeRwNBbrDIWRIhyAK10m7Ll6+Z4dlzYgBf8c164r
        VC+2n2q75COyGLINhfVmB4sC9sxDCtKvFkcFoQh916YysJuESEYN3Cp2/mwQHfmZXGRDE0
        cewI6BoCb+2yGzNtzbrr3Ki36kTgHAvf6k7s3g0mBiagroJ/ZDKCXmOxdIZkVQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: armada-xp: align SPI node name with dtschema
In-Reply-To: <20220810111122.281184-1-krzysztof.kozlowski@linaro.org>
References: <20220810111122.281184-1-krzysztof.kozlowski@linaro.org>
Date:   Fri, 02 Sep 2022 16:10:25 +0200
Message-ID: <8735d9g94e.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> The node names should be generic and DT schema expects certain pattern.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied on mvebu/dt

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
> index 87dcb502f72d..0dad95ea26c2 100644
> --- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
> +++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
> @@ -164,7 +164,7 @@ scroll-button {
>  		};
>  	};
>  
> -	spi3 {
> +	spi-3 {
>  		compatible = "spi-gpio";
>  		status = "okay";
>  		gpio-sck = <&gpio0 25 GPIO_ACTIVE_LOW>;
> -- 
> 2.34.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
