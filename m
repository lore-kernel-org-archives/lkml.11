Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AA2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 May 2022 07:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389500AbiEFH1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 May 2022 03:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343821AbiEFH1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:27:10 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671716129F;
        Fri,  6 May 2022 00:23:28 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9CBFD1C0BA6; Fri,  6 May 2022 09:23:25 +0200 (CEST)
Date:   Fri, 6 May 2022 09:23:23 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Moulding <dmoulding@me.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        tglx@linutronix.de, akpm@linux-foundation.org, corbet@lwn.net
Subject: Re: [PATCH v2 0/1] Allow setting hostname before userspace starts
Message-ID: <20220506072322.GA3925@amd>
References: <20220506060310.7495-1-dmoulding@me.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20220506060310.7495-1-dmoulding@me.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi1

> Some userspace processes may rely on gethostname to always return the
> correct machine name. However, the only way that the hostname may be
> set is by some other userspace process calling sethostname
> first. During boot, if a process that depends on gethostname runs
> before sethostname has been called, then the process that called
> gethostname is going to get an incorrect result.

Don't do that, then? :-).

init gets passed command line parameters kernel did not use. So init
can do that easily. Plus, there's initrd.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJ0zOkACgkQMOfwapXb+vJ8uQCgwMYHJBnorWMQBRCR+jErs4mV
MtcAniM3xsBcVPVbA/dyttsqf0YECqOA
=SgE7
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
