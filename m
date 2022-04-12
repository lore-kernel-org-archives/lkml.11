Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E3EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 09:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377295AbiDLJ2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 05:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379577AbiDLIUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:20:39 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD78B46154
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:48:27 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0A4B9FF80A;
        Tue, 12 Apr 2022 07:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649749706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YW/FpTIll39+9L5ULUaE9f07ZfIeCCQhSd38iCsA3pg=;
        b=aXzEGK9EGcOVOJifzQG1YR9RgJX9bx4SRppY92QDfZCpkF7UG+SuAE+Vt3fD+s4lUG9Dp/
        6E2GOvRJUD3BrQQRuyBjEG+aPdyB+l36E0p6D5FAv0+/lUp9U/0BO+UexyjYN4nbjbBKi3
        yKTP2jtMkAMg4BZuEJtHoDGlf3stW/95B1L1ZFDcIx1wGTsTUjAmLnV+PLRNQbOc8s11D6
        FHRkgZg4BlnxjYRczCsHCgpPCxz242Zd0t2mGEjZrB8JJvC4krFD1gtGPAUu6q1j90u+c/
        8BFlf51DjUxZS/ikaKKj/5jV85k1S3INssgYwm81Xq1Zsnt5wDKZwG/775U/ug==
Date:   Tue, 12 Apr 2022 09:48:22 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bastian Hecht <hechtb@googlemail.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: Fix return value check of
 wait_for_completion_timeout
Message-ID: <20220412094822.3818ebc2@xps13>
In-Reply-To: <61783400-4df2-47af-78a7-7acb715c3a71@gmail.com>
References: <202204121253.NcZifMQi-lkp@intel.com>
        <20220412063703.8537-1-linmq006@gmail.com>
        <20220412090649.33bb3f8b@xps13>
        <61783400-4df2-47af-78a7-7acb715c3a71@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian,

linmq006@gmail.com wrote on Tue, 12 Apr 2022 15:42:02 +0800:

> Hi Miquel,
>=20
> Thanks for your reply.
>=20
> On 2022/4/12 15:06, Miquel Raynal wrote:
> > Hi Miaoqian,
> >
> > linmq006@gmail.com wrote on Tue, 12 Apr 2022 06:36:52 +0000:
> > =20
> >> wait_for_completion_timeout() returns unsigned long not int.
> >> It returns 0 if timed out, and positive if completed.
> >> The check for <=3D 0 is ambiguous and should be =3D=3D 0 here
> >> indicating timeout which is the only error case.
> >>
> >> Fixes: 83738d87e3a0 ("mtd: sh_flctl: Add DMA capabilty")
> >> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> >> ---
> >> change in v2:
> >> - initialize ret to 1.
> >> ---
> >>  drivers/mtd/nand/raw/sh_flctl.c | 8 +++++---
> >>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh=
_flctl.c
> >> index b85b9c6fcc42..2373251f585b 100644
> >> --- a/drivers/mtd/nand/raw/sh_flctl.c
> >> +++ b/drivers/mtd/nand/raw/sh_flctl.c
> >> @@ -384,7 +384,8 @@ static int flctl_dma_fifo0_transfer(struct sh_flct=
l *flctl, unsigned long *buf,
> >>  	dma_addr_t dma_addr;
> >>  	dma_cookie_t cookie;
> >>  	uint32_t reg;
> >> -	int ret;
> >> +	int ret =3D 1; =20
> > Does not look right. I know this function returns > 0 on positive
> > outcomes but this does not make any sense in the first place. =20
>=20
> Yes, I made a mistake, Now I realize that in v2, it will return 1 in erro=
r path
>=20
> when DMA submit failed.

Not 1, but a proper error code please (-ETIMEDOUT, -EINVAL, whatever)

>=20
> And for patch v1, it will return 0=C2=A0 if calls wait_for_completion_tim=
eout succeeds.
>=20
> > This function is static and only called twice, please turn it into
> > something like:
> >
> > if (dma_fifo_transfer())
> > 	error
> > else
> > 	ok =20
>=20
> So I want to keep ret>0 means success.
>=20
> Or could I set ret > 0 after in wait_for_completion_timeout() success pat=
h?
>=20
> like:
>=20
> =C2=A0=C2=A0=C2=A0 if(time_left =3D=3D 0)
>=20
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D -ETIMEDO=
UT;
>=20
> =C2=A0=C2=A0=C2=A0 else
>=20
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 ret =3D 1;

You can initialize ret to zero at to top. So that anything !=3D 0 is an
error (like a lot of functions in the kernel). And use:

	if (dma_fifo_transfer())
		error();

>=20
> What do you think?
>=20
>=20
> Thanks,
>=20
> >> +	unsigned long time_left;
> >> =20
> >>  	if (dir =3D=3D DMA_FROM_DEVICE) {
> >>  		chan =3D flctl->chan_fifo0_rx;
> >> @@ -425,13 +426,14 @@ static int flctl_dma_fifo0_transfer(struct sh_fl=
ctl *flctl, unsigned long *buf,
> >>  		goto out;
> >>  	}
> >> =20
> >> -	ret =3D
> >> +	time_left =3D
> >>  	wait_for_completion_timeout(&flctl->dma_complete,
> >>  				msecs_to_jiffies(3000));
> >> =20
> >> -	if (ret <=3D 0) {
> >> +	if (time_left =3D=3D 0) {
> >>  		dmaengine_terminate_all(chan);
> >>  		dev_err(&flctl->pdev->dev, "wait_for_completion_timeout\n");
> >> +		ret =3D -ETIMEDOUT;
> >>  	}
> >> =20
> >>  out: =20
> >
> > Thanks,
> > Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
