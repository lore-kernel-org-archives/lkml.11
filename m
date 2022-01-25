Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD8CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jan 2022 19:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiAYTZy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jan 2022 14:25:54 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:50786 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiAYTZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:25:28 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5E67B1C0B88; Tue, 25 Jan 2022 20:25:27 +0100 (CET)
Date:   Tue, 25 Jan 2022 20:25:26 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 147/239] HID: quirks: Allow inverting the absolute
 X/Y values
Message-ID: <20220125192526.GC5395@duo.ucw.cz>
References: <20220124183943.102762895@linuxfoundation.org>
 <20220124183947.769204985@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
In-Reply-To: <20220124183947.769204985@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit fd8d135b2c5e88662f2729e034913f183455a667 ]
>=20
> Add a HID_QUIRK_X_INVERT/HID_QUIRK_Y_INVERT quirk that can be used
> to invert the X/Y values.

AFAICT this simply adds unused code to at least 4.19 and 5.10 stable
releases.

Best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYfBOpgAKCRAw5/Bqldv6
8h6yAKCYfLDpMu7RiRKzH5WUdXp79msoVwCffDDrWTo6aGsgU1e0orR/S4hr0pA=
=rRHm
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
