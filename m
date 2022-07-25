Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A76C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jul 2022 11:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbiGYLqF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jul 2022 07:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiGYLqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:46:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A44FDF09
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:46:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACDC161001
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 11:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A92C341C6;
        Mon, 25 Jul 2022 11:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658749560;
        bh=JfLnKxHUib152IHy8B6iUkQ7nDyB6B5a3CTZnpDa5u8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hqFlEm72YMPG5y5UNB67neCFZncLooHcvkS5GfpSQqSDl9ABt7Qc2o36KImQisvQO
         TBvBKJO5TRizcX1p2mGEkYNa/EQbp2nl2ULUrg+eUNAxA9LhtGqKz5pufHKUL3Mbcn
         LVI5Juo1hWs5t9GM2q//6AoSwhbda/PC+xDvo+QtjguaBW/4AjtdtLblI40kS8/l4s
         nnDH+5e7WCbgKSWbIjNQP+CKV7zHvDMEyyU9g3xZlnBCaVC/YKES28yrv9Dt0BjFBK
         frq8Y2veENWwo9zvMTTzmKyMY1Z7oAS+S0AznKy3/wryvO3gcbCyy78lWbLMWQUic9
         WzBCiTXRZ8I5A==
Date:   Mon, 25 Jul 2022 12:45:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regmap: Support accelerated noinc operations
Message-ID: <Yt6CdDg5I70fMdOK@sirena.org.uk>
References: <20220725085822.2360234-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="24TZ4iZUIxm0ktD3"
Content-Disposition: inline
In-Reply-To: <20220725085822.2360234-1-linus.walleij@linaro.org>
X-Cookie: Replace with same type.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--24TZ4iZUIxm0ktD3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 25, 2022 at 10:58:21AM +0200, Linus Walleij wrote:

> +	/* Use the accelerated operation if we can */
> +	if (map->bus->reg_noinc_write) {
> +		size_t val_bytes = map->format.val_bytes;

A lot of duplicated buffer formatting in here...  that should probably
be factored out rather than copied, otherwise the noinc stuff is going
to drift out of sync.

--24TZ4iZUIxm0ktD3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLegnMACgkQJNaLcl1U
h9BAHAf9HYNwRcJeSXLyDfSiqP5EIk6dCc2ByZD7KWj3R3D5mmVvfGsQnTj4aBYG
iZGmjRnwnAgTJh2UnjN+uK5F33k+epUY1In9wXErXg8amJXxIEGFKbCRcNldHA5d
LSAS+pX1Yekk+dqwrrBd6OH0JaKMOleNfLluJJqZPj/vHdOvxQO/gN5/+/OJ+Y5L
1Hr9DyZrgFHfnaI1yjvLK4zGcjpD6LkTbYRe2qFO/xHwl0BBjCecXKXe8M2vr6IV
uLtwdCuP+XZzC1/n9GPQ+PfYvTij11SURiW/hOSLgwF31BzqdfGMvbpGszXy378A
qTnNMxCgIe52Ub+89xtJfJLqMdyIOA==
=rE2z
-----END PGP SIGNATURE-----

--24TZ4iZUIxm0ktD3--
