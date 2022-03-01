Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D388C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 13:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbiCAN3L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 08:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbiCAN3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:29:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7488F8A6C2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:28:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3332FB818F7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 13:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5384C340EE;
        Tue,  1 Mar 2022 13:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646141305;
        bh=BTT0XbgCMW/Y/EC0V0fvpkq3sfhwmki/mQaIJqJBGbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gbpcdKoHPsK+hV6dgNtnijrTO0eIyDNHaCNSDz5N/sVrddqaIT/iIXLCh35b78cBj
         pQ3okINhaCg5VXvuanIH38RK7URXi4YQY/SsYiM2p73cdI+rlywEIjMbf8xe+cHW0E
         yZsdgthlywjSAbr7I6Dg+aR4a9enNY6RgBaHfI8fz/L+6ob9kv7ZM91qrGPUJyov9R
         T+V39jCIMj8J5iinPWImdzXhatuDhAj4or8jZ16hnfxReiSXOKclv8yqwf2YfI1y5e
         AsEi2QNOX8AmGx+qxUxX2c/O7+Gh9yO6MMpAerCs+nWeQIxtwdaMqdOsnDEeVwxUGT
         Om+cYqYDelTaw==
Date:   Tue, 1 Mar 2022 13:28:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zhen Ni <nizhen@uniontech.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Asoc: au1x: Use devm_snd_soc_register_component()
Message-ID: <Yh4fdXOUKNeV7Mi5@sirena.org.uk>
References: <20220301092322.5523-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zr9XoaaziLUuphUQ"
Content-Disposition: inline
In-Reply-To: <20220301092322.5523-1-nizhen@uniontech.com>
X-Cookie: You have a message from the operator.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zr9XoaaziLUuphUQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2022 at 05:23:22PM +0800, Zhen Ni wrote:

> +++ b/sound/soc/au1x/psc-ac97.c
> @@ -411,7 +411,7 @@ static int au1xpsc_ac97_drvprobe(struct platform_devi=
ce *pdev)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D snd_soc_register_component(&pdev->dev, &au1xpsc_ac97_component,
> +	ret =3D devm_snd_soc_register_component(&pdev->dev, &au1xpsc_ac97_compo=
nent,
>  					 &wd->dai_drv, 1);
>  	if (ret)
>  		return ret;
> --=20

This introduces a double free since there is a remove() function which
calls snd_soc_unregister_component().

--zr9XoaaziLUuphUQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIeH3QACgkQJNaLcl1U
h9AlGQf8DucapLDhz1pD0o0kOT1xiZ6hy8KKO8CpBrPAdGBfrXe91VdcA/CVeXFY
kRnW/mOLksTrt/cpimgUHgU5zO+Uld3crP618bQE+xjdDkeL+qrLm91u5I9GzkDp
GwlJ8yqTwabMtnnixq9JfwI4kSvaOxasS7Egd2jOqxmNmvrj+8xfi/L+nKTK3Ry0
YJrAtLXMnqX3c+qudrlRQ3VEwVMN9S7yM5Ykflyq7UBstVCmdQRbiN6nFtUK76+Q
ANDZL7D/oZJbvMv/E7sDk8uMSMeK4th+txIJAahQZkTiTJFeBTIGzcFjxZUnCB6H
OxV+fMyBHv920/AZQV5JbPdcw+Sr6w==
=4xOp
-----END PGP SIGNATURE-----

--zr9XoaaziLUuphUQ--
