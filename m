Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B16C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 09:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbiFMJZ0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 05:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240828AbiFMJZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:25:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9016B1928B;
        Mon, 13 Jun 2022 02:25:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 462A5B80E4C;
        Mon, 13 Jun 2022 09:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491ECC34114;
        Mon, 13 Jun 2022 09:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655112318;
        bh=tjkcu8trWOZO4kIa+JBiZHLUffNIaI3Iun42mALU0DQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0I006+g0nqCwLd89H46pItuGCH+JRyuhl13URncqzkjwAX16tEjc7caPFFc+468E
         /sV0YbP4rhlT62H+wKjMKxtbmNhOKDLt+KKTGO7JNOPB91vU3oFVGv5LJCstGKIrb0
         FUz5Sqp14p0xgWjx9LLgYrza2IICkQJXxxB/j4EjmhUveIofQQJ9yng4Z2X1EIVzN8
         /RqujUkMX7SQf+cJXJ/iN9PDNC2L7vOPb2aXxi3p9RnlzfQ22i3kOPFdlVNvXc2b05
         jeZWHHEVoU4lbpfqehQlHYoRBuHDFhwTa8ttOKPcgcmuNEsUwIOFXFy1oHnp/oUzmc
         bd45HpXcbiocQ==
Date:   Mon, 13 Jun 2022 11:25:10 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linh Phung <linh.phung.jy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] arm64: dts: renesas: r8a779f0: Add thermal support
Message-ID: <YqcCdipmKU90Kq1c@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linh Phung <linh.phung.jy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20220525151355.24175-1-wsa+renesas@sang-engineering.com>
 <YqZDAiB/taLwmamr@shikoro>
 <CAMuHMdWO0zgmRKMpcSXSdshj6Fh8uu3Ch_FCVDEocdaVPaAUUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7anJqXgkQyGn0woo"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWO0zgmRKMpcSXSdshj6Fh8uu3Ch_FCVDEocdaVPaAUUQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7anJqXgkQyGn0woo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> No need to resend, I can fix that while applying.

Thanks!

> Unless you want to make other changes, which I believe is not the case,
> as only the DT bindings patch needed a new version?

Nope, no changes needed.


--7anJqXgkQyGn0woo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmKnAnIACgkQFA3kzBSg
KbZqGhAAo6f8qletfqeRYMsyFn1vwfM7O0KduW/FqAVO00JdqTDvSB0UtQLrajVq
J7q+IJkB6AR4gXIC6hUwVcIGdL+mvWxp6lFxusL8r3XrAjlaDwciI9g4goJQfFgi
pZppJcLgRb8c4Xi3KlhUkisnGKzgFQzvCpyGqug/uTqJwJKsweH0pxFXrv0xxmar
Niwon3+H6P6nATXUeY0I6D+SV1ztJ4dbV8ZuL6BHOzrSRJ9I2+jqvic0q12pS76I
qpuH7yTq424q8orTzA/4ohOpmUVuBhzSFDQcjoHzuOXuNriAkrPpFz5c55vUn3fH
O6ODRCRnw5pAWFblm0mh1tvLOB49sUS8gZCLnAHWFqrPfhJS+pQTc4rKvElGTDGP
JcQszcqXvg79lxOCxWx1c5iLREo5f3ofOAGQLxf/xJHDT5844n+W+fhksRcY8V33
32cUtHaoCgPsSUHyHVdEHifG36lmshf8MFylxnYrK9Dz3BtdYpiWKqOEZVrjErNu
w9xzVJ67Uhs30rqcmyoY7olXuyafwH2/WLJdqZrNBRmNijgjz4VFkbzOljPpaz/Z
TWI1dH/mH5yNf50HUtCDxQ7DBmH4jZRdZriMJ9EqORg2aJJOXYjsjyu9yLyflo3T
aKMJl3tUZAkH3AqGYsRkOKp+qOac07xH9vuORveEiGtsx2znPN0=
=biDP
-----END PGP SIGNATURE-----

--7anJqXgkQyGn0woo--
