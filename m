Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF87C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 09:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244842AbiC3JgY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 05:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239324AbiC3JgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:36:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FDA338BC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:34:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83AF3B81BBC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAC9C340EE;
        Wed, 30 Mar 2022 09:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648632874;
        bh=ahgQMII3Y3gsHu5A6RtL4UhmKKuICWYCV3wxzz3fLkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XlDuc0enEVr2JaMjClA/IWKYcuVF4oJKAze7H2milB5k7PTt2kSc5fO6s7smHmKbY
         QkaU1s+oFiqhyN0JgBvzIkM5FciNW2mi8qDhwy02jnclJ8uGCWrCVOQVa0qr0NPOYT
         gFM4Fa7XvyyrQ/tqmRKjwlDoWyY0e/kvwliNm9PfBBeaKCNxx2ofzu1710bUKJQ510
         nTyaslCBJgCpu5v3ozP95SfBaCzW0IuAxc/KPP1QfWyqua2ZUDBISZxLu80zj0w7Tc
         sKrnyKvhzt1+wKJ4egQI2wpBfGqNxcLExZ2CJ9uWYDlQCDFvmDKuOmHpDGNjiXHsmZ
         GzxcF4fazmuXg==
Date:   Wed, 30 Mar 2022 11:34:30 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Stephen Kitt <steve@sk2.org>, Liam Girdwood <lgirdwood@gmail.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: wm*: use simple i2c probe function
Message-ID: <YkQkJkvISwLQG1Ii@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Mark Brown <broonie@kernel.org>, Stephen Kitt <steve@sk2.org>,
        Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
References: <20220325162439.1203870-1-steve@sk2.org>
 <Yj34gLRxhmXD1Y5B@sirena.org.uk>
 <20220325182616.6fb6e13e@heffalump.sk2.org>
 <Yj3+ILE03nOxbpsT@sirena.org.uk>
 <20220325185134.1096bcc6@heffalump.sk2.org>
 <Yj4CRpNDiOr6PNbP@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="virSx/qdRYSMVzCy"
Content-Disposition: inline
In-Reply-To: <Yj4CRpNDiOr6PNbP@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--virSx/qdRYSMVzCy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Apologies, please ignore all my patches then, I=E2=80=99ll re-submit th=
em at a more
> > convenient time.
>=20
> There's no harm in them if nobody else is doing anything at the same
> time, it's just that a mechanical cleanup like this is going to get
> dropped in favour of essentially anything else if it causes conflicts.

Sending right after and based on -rc1 is usually a good timing for such
cleanups. BTW do you plan to convert the whole tree or just bits you are
interested in? Would be good to know to avoid someone else working on
the same topic.


--virSx/qdRYSMVzCy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJEJCYACgkQFA3kzBSg
KbbViA//dzhbXAydfDeTOaext7ehHCYImoYdxGOFxE3JnOR7Mf1nwCzlUPeFr3kP
A7rz6ZgAZLOlAsVmEVi9LVqdRDwJy5/notSNVIcXCIrpjB9uC4nv2aKtbrAWU0eT
DYctVQbZBPZDe50Os0HhTu3I716RYqeosFixeBe399D4GCXJ6DmU5GrN3O5Oamf4
DZDuqF4ax80g4av9xxgPEpBMWA+B//LPiMrRvvQqEOHW6DmRL0liEayXNMuHmbvO
Pp6NX0lVeKEb3I3RfVvvLawSkA2cckLN9o13bFr6nKNMOq5gveKW03f9TSjZksQP
ezMztbJsWe6mxsHHgvRSZy2g4Q7+Ia0+lS6yIKfH9x6VkQ/4gJRJddL5UGIrG7GQ
XkjwASedtq0WZhU0w9I9wiGepDqAdkncg5zwLf0dhPLKxPYuD/GPkTuOnHdCqOu3
VRaLPKbS9uUfO19aAPascb4EkeOFUqYqT9m3Y3Ne6iQ9aVeCYXJrg+0cFO4w17DZ
Gbb1G9xr46BwRWSPlTGBabax1WqxvGLU2CjveiG79zGZ3KMTcnxha+B1NCfNJCFT
wyiuq5N5rfYaeHSZ1UQ9Suig4Ayg7fiwOiHXXyMfe2K+BMGVC5A2MgQmcJlE7myy
VlBtCvLplVRei/T8v6UdT/obUYC4DCLQDgw9/mXF8YYhybUthT0=
=NUFs
-----END PGP SIGNATURE-----

--virSx/qdRYSMVzCy--
