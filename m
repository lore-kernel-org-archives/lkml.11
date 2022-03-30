Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B9FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 12:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345598AbiC3Mo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 08:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345436AbiC3Mou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:44:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E436A18D991
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81075B81C48
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14640C340EC;
        Wed, 30 Mar 2022 12:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648643901;
        bh=Y3RTH4+66JeeV6D+T9U96LNs6SKNQndWrVCet3VBQyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lqdx9wRA4xjfwUX5EqbfqhdSJvtOjlqB9OIu11blTMtpW8OrAsU0QLNPtR/Tt3e63
         JUO7vjXEEJMNu6aRhV3EnTGWVKFb888GCqeXcN4goZW+XvfpVoAt1vimLUAEjkkqwP
         rBihsU1+nxL3ZLz2rs3vrtO6s3iuo+xrqdVy46Ao61qk+shi/m03W7hVvUXEr7WFqU
         yU6zIStGnQ/DVo/luT1AM5CezguAfixEpJGddvZyAoC3+4qP2b2CbNhqE/0YdvsZbB
         k6U+g1HW05znFWxj99Zhv7aRekSOMSrY3k5EeCZ+0u1hA5Neby9DCzVcj7mjVwCGE+
         EFBN+Yq61PDfw==
Date:   Wed, 30 Mar 2022 13:38:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: make range check functions static
Message-ID: <YkRPOM9GKo3tlxUh@sirena.org.uk>
References: <20220328225628.3012397-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wFbyvqD5vUYxBxuz"
Content-Disposition: inline
In-Reply-To: <20220328225628.3012397-1-linux@rasmusvillemoes.dk>
X-Cookie: Two is company, three is an orgy.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wFbyvqD5vUYxBxuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 29, 2022 at 12:56:28AM +0200, Rasmus Villemoes wrote:
> regmap_reg_in_ranges() and regmap_check_range_table() have no callers
> outside regmap.c, so they have no reason to be exported nor have
> external linkage.

These are intentional API in case someone needs them, no need to
encourage open coding.

--wFbyvqD5vUYxBxuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJETzcACgkQJNaLcl1U
h9BghQf6Ay12SWbWnVQYbZLmA4xsY9SPqwu6MKNKjb4+OM1+DyybRsNVE6zPVHNb
b5/kWyo6J6VJ72MTJg/iT594xoozbrzOqjjHD1EHII6Mggabe4B6Ai/5pH+EFv6e
HrXQqj1U7GrXDu8nci8UW0MGBPySRhu+joHwlR0QjpA+3eP64lLvdTZtk/FrBset
ByaJIn7zI8/I2Vok+FOLqNAxvpRvpHvNK7IN5qq0yOBktr35FH8qnhN/ke8QX0dP
g4s7Pv0X5hqhrjuMIxOqE5GncFopSb/gJ6M6fhBSz6ul/9jfoPxQsSkImfwPU+sW
nUEFIQZlEc1xOPtLrA26dsOozpYMsA==
=XW50
-----END PGP SIGNATURE-----

--wFbyvqD5vUYxBxuz--
