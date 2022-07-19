Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2002BC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 14:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239264AbiGSOgJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239107AbiGSOfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:35:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43B520BF3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:27:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64C64617B7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 14:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE830C341C6;
        Tue, 19 Jul 2022 14:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658240858;
        bh=AVkZTiT9+fU/TFkJXwl5QTgcDHrF4cT7PhUF4vEJG7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CE0unikg5Ie3jp7QsZV8835w7IZe2KsQ1IA+/ENzyjOFUqkXBAhPqmehQWamSJeVx
         lW3NC7nPHFEqE6e+NAbGIgEJ69p1gvvdLJ3ShjSI50isC0i+CmfnGUXGuXs9D7c71I
         ZpSEELyBDXLoicFJtWtAln01fvUlHsyJBc2dRGKf+y5lPxILmv2tf0s1RigSLopK9G
         mIqjJVOt5Phf/6o6l/3isSZ7Xc8G+wOGL9OpbvwbwRvL/COg4Z9CeA2mHfu1UMQDlB
         QMSyaZCZaKpLd+v8r9XAxK5YT6yBqrFc2mrzGG/o8yxndnyiWAgX3Rhp9IKvHZVWOE
         ae02R+RUX3DRw==
Date:   Tue, 19 Jul 2022 15:27:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christian =?iso-8859-1?Q?Kohlsch=FCtter?= 
        <christian@kohlschutter.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH REBASE] regulator: core: Fix off-on-delay-us for
 always-on/boot-on regulators
Message-ID: <Yta/Vt67rzNArMNx@sirena.org.uk>
References: <E25D6465-6475-42B4-90EB-3D2C3CAF3B20@kohlschuetter.com>
 <YtVTyzLREdkzYiKS@sirena.org.uk>
 <3270C618-E361-4BC1-B63A-917AE09DA60E@kohlschuetter.com>
 <FAFD5B39-E9C4-47C7-ACF1-2A04CD59758D@kohlschutter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="49V6zXQGis4B4StV"
Content-Disposition: inline
In-Reply-To: <FAFD5B39-E9C4-47C7-ACF1-2A04CD59758D@kohlschutter.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--49V6zXQGis4B4StV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2022 at 04:02:00PM +0200, Christian Kohlsch=FCtter wrote:
> Regulators marked with "regulator-always-on" or "regulator-boot-on"
> as well as an "off-on-delay-us", may run into cycling issues that are
> hard to detect.

This doesn't apply against current code, please check and resend...

--49V6zXQGis4B4StV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLWv1UACgkQJNaLcl1U
h9Dnwgf/c5fDYegRmIJEgi6nC4KoR+OJZhmzyddTV1LXiD7/EVa+jXRXnKdgC+Bz
KdMQLsmYdMTolYk3CWBlaAhM6KfpGkkwpycdUBLJoRlTqSJUF5umSuWARIUTgbzd
FuhfOTdiPsdvX/kr+wuLtDEoXhHvxnP41e3VSReuQSwGcVuh6+v90GCO10SrHt96
Hp7aEqSh2KyaaZNZLd9ip2j/7fBEMY3ifA64oDD6pnQvtKEQ6qUyu0koMuFlgV5D
VCmEOKp12iyJ7i0j4nZiX6ygW+z+mQ+2R7sFs5i9gFAvsfDkHbQZP+x5KGuEM66w
HLXcftozUuMzBuM0wO39xVfZFtWNlw==
=4CDG
-----END PGP SIGNATURE-----

--49V6zXQGis4B4StV--
