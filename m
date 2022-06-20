Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EEBC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 15:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243012AbiFTPuD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 11:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238602AbiFTPuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:50:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8131C113
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:49:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6640C61469
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 15:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324BCC3411C;
        Mon, 20 Jun 2022 15:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655740197;
        bh=ScQO52XUBOQxGDnyStv59qDVIShGEP2F1oS2qcNkiOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YcDMSZZfwnE58yJ4HvHu51s5En0GdAGpaZPthuZVUmwn1DeJ85TczhI5IZwtGz/Kr
         sMGsasSfbXwNEeHmxkRQL/W/XaqVmTuO5JhURYtiAGr0Un/AMAFlms5sdodExrHy78
         SdlKhv4gUvBrYbJbMv/0PEOfLP4U7BKjgjkavJ5Km29X2KiHvtRY8MhQiU2GlrcQGm
         NSu/GDfob37bROrfUD/kPhOdTccMfvVQUF+XP1ZwciADXw5eguhE/zj7fDGM6MlfsH
         mNfeTl97LSkm9NEVmYU3rvom1UgaHBC7zlxKZgHyAORWUzR30RM4ywKwa3o4IBnFTq
         uGZdNYVnBdwWw==
Date:   Mon, 20 Jun 2022 16:49:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH RFC 1/2] regmap: add option to disable debugfs
Message-ID: <YrCXILblKsp6DuN3@sirena.org.uk>
References: <20220620134758.1286480-1-aisheng.dong@nxp.com>
 <20220620134758.1286480-2-aisheng.dong@nxp.com>
 <YrCM0reni+x/KWsG@sirena.org.uk>
 <DB9PR04MB84779EF2842D789FA66094C380B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eNLQXB9KPdWSaaD/"
Content-Disposition: inline
In-Reply-To: <DB9PR04MB84779EF2842D789FA66094C380B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
X-Cookie: Good day to avoid cops.  Crawl to work.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eNLQXB9KPdWSaaD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 20, 2022 at 03:47:05PM +0000, Aisheng Dong wrote:

> > As indicated in the message you're linking to here if the device can't be
> > accessed it should be being put in cache only mode which will ensure that
> > nothing can do any physical accesses.

> I wonder that's not a stable solution assuming there're possible volatile registers.
> Isn't that?

The driver is going to need to power the device back up to access the
volatile registers so it can take the device out of cache only mode when
it's doing that can't it?

--eNLQXB9KPdWSaaD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKwlyAACgkQJNaLcl1U
h9D2ywf7BsrnvF2SNw2odQH/Levag9MGwUTF2w0j9u2BbH106w4q53BTcosyERm2
JS0MNh7ENg4Q6BxMmSL6rDw97cSGOeJtgFF377flnO8SVhv3dcSnnuy6Hr0fjMqX
rwvNoX8VepfsLqQHgXRUGsatjERMOBsAOP8jbi06tDS3pO83pr5ZY2gy08NmMNYv
nXPETmZ4nwu7+btwH1fuC//756NpvxP37iCrthgi+6KCEAZbyRedLQ2rv/mv03ES
kk4MqrdfoRfSa6201hhbZnw2yKCzwq0hzmUTTdkHVxYy9puU9CVdsW6TAMbaDYZF
NXUspjYVRlUHD80Yx8AveNVeJUMECQ==
=ZcW4
-----END PGP SIGNATURE-----

--eNLQXB9KPdWSaaD/--
