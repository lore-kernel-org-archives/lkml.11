Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CB2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 16:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbiCRQLm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 12:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbiCRQLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:11:33 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E356315B073
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:10:11 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 795D81BF203;
        Fri, 18 Mar 2022 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647619810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQdKz+w5I+TaeLA1poZqcKLK7AJ0rnm4toqX/aN2ZnE=;
        b=GfMS5DSvKhGuvElF/VfqDlFwSNsT/yt7AwcCv6jMOXaLZtJzID5cqQV6ptN+4Kfh6EOSMr
        PU5m75M9Ui8W7mvuN7UfZ0hAXV9Q9UOQAJgEr3PiF8mZHOz872wbfOhOxnDeql2jTFqDEp
        kmn/5O+wc8R3FTTVFBQK3Y0lilI1GedBo050MSQ7fIX7EGWTnHOhlfvl/iWbaj7s2ZppyD
        UersdTZq7agRmuDuZ/XZeJlCX+wVkn6DyH+0nOOGdM5HAxAQeKTyhUYmy5KTzR5SbDnp0N
        s4NOVlc+8PmPguu5FwMDz4yaVmFE77Kz1Fz0z9oMX/u5eNuqsASSAz/uZSndpQ==
Date:   Fri, 18 Mar 2022 17:10:09 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] drm: of: Properly try all possible cases for
 bridge/panel detection
Message-ID: <YjSu4QSocJkvI1QQ@aptenodytes>
References: <20220309143200.111292-1-paul.kocialkowski@bootlin.com>
 <CAMty3ZAZKHTqfR=ecRgpzJtVefhFFrSpcEqueSQ6K-=Q75XU4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OQJjaAMbKPBvVXdJ"
Content-Disposition: inline
In-Reply-To: <CAMty3ZAZKHTqfR=ecRgpzJtVefhFFrSpcEqueSQ6K-=Q75XU4w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OQJjaAMbKPBvVXdJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jagan,

On Fri 18 Mar 22, 21:35, Jagan Teki wrote:
> Hi Paul,
>=20
> On Wed, Mar 9, 2022 at 8:02 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> >
> > While bridge/panel detection was initially relying on the usual
> > port/ports-based of graph detection, it was recently changed to
> > perform the lookup on any child node that is not port/ports
> > instead when such a node is available, with no fallback on the
> > usual way.
> >
> > This results in breaking detection when a child node is present
> > but does not contain any panel or bridge node, even when the
> > usual port/ports-based of graph is there.
>=20
> Can you add that pipeline example on the commit message, it gives more
> information on specific use cases why the existing code breaks.

Ah I just sent v2 before reading your message.

Well I think the description says it all: the problem shows as soon as ther=
e's
a child node to the node passed to drm_of_find_panel_or_bridge and it's rea=
lly
independent from the of graph setup in the end.

I think Maxime put some examples on the original thread (v4 of your patch).

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--OQJjaAMbKPBvVXdJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmI0ruAACgkQ3cLmz3+f
v9G53gf+NkkRlo5/PoTI9lZrEoUmsF4IlY7LLpmODvNcJ3S9NJhyuRyPsEWedodt
73NOl2ubUapUy5RmIwKyqOYDfGc4xV0yRs5uVYou+NL1/JGBK1p/VLke64UWVHTk
T0FKpb6fHCyfPkvG5LL4+3oqRWhbPE+4K0JafOaGybGrGeJ8ZW/OL/Rctfy2Xulg
GCFxDKvLmxnOaC57Ja6W8DeX/EKlIMt1wWlY4ugkf/PzyUOg83FJ4LZjm2dShHjF
ictZQkLKyGlJWO0yiZMhO9A4X0FaVcMPOJWvA8VxMSuicBXjv7r2KXD9pKWM7a6n
b/aUhxnWd4qDstkhEEOYjythW9Ow2w==
=tA1M
-----END PGP SIGNATURE-----

--OQJjaAMbKPBvVXdJ--
