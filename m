Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC74ECAAD3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 11:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiIALcS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 07:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiIALcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:32:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3082115182;
        Thu,  1 Sep 2022 04:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52A5261DE7;
        Thu,  1 Sep 2022 11:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A10AC433D6;
        Thu,  1 Sep 2022 11:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662031931;
        bh=EsgujPsEDFpEWnoAnspdrmAPsj3OKMP5J2fqvUSUohE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AmZpZPOsQwuKrMloCYTe6CQsiMxwwzuyK72ZdAY/s9iy9Raq305Vd0DVcb28WjmsS
         TcBQMP4dax4jYbYxCeu+zEtqLwp7peOK8FVRRgEyKhKQG6wHfprXkhpFZr7fXJsVsL
         5ijOzinqIt0qfrYWZ3fvAON2wqI2C2dV98we5DG82iZteQ3ZGQRoG/XlmXe0RR/otp
         5JXXVs2GpoU6mBHBMnyRqzsEhShj6qFdMpjJJzvN5ELmd5r3aHpO2SZnnOJ/3w3YMC
         JuS3JQpBg20HfBi8p3vQa/ALhlZrr1xPSTHQBenofkHBo02g4vD+/G6tQlhNh/czGi
         e3123FvxnbXKQ==
Date:   Thu, 1 Sep 2022 12:32:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 04/13] regulator: rk808: reduce 'struct rk808' usage
Message-ID: <YxCYNbqdBB+YthaY@sirena.org.uk>
References: <20220831215437.117880-1-sebastian.reichel@collabora.com>
 <20220831215437.117880-5-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uSgKifA/gnLpK9Ba"
Content-Disposition: inline
In-Reply-To: <20220831215437.117880-5-sebastian.reichel@collabora.com>
X-Cookie: This bag is recyclable.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uSgKifA/gnLpK9Ba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 31, 2022 at 11:54:28PM +0200, Sebastian Reichel wrote:
> Reduce usage of 'struct rk808' (driver data of the parent MFD), so
> that only the chip variant field is still being accessed directly.
> This allows restructuring the MFD driver to support SPI based
> PMICs.

Acked-by: Mark Brown <broonie@kernel.org>

--uSgKifA/gnLpK9Ba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMQmDQACgkQJNaLcl1U
h9AZjAf9FHKbnro30y43M5NJYAf+6hCpaAE9y0K8KkAaiH6CBT4dx10pIFWqXiKe
rvJmow9dQhZpwVjBt5A25ERvzgQvK7HVkhsy2+RugStEpdqAv+YnRzq+0zjVWDGO
2FPxdUZt30sQsgEZQGJeL/rFmGXylC8JkmfW8dnMmc75+OPabWESgucpaQvzxPW2
YGbuEWESARTKy6Hi1rK3+IZ03U42Ry6OypGTuTLaJ9vFkyGxR6voB4WBd0WJ5sMe
dUbRJQeBKOLP9gVSo/+XjfqGWYWVKjTUB08kJn6qfLy4oqKKCuGVd8JSQHW+qqfx
pthDv0By/uhm+YobdEUHrg3vH3RJ/w==
=eGS0
-----END PGP SIGNATURE-----

--uSgKifA/gnLpK9Ba--
