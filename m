Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BB7C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Apr 2022 10:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347719AbiDBKT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240469AbiDBKT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:19:56 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58E31A9CB0
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:18:04 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 397BC1C0B79; Sat,  2 Apr 2022 12:18:02 +0200 (CEST)
Date:   Sat, 2 Apr 2022 12:18:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, michael@michaelkloos.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Work to remove kernel dependence on the
 M-extension
Message-ID: <20220402101801.GA9428@amd>
References: <CAK8P3a3mzax-OiaxBcxM_RgKNsd6N8HW0odRmw38u2jKE5aYaQ@mail.gmail.com>
 <mhng-3e1f2147-7acb-4dd7-8fce-41ec72def1d7@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <mhng-3e1f2147-7acb-4dd7-8fce-41ec72def1d7@palmer-ri-x1c9>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>That'd be wonderful, but unfortunately we're trending the other way --
> >>we're at the point where "words in the specification have meaning" is
> >>controversial, so trying to talk about which flavors of the
> >>specification are standard is just meaningless.  I obviously hope that
> >>gets sorted out, as we've clearly been pointed straight off a cliff for
> >>a while now, but LMKL isn't the place to have that discussion.  We've
> >>all seen this before, nobody needs to be convinced this leads to a mess.
> >>
> >>Until we get to the point where "I wrote 'RISC-V' on that potato I found
> >>in my couch" can be conclusively determined not compliant with the spec,
> >>it's just silly to try and talk about what is.
> >
> >I would argue that codifying the required extensions through kernel sour=
ce
>=20
> The problem here isn't the required extensions, it's that vendors can cla=
im
> to implement an extension on hardware that doesn't exhibit any of the
> behavior the specification expresses that systems with those extensions m=
ust
> have.  The D1 is a very concrete example of this.

Sounds like someone interested should make a webpage listing available
CPUs that claim RISC-V compatibility but far short of advertised
claims?

I'd like to get RISC-V board to play with sometime soon, and some help
in what board to get would be welcome...

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJIItgACgkQMOfwapXb+vIdfQCaAgXDlqG17hztlH0G92GavUtD
yZAAn13P0BpPSIS+L3ydlZhmPdM2ROWs
=9jvG
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
