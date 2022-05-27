Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8C9C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 00:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiE0Aj1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 20:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiE0AjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 20:39:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33F4E5281;
        Thu, 26 May 2022 17:39:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L8Qsy71lrz4xDK;
        Fri, 27 May 2022 10:39:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653611961;
        bh=Urg5QK4WXDiWxbV0Ora75ObG3bel4emUqwm77YJPP/s=;
        h=Date:From:To:Cc:Subject:From;
        b=CWg5OK1jRA5dpywKbojkXHjQlBbzbjFVf5nFnRIpiB4fBdkgKzqkWcMLTh93QvmwM
         oHEItQWVWAJW/i7nHeq0Z4u46WNyimDCIhMTTGIMJF4PFLvostqqQkI6Pu5xQAI2Qh
         /164+AwMIVeR8xDsz/IZVYCpMy+et4jqRcQOgnflOVk2qfaC4dIXszV5xZgoje4cpy
         a1cqOh58KNTcKaYoLaskW44RRwVRQcbXUUIQaOkb0lJWqsQ33ipMEEtf6qZu1LeZr1
         ZrRQ2aQMN38fyl8PASeRKBTq2rAzzcuIuzc0f1bu9Ef/rpH6EjodsbyrAzWt9zMdg9
         elQ6BIkmLuUFA==
Date:   Fri, 27 May 2022 10:39:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Vivier <laurent@vivier.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nick Hawkins <nick.hawkins@hpe.com>
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20220527103916.52768f74@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A4WshG/iaHUmiVjQ9d8usu6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A4WshG/iaHUmiVjQ9d8usu6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  drivers/clocksource/Makefile

between commit:

  c92e7ef16400 ("clocksource/drivers: Add a goldfish-timer clocksource")

from Linus' tree and commit:

  5184f4bf151b ("clocksource/drivers/timer-gxp: Add HPE GXP Timer")

from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/clocksource/Makefile
index 833cfb7a96c1,98017abf6c03..000000000000
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@@ -85,4 -88,4 +85,5 @@@ obj-$(CONFIG_GX6605S_TIMER)		+=3D timer-g
  obj-$(CONFIG_HYPERV_TIMER)		+=3D hyperv_timer.o
  obj-$(CONFIG_MICROCHIP_PIT64B)		+=3D timer-microchip-pit64b.o
  obj-$(CONFIG_MSC313E_TIMER)		+=3D timer-msc313e.o
 +obj-$(CONFIG_GOLDFISH_TIMER)		+=3D timer-goldfish.o
+ obj-$(CONFIG_GXP_TIMER)			+=3D timer-gxp.o

--Sig_/A4WshG/iaHUmiVjQ9d8usu6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKQHbUACgkQAVBC80lX
0GxmkAf+IlXFtVv11tdgfgbTGeykCJuCJBfmzl1/ebiKhg6cfnSdsAMTE9UM0y1d
bCokBkLpoo8M1T6+ar5F503I96b5sxrQKo6/cxhYnTp7N7vveZKvK/g+7u0QFg4b
daPaRVQjwAZ8hBgAm3QPDw4H5dCvZt6/sasiB+HTg81OTZlgmEQ4Bw4yG+oIs5qA
iwCx2QlqW6eJrGkjfMFErZWxsJW998NP/Y2PTlYuZzGJMtqZGbfYwpdjXFfhn2E1
hO07SFobezM0yMS6pTXdDJIQvXun10lr4/0SXWP2fFReDg2MhU9dw7jHG+aHFAKW
lO2vPmB/MRTWy9BEu3LV+tCfXKzc2g==
=Yef4
-----END PGP SIGNATURE-----

--Sig_/A4WshG/iaHUmiVjQ9d8usu6--
