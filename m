Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FE6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 11:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbiDFLHb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 07:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239276AbiDFLGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:06:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C4752D937;
        Wed,  6 Apr 2022 00:31:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 021A461A18;
        Wed,  6 Apr 2022 07:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B518AC385A1;
        Wed,  6 Apr 2022 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649230311;
        bh=4OdkhvEEYFb30dY1CDwXCL23c70yBUDT5ZpEdJoNKVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZhfOPsFNLhy69jImyBcschJS7IO1/eOfkF1xYvu9yRu0Y7clNBS5VB9hzspDkNihR
         /fcnBEdlYrFaoS2wWns52cMYmghCllZRsoxAY6qladsKj39FkC4rTNmAaweFKvgLuA
         5AiBaSJNKijwuYu6dnTEoN/KPCmKytlpvb7iV1bpAFfwoTR9HqgV9ASsf2TkhfqE7V
         CkU54ItFYpUm2fQSyQLqPgqxki5E6Os4S8Hnrh8bJi2FLe4f8IZEGh06EXnEZVbkUl
         je11BorseLOpZy0ftQOQ6q+OiwT7NN3vX+TMPtR6A3LWOEedtLl+Ka2Y6xOD/15u5R
         xpPfDgZH/Yk3w==
Date:   Wed, 6 Apr 2022 08:31:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Subject: Re: [PATCH V9 4/6] regulator: Add a regulator driver for the PM8008
 PMIC
Message-ID: <Yk1B4f51WMGIV9WB@sirena.org.uk>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649166633-25872-5-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n53G-atsuwqcgNvi3nvWyiO3P=pSj5zDUMYj0ELVYJE54Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1fZokU+A3IfX11ol"
Content-Disposition: inline
In-Reply-To: <CAE-0n53G-atsuwqcgNvi3nvWyiO3P=pSj5zDUMYj0ELVYJE54Q@mail.gmail.com>
X-Cookie: Look ere ye leap.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1fZokU+A3IfX11ol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 05, 2022 at 02:09:06PM -0500, Stephen Boyd wrote:
> Quoting Satya Priya (2022-04-05 06:50:31)

> > +static struct platform_driver pm8008_regulator_driver = {

> Why isn't this an i2c driver?

It's a MFD function driver isn't it?

--1fZokU+A3IfX11ol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJNQeAACgkQJNaLcl1U
h9BClwf/XphXahPP1Q0dwmBa+CnIimd5+5lPK3IhcShBpdms/RROT2WjAbidbdCL
ANL3Nd3XHFXASyUR0XuvLIJKJ4irtc9a4iLEeLh31Ti4RjVnxJ9Sm5OSwiw51MxK
iLep/0tmten8qmPJPuvXaIpNwuaw9HHkLSY88CtbUr+esu2arIuedmbqje9o10Sl
R2+3yvB2yQe6f41og79A65KmNV2ZwhYC9aefKzdkg9amNcTcZPeA4+8uYugPBv5J
VhTJ8XIcc0ty9CS/vGEPIPf2j+ecPltJghK4CEhfHHCGhos9pjsYkEwrxIWSwzgu
8jXlSjZzWUk+Hos9FgKfDK+ww8foWQ==
=PS01
-----END PGP SIGNATURE-----

--1fZokU+A3IfX11ol--
