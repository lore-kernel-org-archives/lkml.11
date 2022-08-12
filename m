Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064FCC25B0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Aug 2022 12:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbiHLMWc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Aug 2022 08:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiHLMWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:22:31 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F102B0894;
        Fri, 12 Aug 2022 05:22:29 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8730DC0010;
        Fri, 12 Aug 2022 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1660306947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=24bKiqU55JXRuVlkYegpaqJ9og5C48IeVZvaeDQry2M=;
        b=Hv0YvjVZadPNGue6A/WQsAZQfBtEXiAYedGoDH36AbycZTxH5OSk9lJrz+Uvt9lB7o3lik
        9sJOQAsAKAScXMgOQti3u4SzvK14cOpXcc4kcYEeuP3XD2YmJGMbSX2nv0G3yi0WkznDpV
        iOJL+vI3nvGck2HkVtkVJzgeQvZsGMX+3Nj3/eSXP4bni36Dc09smaOrJX2b/2QKysJRLe
        Mkd56fjrYzCDdjs/LFm2NWGpjENLmNLCVCKpE3WRCqfQplFa8fNyOXlhxgCoTFjKMyTUcb
        5xDL/VkuoiVPwi24eEhcsogqCvsrIGs1mVzuQNEgx6hjliHgr5hE6i19jN5OfQ==
Date:   Fri, 12 Aug 2022 14:22:24 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/8] dt-bindings: sun6i-a31-mipi-dphy: Add the interrupts
 property
Message-ID: <YvZGAEM4B8SdDjwJ@aptenodytes>
References: <20220812075603.59375-1-samuel@sholland.org>
 <20220812075603.59375-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KjPeSdJ+GXZUw4K/"
Content-Disposition: inline
In-Reply-To: <20220812075603.59375-2-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KjPeSdJ+GXZUw4K/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Fri 12 Aug 22, 02:55, Samuel Holland wrote:
> The sun6i DPHY can generate several interrupts, mostly for reporting
> error conditions, but also for detecting BTA and UPLS sequences.
> Document this capability in order to accurately describe the hardware.
>=20
> The DPHY has no interrupt number provided in the vendor documentation
> because its interrupt line is shared with the DSI controller.

Interesting! I do see DPHY_INT_EN*/PD* in the Allwinner BSP's
drivers/media/video/sunxi-vfe/mipi_csi/dphy/dphy_reg_i.h

Maybe it would be useful to import the fields in the driver so that the
next person who'll try to debug DSI can use them directly?

You might also want to submit a patch as [PATCH NOT FOR MERGE] that
adds an interrupt routine and some useful debugging.

Do you think this is also available without a DSI controller?
I could just give it a try on V3/A83t here and find out :)

Cheers,

Paul

> Fixes: c25b84c00826 ("dt-bindings: display: Convert Allwinner DSI to a sc=
hema")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
>  .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml           | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mi=
pi-dphy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mi=
pi-dphy.yaml
> index 22636c9fdab8..cf49bd99b3e2 100644
> --- a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy=
=2Eyaml
> @@ -24,6 +24,9 @@ properties:
>    reg:
>      maxItems: 1
> =20
> +  interrupts:
> +    maxItems: 1
> +
>    clocks:
>      items:
>        - description: Bus Clock
> @@ -53,6 +56,7 @@ required:
>    - "#phy-cells"
>    - compatible
>    - reg
> +  - interrupts
>    - clocks
>    - clock-names
>    - resets
> --=20
> 2.35.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--KjPeSdJ+GXZUw4K/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmL2RgAACgkQ3cLmz3+f
v9EJmAf/RUjmCJrqT+VVsenrzACFjYYacE4PB9OUct0QvopV8HTeQ4cpP5PxQ7Hq
Z7EDMun2tudD2q3tgqtIMRIjtikuL/VYQuBh+rCTEdxj+BUsRVFU6bXR3/CH4gp8
dJcZuMc3pXWDq74sLz5JscdEaUAGTUJqqkl5TsSR/Kt0BVEKP7sHTg1xEVfJ0N6K
OPP5oxJYMR3WSEiPpN7Vy3jeCpijm8hJJTHrbY6un7PfddvTXiBm0AU02RJ1PD2+
nJwVDo+AO+E8WJsKoa+5BWCCPF+it7dVcyPLZszuYxYGC0B5+Yv+hjOeBw/Ouggf
vuufwYdETc2xCdlsjvAp90wcwj1F0g==
=A0Yv
-----END PGP SIGNATURE-----

--KjPeSdJ+GXZUw4K/--
