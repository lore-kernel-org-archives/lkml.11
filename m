Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789E3C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Jul 2022 15:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiGIPBG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Jul 2022 11:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGIPBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 11:01:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B8833344;
        Sat,  9 Jul 2022 08:01:01 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657378859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YNuUR8IL7aWclVdQQDh0X9l3C15Kxd+TTJgxbaYvY0c=;
        b=PAJ14VyDYmiYKSFIGzL/wof4GiClOzGdd9FIPluYfWm/q48+I6nQGprnSkf2EFWWPrMpvG
        125U3BAC0FKAgPNp1FKYjn0S02eSaQ1KL2wFR7QqJ+v7/B5ZaKM5uiClK5KD/fjT6Yr+FH
        N27XVUhexSjaEd756NX0GHgWmQX8NlReeLzuJZhXcxtxWYxZUZXivGsSAF6qfIYIjiXjjy
        1CWpfg+6BC8GLos/EZBDqpaVXz6aGROmtc/Qub53HlGVx4Cjd0UrmUf8K48jIzwQl/ySD4
        WroW2eFuYZsWPXRPA8nu9ZpcxcYf7sGejOGxDdjad6k2AVSHj5Kfb3a7sZJJ1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657378859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YNuUR8IL7aWclVdQQDh0X9l3C15Kxd+TTJgxbaYvY0c=;
        b=9Y7/kaztxrdaYUpDWU//5btk0J0TwQm9A3hZBBRrNoBrVkmlEjMMeGpN4QMoe01KBOTBsY
        bBL2vMvwujCGboDA==
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net: dsa: hellcreek: Use the bitmap API to allocate
 bitmaps
In-Reply-To: <8306e2ae69a5d8553691f5d10a86a4390daf594b.1657376651.git.christophe.jaillet@wanadoo.fr>
References: <8306e2ae69a5d8553691f5d10a86a4390daf594b.1657376651.git.christophe.jaillet@wanadoo.fr>
Date:   Sat, 09 Jul 2022 17:00:58 +0200
Message-ID: <874jzq8h5h.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Sat Jul 09 2022, Christophe JAILLET wrote:
> Use devm_bitmap_zalloc() instead of hand-writing them.
>
> It is less verbose and it improves the semantic.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmLJmCoTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgh3FD/wP4e1qoeYNeVmgedgEvaPd+DndGK0L
sbXrHXnL1WttLs1FBc79XvkmO7yfO/5Hy8IuiA8U88UZL3F9aMtrziJBwoQW5DgS
bUceauMkrLGVYjNMxmzRUgUGtrn5maNtFyjvu4S2/55I3fKoS5P9M93BY3+fYtem
xhYcU9GB2BadnIMtItiImDKyP9UFDeu/o30n17uGciJZq8cg16cqHsYqIhZvDs6F
OUrLNIy0IHcl4UBhokzXqTnAZjGIRbjwwWH9kXQPsoFw2KZhJ8U+EPyOjF9AfVP1
gBblLyE3vStnD3FG8DFkxX2/NHGAYbDD7/9evRxLjXJxWUiRPB2nn9+/ceBYrikh
y3E7mqG0CbPBjS5WNYtsP4DUCs0ugED/2oja84ncWyGwCK7ZCPeJ/4zUWuk+Mlkp
SuSOgLvlL2aNK5q9KHsGLzZ3sgfK+QOnt6npDIiwpgaISbAmNqivh0d8WeYZN4Ws
DATBhfpi79BR78gKh5J/uYbE0e9dqYeNc2aOnzK8Vb45ESR8DWH68XsP5gQrATOm
VdqN8lhsT5RI/401trMwdiaT04d4CUnAaAlzidl5KeZc4Bu/jJk/9IRDEv2XZ7NE
TDq7o67nFIqNOVaekUOnDJ1+yK0kwTiBIz/YDzSui3ifG/PLW5ukGIwmPhQnBkhE
aD+4o2y0W4NkLg==
=zwcA
-----END PGP SIGNATURE-----
--=-=-=--
