Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85604C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 08:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiFWIgU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 04:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiFWIgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:36:17 -0400
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAFC48E4B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:36:12 -0700 (PDT)
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 6B662C360E02;
        Thu, 23 Jun 2022 10:36:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 6B662C360E02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1655973368; bh=JA/Ldwik/kT6VkBu6uJTHdocpQKhnWGZxvKjF/u0rqk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KZc93t4wj73mj3AOC53ApRpIGT3/1+iXzU2y1aSkkG6gabPrEPllBIc1X8NRNVtA1
         DS4TxzG0Gy1Cw+BpNPF4MtnmqHcBUxHoRJrLqgB+QBBEXsw4sskmedKnweqM9s8Qx2
         +9c3tQVedqHRUDwY/0HpbanEKLhRhemv3fR/8MaQ=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: cns3xxx: Fix refcount leak in cns3xxx_init
References: <20220605075841.19929-1-linmq006@gmail.com>
Sender: khalasa@piap.pl
Date:   Thu, 23 Jun 2022 10:36:07 +0200
In-Reply-To: <20220605075841.19929-1-linmq006@gmail.com> (Miaoqian Lin's
        message of "Sun, 5 Jun 2022 11:58:41 +0400")
Message-ID: <m3wnd76ako.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaoqian Lin <linmq006@gmail.com> writes:

> of_find_compatible_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: 415f59142d9d ("ARM: cns3xxx: initial DT support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Acked-by: Krzysztof Halasa <khalasa@piap.pl>

Arnd, I guess you are in the best position to pick this patch up?
Thanks to both of you.

> ---
>  arch/arm/mach-cns3xxx/core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
> index e4f4b20b83a2..3fc4ec830e3a 100644
> --- a/arch/arm/mach-cns3xxx/core.c
> +++ b/arch/arm/mach-cns3xxx/core.c
> @@ -372,6 +372,7 @@ static void __init cns3xxx_init(void)
>  		/* De-Asscer SATA Reset */
>  		cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SATA));
>  	}
> +	of_node_put(dn);
>=20=20
>  	dn =3D of_find_compatible_node(NULL, NULL, "cavium,cns3420-sdhci");
>  	if (of_device_is_available(dn)) {
> @@ -385,6 +386,7 @@ static void __init cns3xxx_init(void)
>  		cns3xxx_pwr_clk_en(CNS3XXX_PWR_CLK_EN(SDIO));
>  		cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SDIO));
>  	}
> +	of_node_put(dn);
>=20=20
>  	pm_power_off =3D cns3xxx_power_off;

--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
