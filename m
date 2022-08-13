Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE432C3F6B0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Aug 2022 13:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbiHMNoB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Aug 2022 09:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239543AbiHMNn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 09:43:57 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7886DEB3;
        Sat, 13 Aug 2022 06:43:56 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9A4221C000B; Sat, 13 Aug 2022 15:43:55 +0200 (CEST)
Date:   Sat, 13 Aug 2022 15:43:52 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Amit Cohen <amcohen@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>, petrm@nvidia.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.9 05/12] mlxsw: cmd: Increase
 'config_profile.flood_mode' length
Message-ID: <20220813134352.GB24517@duo.ucw.cz>
References: <20220811161144.1543598-1-sashal@kernel.org>
 <20220811161144.1543598-5-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <20220811161144.1543598-5-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Amit Cohen <amcohen@nvidia.com>
>=20
> [ Upstream commit 89df3c6261f271c550f120b5ccf4d9c5132e870c ]
>=20
> Currently, the length of 'config_profile.flood_mode' is defined as 2
> bits, while the correct length is 3 bits.
>=20
> As preparation for unified bridge model, which will use the whole field
> length, fix it and increase the field to the correct size.

I don't think we need here as follow-up patches are not queued for at
least 4.9 and 4.19...

Best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYveqmAAKCRAw5/Bqldv6
8skWAJ4l4MBYK6Mhi8deiLhn50sKKnXxGwCfQX787nE/Th/KpUA7oDPqmnt1d0w=
=nWxu
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
