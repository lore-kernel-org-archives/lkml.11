Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91793C4321E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 09:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbiEIJfG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 05:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237997AbiEIJDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:03:15 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4BB1F2D55;
        Mon,  9 May 2022 01:59:21 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 72C8840010;
        Mon,  9 May 2022 08:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652086743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GlfE+eMNWZzjVhKznIxmSnTKmF7zpHT4YD9wNmX5k2E=;
        b=WMevReCeo2A5kiQiz+3netIPtBlgC36e1qsQMUdkXUBOmgSiXgr0s7iAxAKM7kxV9x1F3C
        U/ZNrFIjK4maROzDydD0u1B4EjgServOkMIcOhUQhCTGM6lOgfN1GmkRRkJuPT488QPUft
        F9eZgTf4pH0DxoF4Ag0gDu41wZuFk3ahKm0yPkxcI59FxmvyQ7k75x2soRFJtCO3QA/lVG
        xds9u19AL0tYaAKTo1AIv+Nkqi1p25OPxyCzZZ0JxY5cT4k2fFMpnF2N0xJ1YPD2FmliHW
        4YoqkukZ2ahSmC66t7ihMZYCpFbt0qem2n5RRMf6tKDOdFjhsNG7fUOM0xIOXQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Robert Marko <robert.marko@sartura.hr>, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pali@kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v3 3/3] arm64: dts: marvell: espressobin-ultra: enable
 front USB3 port
In-Reply-To: <20210928170919.691845-3-robert.marko@sartura.hr>
References: <20210928170919.691845-1-robert.marko@sartura.hr>
 <20210928170919.691845-3-robert.marko@sartura.hr>
Date:   Mon, 09 May 2022 10:58:53 +0200
Message-ID: <87ee13rsj6.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Marko <robert.marko@sartura.hr> writes:

> Espressobin Ultra has a front panel USB3.0 Type-A port which works
> just fine so enable it.
> I dont see a reason why it was disabled in the first place anyway.
>
> Fixes: 3404fe15a60f ("arm64: dts: marvell: add DT for ESPRESSObin-Ultra")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>


Applied on mvebu/dt64

Thanks,

Gregory


> ---
> Changes in v2:
> * Add Fixes tag
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> index 7c786d218f1b..070725b81be5 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> @@ -108,7 +108,6 @@ rtc@51 {
>  
>  &usb3 {
>  	usb-phy = <&usb3_phy>;
> -	status = "disabled";
>  };
>  
>  &mdio {
> -- 
> 2.31.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
