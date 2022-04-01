Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED146C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 21:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352751AbiDAVRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 17:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiDAVRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:17:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C859E7A98C;
        Fri,  1 Apr 2022 14:15:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00168B82505;
        Fri,  1 Apr 2022 21:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EC3C2BBE4;
        Fri,  1 Apr 2022 21:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648847728;
        bh=TMC2lxjFF/69h0u5qOKYS/bbP77+QCpSH+WipT6atYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aXldOcwmEiQWYMEcq5ev2wNzg1h3hWsksE5NKJhhhunaPJT5MOCY2kCYWIJCx20zB
         XqJQPe7vYfY+srPArI0uQeL8UG6YUb13TBmMRubipai8+cJvBvVt+nSMfsL1Nx0Jn0
         NTAgSQ4C+MPV6bxSJ7Ecc6Rp4bR//yJGo021FATXP5YZ8JiP50CZZ+H1DlFvSz1/Nq
         KylaDGG8CKkoSm3+Q+H/qvlU4/p90PsMoiiKv7l5Cl6ouv8DVJev6g2S/47saNGV+r
         kXeNxo8o6V2iWrTBWVPvK+JH93lpehP3gmhLQ6e1bWMqMrOMfVeAz1nBk7GP6f7ILH
         +xG7Kj/WN6RFg==
Date:   Fri, 1 Apr 2022 22:15:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: qcom,smd-rpm: update maintainers (drop
 Kathiravan)
Message-ID: <Ykdra8vV6IxjUaRH@sirena.org.uk>
References: <20220401202759.191560-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N7jqBAFlRuRLdVOL"
Content-Disposition: inline
In-Reply-To: <20220401202759.191560-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Universe, n.:
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N7jqBAFlRuRLdVOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 01, 2022 at 10:27:59PM +0200, Krzysztof Kozlowski wrote:
> Kathiravan's email bounces (585: Recipient address rejected:
> undeliverable address: No such user here) so switch maintainers to Andy
> and Bjorn (as Qualcomm platform maintainers).

Acked-by: Mark Brown <broonie@kernel.org>

--N7jqBAFlRuRLdVOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJHa2oACgkQJNaLcl1U
h9B4qgf8CMZZLIY0wIj858AnHDOmx0Q0TleK9Jc52emgEcvQFHK1uMznH0azLAtY
ex4Hvf6EaAgyTksyBVH/JdEv2RLgyEUzf6mjYItFX+vJn3N9pLn02QSTyXlKPIa1
Zjmo+rL9RuMmiuBng3ARlIuFM50GmvyQb/EtkGPv1hVXWvEoaByY7xsygLu+4o/L
QX5lWzS0k7EWj6fVvjRCkQiJMNyHj3ZOSw0EECy7LW6xCF/iOTh0i+j6JHOSOJ0E
/bdTinxZydO6y6NZS3FfYwzjljs2BkVRQL/tVjaXKLVw7z+KF2Wg5zk7nwkjVSon
BCMRpnZvrjSSCt6sqK8hmoRyRYj8Xg==
=p3Q7
-----END PGP SIGNATURE-----

--N7jqBAFlRuRLdVOL--
