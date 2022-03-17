Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3204EC433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 10:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiCQKG2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiCQKG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:06:26 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7CBC12CE;
        Thu, 17 Mar 2022 03:05:10 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2064C1C0B7F; Thu, 17 Mar 2022 11:05:09 +0100 (CET)
Date:   Thu, 17 Mar 2022 11:05:08 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     James Morse <james.morse@arm.com>, stable@vger.kernel.org,
        pavel@denx.de, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [stable:PATCH v5.10.105] arm64: kvm: Fix copy-and-paste error in
 bhb templates for v5.10 stable
Message-ID: <20220317100508.GA2150@amd>
References: <20220315135720.1302143-1-james.morse@arm.com>
 <YjMHefyJIHBj5tak@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <YjMHefyJIHBj5tak@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > KVM's infrastructure for spectre mitigations in the vectors in v5.10 and
> > earlier is different, it uses templates which are used to build a set of
> > vectors at runtime.
> >=20
> > There are two copy-and-paste errors in the templates: __spectre_bhb_loo=
p_k24
> > should loop 24 times and __spectre_bhb_loop_k32 32.
> >=20
> > Fix these.

> > @@ -68,7 +68,7 @@ SYM_DATA_START(__spectre_bhb_loop_k24)
> >  	esb
> >  	sub	sp, sp, #(8 * 2)
> >  	stp	x0, x1, [sp, #(8 * 0)]
> > -	mov	x0, #8
> > +	mov	x0, #24
> >  2:	b	. + 4
> >  	subs	x0, x0, #1
> >  	b.ne	2b
>=20
> Thanks, now queued up!

Thank you.

Reviewed-by: Pavel Machek <pavel@denx.de>
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmIzB9QACgkQMOfwapXb+vLMFgCfXOysq/wLsP/H+MYCuf8HQXOQ
51IAoIWhU78OMj0/f5j5uRpOomcosK7r
=zChd
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
