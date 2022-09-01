Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2938ECAAD1
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 03:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiIADwm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 23:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIADwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 23:52:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBDC5209B;
        Wed, 31 Aug 2022 20:52:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MJ6Z84CcQz4xFv;
        Thu,  1 Sep 2022 13:52:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662004352;
        bh=5yDbNoSQwiy0KVaH3KjxS+ug2ZzGG74/pIpd6vLL5yI=;
        h=Date:From:To:Cc:Subject:From;
        b=ucxWbyiV8YXXSKUBv7B1A2I1T0InKMKo9qKA+yhc7MMyFrjSSgU5Xm7YJV66RYz5a
         4KRpzr8+ikq0rlSlSZ6Bqgzm2rG/RfIenDSFKEvp1R52UU0QOs1pwuTNLe9SEK/ATZ
         rBrQj/fyQfdJSzOTUou/duj7vmOcooqSkelWk5I5d0uidJvH1J0WHdT/NhRhxD41/v
         jLaa/jAXlgms/FuLtusRbFCkoBEfVOMCyXXmQpvdANZQ7rO+eeTCGjTdvH72QaqZQ6
         QEmyS2TrLWlN12l5reL+wnEiQ5+A6wfz70H/hmlZh0Ws0rA2mXTGA5T3fY12tzKwA3
         OJXXfo8LTLISA==
Date:   Thu, 1 Sep 2022 13:52:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: linux-next: manual merge of the usb tree with the usb.current tree
Message-ID: <20220901135230.37584d32@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9X=jE5oqJ2cpPILf/Sxt752";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9X=jE5oqJ2cpPILf/Sxt752
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  drivers/usb/dwc3/gadget.c

between commit:

  040f2dbd2010 ("usb: dwc3: gadget: Avoid duplicate requests to enable Run/=
Stop")

from the usb.current tree and commit:

  9711c67de748 ("usb: dwc3: gadget: Synchronize IRQ between soft connect/di=
sconnect")

from the usb tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/usb/dwc3/gadget.c
index eca945feeec3,d6c0cb79ace3..000000000000
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@@ -2563,11 -2569,8 +2566,13 @@@ static int dwc3_gadget_pullup(struct us
  		return 0;
  	}
 =20
 +	if (dwc->pullups_connected =3D=3D is_on) {
 +		pm_runtime_put(dwc->dev);
 +		return 0;
 +	}
 +
+ 	synchronize_irq(dwc->irq_gadget);
+=20
  	if (!is_on) {
  		ret =3D dwc3_gadget_soft_disconnect(dwc);
  	} else {

--Sig_/9X=jE5oqJ2cpPILf/Sxt752
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMQLH4ACgkQAVBC80lX
0Gx9WAf/YjOODJPzPQjutdOWEKpTypBcRjzCQnZnhdcmCN7A5LDiH3J3wHEMONLY
E18vMO9QsQ9HTSgHRCyLNYH/yuFiTBhdrjUm5Q7B/rGhhUmRzJ/JYoUh+LTrHPd9
zpQPSS/NEjCcSoIW98HOo8rCdJMcikk1L8jS1CLt7SGiImoPIUcvD6VbeTY4ekj2
muxgQD2tp7YhbsStpZ5U2ASUG5+wLHQSdWwKCYX6pkXmBfz/Pe2KFrqAR2JKR9Xe
PTsu4l4r9R0clqq2RkMSWsaz0GhbOPRuiZsG1RrEhKRp/2hqU6wRS8QcCUraJrMY
AWmqter8RINhDM44taQvWPX1SdyQEg==
=pOhH
-----END PGP SIGNATURE-----

--Sig_/9X=jE5oqJ2cpPILf/Sxt752--
