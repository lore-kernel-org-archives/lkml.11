Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 06:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiC2GrY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 02:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbiC2GrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:47:23 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9727C23C0F0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 23:45:40 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id D545D5F8EA;
        Tue, 29 Mar 2022 08:45:38 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: mm: use mmap_assert_write_locked() instead of open coding it
Date:   Tue, 29 Mar 2022 08:45:37 +0200
Message-ID: <10178697.CBVEcFiDRS@mobilepool36.emlix.com>
In-Reply-To: <YkKo93R1Fm0JXXtS@infradead.org>
References: <5827758.TJ1SttVevJ@mobilepool36.emlix.com> <YkKo93R1Fm0JXXtS@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5766660.gleqY7jeCr"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5766660.gleqY7jeCr
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: Christoph Hellwig <hch@infradead.org>
Date: Tue, 29 Mar 2022 08:45:37 +0200
Message-ID: <10178697.CBVEcFiDRS@mobilepool36.emlix.com>
In-Reply-To: <YkKo93R1Fm0JXXtS@infradead.org>

Am Dienstag, 29. M=C3=A4rz 2022, 08:36:39 CEST schrieb Christoph Hellwig:
> On Mon, Mar 28, 2022 at 10:24:51AM +0200, Rolf Eike Beer wrote:
> > In case the lock is actually not held at this point this also avoids a
> > stale lock reference if built with NDEBUG.
>=20
> The change looks good:
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>=20
> But I don't think NDEBUG is a thing in the kernel.

You are right, it was in tools/include/linux/kernel.h and I didn't spot the=
=20
prefix. Andrew, maybe you could just delete the sentence when you add the=20
Reviewed-by?

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart5766660.gleqY7jeCr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYkKrEQAKCRCr5FH7Xu2t
/LXcBADMuAegclXembgVJmHq0YcEloLQWTaJRtS92hzIVkoOWoPOLiv9eDVPRin7
prtThu86pU+RMyxgDF9t0rO304qTCVXtZ3yuL8O1g1DGEBp+aCIaXvpBW2CuxUO+
BCVCmXDNrGHIx7ZS7ZVs/trKfFOROvdkxLcLnAILsM4636Orjw==
=zfeV
-----END PGP SIGNATURE-----

--nextPart5766660.gleqY7jeCr--



