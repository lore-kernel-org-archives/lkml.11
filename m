Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F74C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 17:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbiBRRUq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 12:20:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238378AbiBRRUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:20:38 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0152B5B8A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:20:21 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 64FFF1C0B81; Fri, 18 Feb 2022 18:20:19 +0100 (CET)
Date:   Fri, 18 Feb 2022 18:20:19 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sami =?iso-8859-1?Q?Ky=F6stil=E4?= <skyostil@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, dtor@chromium.org,
        evanbenn@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/2] drivers/misc: add a driver for HPS
Message-ID: <20220218172019.GA3039@duo.ucw.cz>
References: <20220127083545.1020423-1-skyostil@chromium.org>
 <20220127083545.1020423-2-skyostil@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20220127083545.1020423-2-skyostil@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +config HPS_I2C
> +	tristate "ChromeOS HPS device support"
> +	depends on HID && I2C && PM
> +	help
> +	  Say Y here if you want to enable support for the ChromeOS
> +	  anti-snooping sensor (HPS), attached via I2C. The driver supports a
> +	  sensor connected to the I2C bus and exposes it as a character device.
> +	  To save power, the sensor is automatically powered down when no
> +	  clients are accessing it.
> +

We don't need to know about power management here; but it would be
good to have explanation what anti-snooping sensor actually does. Is
it camera detecting user or what?

Best regards,
								Pavel
							=09
--=20
http://www.livejournal.com/~pavelmachek

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYg/VUwAKCRAw5/Bqldv6
8h/AAJ9ytBOO8Y97am1YaDjCvlMkJx/7MwCgveMpyC8qo082BiXp5hj3hwh3ggg=
=uV4L
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
