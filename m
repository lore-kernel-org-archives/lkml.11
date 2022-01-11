Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583D8C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jan 2022 09:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349225AbiAKJOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jan 2022 04:14:34 -0500
Received: from mail.thorsis.com ([92.198.35.195]:47069 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236861AbiAKJO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:14:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 9F60D294F;
        Tue, 11 Jan 2022 10:14:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MHkN11x4GrbN; Tue, 11 Jan 2022 10:14:27 +0100 (CET)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 381F768; Tue, 11 Jan 2022 10:14:27 +0100 (CET)
Date:   Tue, 11 Jan 2022 10:14:12 +0100
From:   Alexander Dahl <ada@thorsis.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, robh+dt@kernel.org,
        bbrezillon@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: at91: sama5d2: Fix PMERRLOC resource size
Message-ID: <Yd1KZC+dg5GHruju@ada.ifak-system.com>
Mail-Followup-To: Tudor Ambarus <tudor.ambarus@microchip.com>,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, robh+dt@kernel.org,
        bbrezillon@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220111080933.800414-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111080933.800414-1-tudor.ambarus@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am Tue, Jan 11, 2022 at 10:09:33AM +0200 schrieb Tudor Ambarus:
> PMERRLOC resource size has been shrunk to 0x100, 

What do mean with "has been shrunk"? It was introduced like this for
sama5d2, sama5d3, and sama5d4 in the first place with d9c41bf30cf8c.

FWIW, I had a look in the sama5d2, sama5d3 and sama5d4 series
datasheets, and it seems sama5d2 differs from the two others here.

> which resulted in
> HSMC_ERRLOCx register being truncated to offset x = 21, causing
> error correction to fail if more than 22 bit errors where 24 or
> 32 bit error correction was supported.
> 
> Fixes: d9c41bf30cf8 ("ARM: dts: at91: Declare EBI/NAND controllers")

This landed in 4.13. Is this fix needed for stable then? That would be
4.14, 4.19, 5.4, 5.10, and 5.15, right? Or is this covered by the
fixes tag already?

Greets
Alex

> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  arch/arm/boot/dts/sama5d2.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 801969c113d6..de88eb484718 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -413,7 +413,7 @@ hsmc: hsmc@f8014000 {
>  				pmecc: ecc-engine@f8014070 {
>  					compatible = "atmel,sama5d2-pmecc";
>  					reg = <0xf8014070 0x490>,
> -					      <0xf8014500 0x100>;
> +					      <0xf8014500 0x200>;
>  				};
>  			};
>  
> -- 
> 2.25.1
> 
