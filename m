Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A42C00140
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Aug 2022 12:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbiHBMOy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbiHBMOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:14:32 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D9A51410;
        Tue,  2 Aug 2022 05:13:55 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A0F8E1C0004; Tue,  2 Aug 2022 14:13:48 +0200 (CEST)
Date:   Tue, 2 Aug 2022 14:13:48 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Tianchen Ding <dtcccc@linux.alibaba.com>
Subject: Re: [PATCH 5.10 63/65] bpf: Consolidate shared test timing code
Message-ID: <20220802121348.GA23779@duo.ucw.cz>
References: <20220801114133.641770326@linuxfoundation.org>
 <20220801114136.261188102@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20220801114136.261188102@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Tianchen Ding <dtcccc@linux.alibaba.com>
>=20
> From: Lorenz Bauer <lmb@cloudflare.com>
>=20
> commit 607b9cc92bd7208338d714a22b8082fe83bcb177 upstream.

Patches 63 to 65 have double "From" and thus mismatching sign-off.

Best regards,
                                                        Pavel

> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Link: https://lore.kernel.org/bpf/20210303101816.36774-2-lmb@cloudflare.c=
om
> [dtcccc: fix conflicts in bpf_test_run()]
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYukU/AAKCRAw5/Bqldv6
8uJVAJ9m0WkbFId9ad+wrSlUYGF8297hvwCdF3Tz9D9S5Qlin2LwZsKnLq5tZUc=
=d2ud
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
