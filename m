Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D03C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 23:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiDLX1V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 19:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiDLX00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:26:26 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217155E16F;
        Tue, 12 Apr 2022 15:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1649803132; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xNAG0SZZHvrLl10xQGGWue13a4HRKmHPzD7hJXX4nXw=;
        b=JrCsWn2rWIljaUBYBbe4lfE1WQfRTPty5lP17RS5P46896a7F0Klgi9OrmOXuP9gLhIkNH
        SG1EzrVTvrFCtbI+6rPgdFfNjm3BNfEQ+cz4GyEfA1e0Fs3s8MWOnmdedVoks84rkkFpKu
        qVg9d2d/TTBZq+Y0afxP2tEHOqRfv08=
Date:   Tue, 12 Apr 2022 23:38:42 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v5 1/2] mips: dts: ingenic: Add TCU clock to x1000/x1830
 tcu device node
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, tsbogend@alpha.franken.de,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dan.carpenter@oracle.com
Message-Id: <I809AR.0C3UZTFR7V5I1@crapouillou.net>
In-Reply-To: <20220412122750.279058-2-aidanmacdonald.0x0@gmail.com>
References: <20220412122750.279058-1-aidanmacdonald.0x0@gmail.com>
        <20220412122750.279058-2-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mar., avril 12 2022 at 13:27:49 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> This clock is a gate for the TCU hardware block on these SoCs, but
> it wasn't included in the device tree since the ingenic-tcu driver
> erroneously did not request it.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  arch/mips/boot/dts/ingenic/x1000.dtsi | 5 +++--
>  arch/mips/boot/dts/ingenic/x1830.dtsi | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi=20
> b/arch/mips/boot/dts/ingenic/x1000.dtsi
> index 8bd27edef216..c69df8eb158e 100644
> --- a/arch/mips/boot/dts/ingenic/x1000.dtsi
> +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
> @@ -111,8 +111,9 @@ tcu: timer@10002000 {
>=20
>  		clocks =3D <&cgu X1000_CLK_RTCLK>,
>  			 <&cgu X1000_CLK_EXCLK>,
> -			 <&cgu X1000_CLK_PCLK>;
> -		clock-names =3D "rtc", "ext", "pclk";
> +			 <&cgu X1000_CLK_PCLK>,
> +			 <&cgu X1000_CLK_TCU>;
> +		clock-names =3D "rtc", "ext", "pclk", "tcu";
>=20
>  		interrupt-controller;
>  		#interrupt-cells =3D <1>;
> diff --git a/arch/mips/boot/dts/ingenic/x1830.dtsi=20
> b/arch/mips/boot/dts/ingenic/x1830.dtsi
> index 2595df8671c7..4408df24ca98 100644
> --- a/arch/mips/boot/dts/ingenic/x1830.dtsi
> +++ b/arch/mips/boot/dts/ingenic/x1830.dtsi
> @@ -104,8 +104,9 @@ tcu: timer@10002000 {
>=20
>  		clocks =3D <&cgu X1830_CLK_RTCLK>,
>  			 <&cgu X1830_CLK_EXCLK>,
> -			 <&cgu X1830_CLK_PCLK>;
> -		clock-names =3D "rtc", "ext", "pclk";
> +			 <&cgu X1830_CLK_PCLK>,
> +			 <&cgu X1830_CLK_TCU>;
> +		clock-names =3D "rtc", "ext", "pclk", "tcu";
>=20
>  		interrupt-controller;
>  		#interrupt-cells =3D <1>;
> --
> 2.35.1
>=20


