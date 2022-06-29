Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920EFC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 13:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiF2NKi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 09:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbiF2NKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:10:33 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807FB11C11;
        Wed, 29 Jun 2022 06:10:31 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 316B81C0B8F; Wed, 29 Jun 2022 15:10:30 +0200 (CEST)
Date:   Wed, 29 Jun 2022 15:10:29 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>,
        Melissa Wen <mwen@igalia.com>, emma@anholt.net,
        mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 4.19 04/22] drm/vc4: crtc: Use an union to store
 the page flip callback
Message-ID: <20220629131029.GF13395@duo.ucw.cz>
References: <20220628022518.596687-1-sashal@kernel.org>
 <20220628022518.596687-4-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aPdhxNJGSeOG9wFI"
Content-Disposition: inline
In-Reply-To: <20220628022518.596687-4-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Maxime Ripard <maxime@cerno.tech>
>=20
> [ Upstream commit 2523e9dcc3be91bf9fdc0d1e542557ca00bbef42 ]
>=20
> We'll need to extend the vc4_async_flip_state structure to rely on
> another callback implementation, so let's move the current one into a
> union.

This and [04/22] drm/vc4: crtc: Use an union to store the page flip
callback is queued for 4.9 / 4.19, preparing for change that is not
queued into 4.19.

Please drop at least from 4.9 and 4.19.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYrxPRQAKCRAw5/Bqldv6
8vunAJ9lfwO+e+BGTRNn3nLenP8oCx3WkACeKN+qG6clKzbdd92Cy422TOmsId8=
=f3LC
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--
