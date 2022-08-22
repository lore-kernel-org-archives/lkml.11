Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEA9C32774
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 13:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiHVNjb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 09:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiHVNjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:39:19 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A50DEBB
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:39:17 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id C64DE60206;
        Mon, 22 Aug 2022 15:04:37 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Minor improvements for pagewalk code
Date:   Mon, 22 Aug 2022 14:59:04 +0200
Message-ID: <3200642.44csPzL39Z@devpool047>
Organization: emlix GmbH
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8115493.T7Z3S40VBb"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8115493.T7Z3S40VBb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Minor improvements for pagewalk code
Date: Mon, 22 Aug 2022 14:59:04 +0200
Message-ID: <3200642.44csPzL39Z@devpool047>
Organization: emlix GmbH
MIME-Version: 1.0

=46or some project I had to use the pagewalk API for certain things and dur=
ing=20
this have read through the code multiple times. Our usage has changed sever=
al=20
times depending on our current state of research as well.

During all of this I have made some tweaks to the code to be able to follow=
 it=20
better when hunting my own problems, and not call into some things that I=20
actually don't need. The patches are more or less independent of each other=
=2E=20
Especially the last one may heavily depend on personal taste, so if you don=
't=20
like it, just ignore it.

I would welcome if you could just pick those that you think are fitting and=
=20
provide feedback on either of the remaining ones. At the end none of them=20
should make any functional difference.

Regards,

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source

--nextPart8115493.T7Z3S40VBb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYwN9mAAKCRCr5FH7Xu2t
/C51A/46jKIaxEg5zbjMTl2PGZqn+IURMiBHLx8LZDi8yDdjqxsL2qhYKkLx8Z+Q
yffauxq8Xd2K46QacbCP5dyfx+2tDA+KaiPPKIEep+Gb33rPbgJmzlRUJeA+dM9q
/MEohqbJMeRWgyaEe+z8RSzETQaLJkNPUv6RIzsGotCA65rp1A==
=7AlL
-----END PGP SIGNATURE-----

--nextPart8115493.T7Z3S40VBb--



