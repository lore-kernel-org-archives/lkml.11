Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FB8C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 20:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350791AbiEDUjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 16:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378215AbiEDUiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:38:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4967910AE;
        Wed,  4 May 2022 13:35:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D5A3617C2;
        Wed,  4 May 2022 20:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01837C385A4;
        Wed,  4 May 2022 20:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651696516;
        bh=bJRyH7ULrk10ZA3h6kGwKy07DPEceBSb2lm+GNXVszA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EqVDqgAVsZUswaGXGLhqGJIWvFMh2yJJ9EMg+Cd6PW2dCD/GtIMx61KB+kOCAsBCv
         s+CDZ4aIB+DJlVtY7pRjhueN8ghQ0OklQYyHo1ZSFpWwrmgNKhXkgbbxPu0zetO8dX
         etQBQunI7+k/PfJWsc69MJyZKgKjQeOZWSHzSgj8ODX3faMQ5+2BBewZbjoNUW4ZZe
         0oCAceloRzKC0xY55uzsc0QBg5qZxZ1NRBikcgXgm4ze3wi+nqqH5/lXKctxkfBKTD
         a6tycxfgTWYGu9d+DauGFsovbChOWX1+jgLF666XqjWlAuYj5bup4eUIvvG879+Fj5
         wDf3Uwo5Fl0KQ==
Date:   Wed, 4 May 2022 21:35:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH 0/6] regulator: core: Add support for external outputs
Message-ID: <YnLjf6H4xJBCPwe7@sirena.org.uk>
References: <20220504065041.6718-1-zev@bewilderbeest.net>
 <YnJ37QysSaa+gAps@sirena.org.uk>
 <YnLh23QbnO1MHoVL@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XYm94gjSzzGQjMIN"
Content-Disposition: inline
In-Reply-To: <YnLh23QbnO1MHoVL@hatter.bewilderbeest.net>
X-Cookie: Mother is the invention of necessity.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XYm94gjSzzGQjMIN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 04, 2022 at 01:28:11PM -0700, Zev Weiss wrote:

> To some extent that was an additional (maybe excessive) protective measure
> against regulators ending up userspace-controllable when they shouldn't be,
> since I had previously gotten the impression that there was some concern
> about that possibility.

The problem there is that userspace shouldn't be controlling the
regulator, it should be controlling the things using the regulator so
that whatever happens is coordinated with the rest of the management of
the device.

--XYm94gjSzzGQjMIN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJy434ACgkQJNaLcl1U
h9B+0wf+MttKvXRTWyy3xdto1WZ8sMfsgppWpCGoAtjEOxvGLCL0xnKZr2SBfuCW
otMNp+5vMZHRUHpZ5QrA4BPc6JAulfRNzMbYZni1P4ZjXx+40BG4+JnfXlro/S13
kQFAjFNCj0MVg8/0LM7yH4j30LR3MjQsWWM8I8Y9rWzhGccQP8oMQA2wB3Qjaivl
BoLQaeWtp+QgPPnSXZAc8vE+15sDeIekEW+jBlOKGXsurcvt3kl6zP5iyBKQmClz
GmlHtASv08JdX31IvTIYhasfWUMFdUTn8EFoOOViJ5grd28F60JPrlk/pDIFClof
22AepX2debpd1tfqc9xn8Vajk87XRg==
=P2u8
-----END PGP SIGNATURE-----

--XYm94gjSzzGQjMIN--
