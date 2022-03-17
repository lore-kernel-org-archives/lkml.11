Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03367C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 21:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiCQVUn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 17:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiCQVUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:20:41 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4351CB245D;
        Thu, 17 Mar 2022 14:19:24 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0A5591C0B7F; Thu, 17 Mar 2022 22:19:23 +0100 (CET)
Date:   Thu, 17 Mar 2022 22:19:22 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.10 00/23] 5.10.107-rc1 review
Message-ID: <20220317211922.GB5328@duo.ucw.cz>
References: <20220317124525.955110315@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <20220317124525.955110315@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.107 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.


> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     bnx2: Fix an error message

As commented during the AUTOSEL phase, this patch actually _adds_ an
error in at least 5.10 and older. Please drop.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYjOl2gAKCRAw5/Bqldv6
8lmVAKCPUPIcPtLmz1hK4C6zFnR705kpoACff96/m5gIzEso+IFRjiK5YedDn+w=
=2N4T
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
