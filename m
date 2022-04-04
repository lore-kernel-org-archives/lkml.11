Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECE1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 10:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355922AbiDDKJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 06:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355711AbiDDKJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:09:31 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EB33C4A8;
        Mon,  4 Apr 2022 03:07:34 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BAE8B1C0B66; Mon,  4 Apr 2022 12:07:32 +0200 (CEST)
Date:   Mon, 4 Apr 2022 12:07:32 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, reiserfs-devel@vger.kernel.org
Subject: Re: Is it time to remove reiserfs?
Message-ID: <20220404100732.GB1476@duo.ucw.cz>
References: <YhIwUEpymVzmytdp@casper.infradead.org>
 <20220222100408.cyrdjsv5eun5pzij@quack3.lan>
 <20220402105454.GA16346@amd>
 <20220404085535.g2qr4s7itfunlrqb@quack3.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <20220404085535.g2qr4s7itfunlrqb@quack3.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> > > So from my distro experience installed userbase of reiserfs is pretty=
 small
> > > and shrinking. We still do build reiserfs in openSUSE / SLES kernels =
but
> > > for enterprise offerings it is unsupported (for like 3-4 years) and t=
he module
> > > is not in the default kernel rpm anymore.
> >=20
> > I believe I've seen reiserfs in recent Arch Linux ARM installation on
> > PinePhone. I don't really think you can remove a feature people are
> > using.
>=20
> Well, if someone uses Reiserfs they better either migrate to some other
> filesystem or start maintaining it. It is as simple as that because
> currently there's nobody willing to invest resources in it for quite a few
> years and so it is just a question of time before it starts eating people=
's
> data (probably it already does in some cornercases, as an example there a=
re
> quite some syzbot reports for it)...

Yes people should migrate away from Reiserfs. I guess someone should
break the news to Arch Linux ARM people.

But I believe userbase is bigger than you think and it will not be
possible to remove reiserfs anytime soon.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYkrDZAAKCRAw5/Bqldv6
8h5BAJ9LCQu75zH25BBIcCpReneBEG+CVgCeJzTQvmwpm/NARX/qKRapjtlH7CI=
=epY+
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
