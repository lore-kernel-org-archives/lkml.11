Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70C5C00140
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 04:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiHHEV2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Aug 2022 00:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiHHEVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 00:21:25 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66385B1CB
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 21:21:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M1NLV5jykz4x1J;
        Mon,  8 Aug 2022 14:21:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1659932483;
        bh=3LvqyDOrzDOSiQKTVH1+ZHRlUn2RfICwbDETaZllK60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SygUvfld9Q8kIO7eSyqpNM/QXOzDdRcVVhoHyma39rzdD19oBb4ZTPOofWUmFiNMe
         SyMx27ulk+ayo1jp+g8mdDzfCsDJsOazufyg03fNMtxCEZNELQxLY7whW4Jx+CJ6Dz
         S0Wxa0vTn7TThrGT2SN4nyoran5XV6VvPuvPa4QgdiRvFypjRR1oQtzZAvCgS365P/
         jp7KwWjQjRWm0in5XDJWTMtajVeEj/rgEd9Ngd7EnXoL1oaCe6vLpvrP0LCrKQm8uo
         s4iq5mxrgiK69WwqDh0p1XWS+vv8FrmzWKZ3sO5CWW1dhl/zVjWD7iN83n57wIu7V6
         aYmc+klrH95Mw==
Date:   Mon, 8 Aug 2022 14:21:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Bitmap patches for v6.0-rc1
Message-ID: <20220808142121.6d62a431@canb.auug.org.au>
In-Reply-To: <CAHk-=wjbFrPfKA5DOnPXvn_0hTmSw2oTXPKxtDoC5v12McW2DQ@mail.gmail.com>
References: <20220805022940.1637978-1-yury.norov@gmail.com>
        <165991968404.10077.6220067519297859381.pr-tracker-bot@kernel.org>
        <CAHk-=wjbFrPfKA5DOnPXvn_0hTmSw2oTXPKxtDoC5v12McW2DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EbV7=aXdO4+ZCHhh9PJlfz9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EbV7=aXdO4+ZCHhh9PJlfz9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Sun, 7 Aug 2022 17:57:35 -0700 Linus Torvalds <torvalds@linux-foundation=
.org> wrote:
>
> But hopefully people never noticed, because nobody sane is looking at
> my tree on a Sunday evening.

Well, for some of us it is Monday already :-)  I did not notice though.

--=20
Cheers,
Stephen Rothwell

--Sig_/EbV7=aXdO4+ZCHhh9PJlfz9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLwj0EACgkQAVBC80lX
0GxGMggAmZ8cLAztLtAQMTx1susTnOVLO0c/ViSAKbpwJFXRNLHuu5RdC/59EIbZ
YmC+IvecMD1HC1EEOuMZ791p4hJZ7rkmiJpinbovyLZJus+388nz3NgJwDhHUWf6
YklH5tBh/PE+ZQL4smjonz8JsoZziQ+MAA6HVSWQROuodewqnqlp7Xf/ZwoTV4vu
FDAuu8Il1hX1Vzz3jzr74sXA902opTiwNPSyDpYMDqYB71UvW8ByHy5VALkY+Y6o
MOamys3X4Q24qEB7RVhuebZLBS6PJJ0m2LB+x5h07nicWCGo4q+JZluF1PnzAT6+
LkKHwTntkOylJhSY2/sMzr8zkvH18w==
=k4e6
-----END PGP SIGNATURE-----

--Sig_/EbV7=aXdO4+ZCHhh9PJlfz9--
