Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC6EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 19:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiCYTtm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiCYTsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:48:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CA0346312
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:32:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3ED4B82986
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 17:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B1FC2BBE4;
        Fri, 25 Mar 2022 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648229925;
        bh=lMfQQHJSljYuxE4cWyvnLSyQhpQFvvqxez6l2UoiILc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LXO0kbAi9YV0i4KAHnZSQ7PNdc/hFlr6ecAW50bDzvLTp4pfEvs6Mv9L5tSH+Otc6
         5hHsz13jPz8Sinm43M9fExV0hgRp/6AV6RK5ZqWq394b87prWblcL1uv3fxWCKWG4I
         nKknMmtQUIA0mUZvhts44bXLis/qOMJo4zDEs91k/aFyRGVsokDf/dBe848VXbYNId
         +vR0o7K1XmwmudV8qJjWSCOPhBVVPBi1KhDP0rR7dsQ0wxHEtx3n9yGe4w+d49td56
         TpILt7vyYh3ZiBJHcn4rmMaxYy/bCPyZS4XW8c3Ul1/6KqVh/42F/ObqVWrEqegWwE
         S7t9QujovoEgg==
Date:   Fri, 25 Mar 2022 17:38:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.cirrus.com,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: wm*: use simple i2c probe function
Message-ID: <Yj3+ILE03nOxbpsT@sirena.org.uk>
References: <20220325162439.1203870-1-steve@sk2.org>
 <Yj34gLRxhmXD1Y5B@sirena.org.uk>
 <20220325182616.6fb6e13e@heffalump.sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HVd1G76h0EUh0VTO"
Content-Disposition: inline
In-Reply-To: <20220325182616.6fb6e13e@heffalump.sk2.org>
X-Cookie: Man and wife make one fool.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HVd1G76h0EUh0VTO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2022 at 06:26:16PM +0100, Stephen Kitt wrote:

> Which tree should I check for conflicts? I=E2=80=99ve got similar patches=
 across all
> the i2c-using sound/soc/codecs files, I wouldn=E2=80=99t want to waste an=
yone=E2=80=99s time
> if I can check beforehand...

Since we're in the merge window non-fixes patches just aren't getting
applied at the minute, you need to follow what's going on on the list at
the minute.

--HVd1G76h0EUh0VTO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI9/iAACgkQJNaLcl1U
h9CWlAf/eK/4nW5raHE7nirfRcMMlfZgjUgl5RY5AEn9SEkrI7CecFVA6z5CNVPq
D1Y2DyszCVBkyNf92p0gM4KRCj7gwIyF6A+FqIZbAreCd8jzmBb1781QOSAB/lu8
kmKjvgcpkSASd7oRF2RSvuzhLQ9ccju7MHUfJu6AgrhJa4zYuK/vX4z5d7Xi1Fny
xUkP2WeRy3nkvRHw1PI/h4707OVJMhHX9opnWza4RUsiv0ymDQ3bOCf7qoeeET7W
/sU6wOx1aUfI6/w7f+qcQkCYVkd+J+JM28+mx3Vd8eFhI2AczeS2rkGG80tp3el9
zT7a9rQ2P8RYQ/UbBbCJn0uO+xof7Q==
=N3wA
-----END PGP SIGNATURE-----

--HVd1G76h0EUh0VTO--
