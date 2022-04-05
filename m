Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560F5C43219
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 20:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiDEURK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 16:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572961AbiDERay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:30:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563392314E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:28:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12DEFB81B7F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 17:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A89C385A0;
        Tue,  5 Apr 2022 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649179731;
        bh=L8ClCNYpz04MaTli/xpItx9BnEYHOLA4v0sIEqu/EAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bY2k9fQO79NHBStJp71FuYLswa7OgZhHbdUW7I4unHsaM7ubItkEmGv6UZ0PRG2yn
         40zZju1eH7/erRO9y6Q9ONjCcXDkbyr7SOuBlodGHc3oUoyVqnWStQLjZv0TpjzGWU
         T8Vy5VyqNZMc4PMBtKsT9NHxvw8jYvS603xJ6OWVx0cWr/5QaXMUsbSiPgoUHnyWIv
         qqL6rBGhKQFF+mchiamUwtfin1E8HgI2u+whM/uhUHQPPDw/4fMgxoc/Uhc5IQyCiK
         g9uubCv4ZhMEmfUtGER5ug8ZYTaPoXrngnPzw8j2KZNn8/29oW/JIB9v+qprY0e+V8
         9YOdwRAwIaXVQ==
Date:   Tue, 5 Apr 2022 18:28:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.cirrus.com,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: wm8731: use simple i2c probe function
Message-ID: <Ykx8T4KFmEiAFyH8@sirena.org.uk>
References: <20220405123236.2099063-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Tw76BVguT/8hAA+z"
Content-Disposition: inline
In-Reply-To: <20220405123236.2099063-1-steve@sk2.org>
X-Cookie: I don't get no respect.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Tw76BVguT/8hAA+z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 05, 2022 at 02:32:36PM +0200, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.

This doesn't apply against current code, please check and resend.

--Tw76BVguT/8hAA+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJMfE4ACgkQJNaLcl1U
h9Cagwf/dFd/lprBIZy7kHMoCBkAKqQEWj5zaLFLoLdAR1N3s4F3JEp67KyokBJg
jewr8uF+n1PsUHlB0qTZEk0BnvIFCGdHbVJhW2anYpDXR4owxvuZ8U3aW0kXK064
P8lQARnT2SHKvGZuPU0hzOSaiZF2vLaQRDIHUCG746aB8Xo8A/Lff0qzdH7gJv0K
x8PXepAm5v98sccDmIlG5/VOIw85quNfKU0uA2aaejCpR7ABM2WvtuEXCSgyoMfZ
/ez/ctEdXSctPKGVPMSQIo4FyXsCuJJYjQ9Sl11RbP2VUv/9NiEL/pCg91AXRqUv
cQlLkekXrx6Rwy/DptIOQAndK8evzw==
=F8D2
-----END PGP SIGNATURE-----

--Tw76BVguT/8hAA+z--
