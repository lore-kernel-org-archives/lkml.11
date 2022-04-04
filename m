Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5E1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 12:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344804AbiDDMag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 08:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344642AbiDDMab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:30:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ADBBF5F;
        Mon,  4 Apr 2022 05:28:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0DD461049;
        Mon,  4 Apr 2022 12:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93E8C2BBE4;
        Mon,  4 Apr 2022 12:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649075314;
        bh=xs4c6MXzpV8ng4CjtZYCgJS2RsuPKpKdPUzYO+hnHgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7GBgI2GTxELAK0/ohe2a9WUz5f54xUcos+VlcjM4byBQtlHumr57JKG4pYLFXlFj
         /pmwE/Ln1e5SZNaS75jo3WCh9JJQCxn2TBxUMdzXWZeYvcTaMPyRo/zl7Lz2Lmpuut
         Ibck0ncRDCkwQvi91v8hNZAexCpRD/gu5y4fC8OQR9koOvZTIzK+em0qFgO32tMylI
         JzUuqLZoyO9Oza2r5JQOOvUc2+bB9gZ1ZCgBEc8D7mj7xur9iu0eleS0p5glEEKHO/
         M+kMMzFKaAWePT6DtzsgqM1PC0zE+Af9AEd5/U3OqjWZcNhth1oWC8/h1GFtHcktEH
         ScotCNfry7Xag==
Date:   Mon, 4 Apr 2022 13:28:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: [RFC PATCH 3/5] HACK: ASoC: Tolerate N-cpus-to-M-codecs links
Message-ID: <YkrkbBNYULLgeS5w@sirena.org.uk>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-4-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f/2nG60b2Y2bNyVh"
Content-Disposition: inline
In-Reply-To: <20220331000449.41062-4-povik+lin@cutebit.org>
X-Cookie: Did I say I was a sardine?  Or a bus???
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f/2nG60b2Y2bNyVh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2022 at 02:04:47AM +0200, Martin Povi=C5=A1er wrote:

> +#if 0
>  				dev_err(rtd->card->dev,
>  					"N cpus to M codecs link is not supported yet\n");
>  				return -EINVAL;
> +#endif
> +				cpu_dai =3D asoc_rtd_to_cpu(rtd, 0);

We need to figure out an interface for describing which CODEC/CPU
combinations are connected to each other.  I'm not seeing a great way to
do that right now, probably some side data table is going to be needed,
or perhaps the CPU DAI drivers can be persuaded to only have one DAI
actually register and claim to support more channels?  I'm not sure how
a configuraiton like this is going to work at userspace level if the
multiple CPU DAIs end up being visible...

--f/2nG60b2Y2bNyVh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJK5GsACgkQJNaLcl1U
h9Dh0gf/Q1fqGCEc/wB1XRysOW+Zr5es3K9uEZqWeoFmgY3PJHzaoQyoY8BDO6Ve
RDsWRNXnUAuatmcX1NOrm141Q5vVthZt2Y3q60kJOAtBjRg1eLsw0uILEy5Q7cb1
lj7GMjVex4PXcDIJHOb52ZeUhEx1HCpwPCW3Gtx7yU2vmpmpM/vPnugND7wgXoL0
nuD3L00ieLVGfeaBi5ZBYBBvMqO6a8Vc8D4q2zgV+1NVnexzLy8nSWqZCmyKa5SF
bf1jHHMuHJUNF6xeTjSLqzeoRH4q0TEzMMJhF4K4ACM693Dy1HBOXRPKNU33u6/8
7REwlCduNI1JEBSwNjzHv4gMWLxfNQ==
=QGn3
-----END PGP SIGNATURE-----

--f/2nG60b2Y2bNyVh--
