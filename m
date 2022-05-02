Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AF9C433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 21:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387688AbiEBVhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 17:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbiEBVhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:37:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCC3E09E;
        Mon,  2 May 2022 14:34:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ksbvf0Bwsz4ySV;
        Tue,  3 May 2022 07:34:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651527262;
        bh=Sw9+kEws1IXisWpPFuVd1ZJRyrUj/xmq/YIS9Y8hUdo=;
        h=Date:From:To:Cc:Subject:From;
        b=CdZiBHdlY55VYxxlKXZ2hhOqiTuWfnl7jbbxrN8wyRQIWVLELbhqVdjCUNL70mQiR
         Kv0mB/kYZtd1spTCmnLJWR+m1to/0PDFAeE59290CgEbPpFwrEmK6EOvsvidDRVGoe
         Gbw44cwnvz8qnjM50nl9/wQ86lEuVYTy2H2tnNGMr/lhx+I0ZQWdME1ndkpiryUxA2
         JztGJ7E9OWtIEzvh0kzrp4sg8i9uBtLkp/T/+79sz+48K+9CmBCzj/hmYeJs02cLFt
         Ym8U/rvFNck4u2zcGmIRibqSMqPn4yJ7D3MtpmgQv+YD8FA1wpAEBtPdOi4zsPAM9P
         /yBYj3MsmZlIQ==
Date:   Tue, 3 May 2022 07:34:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20220503073420.6d3f135d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//Vy1iPreFSvni.a6So.7c2G";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//Vy1iPreFSvni.a6So.7c2G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/networking/kapi:92: net/core/dev.c:4101: WARNING: Missing mat=
ching underline for section title overline.

---------------------------------------------------------------------------=
--------
     I notice this method can also return errors from the queue disciplines,
     including NET_XMIT_DROP, which is a positive value.  So, errors can al=
so


Introduced by commit

  c526fd8f9f4f ("net: inline dev_queue_xmit()")

I am not sure why this has turned up just now.

--=20
Cheers,
Stephen Rothwell

--Sig_//Vy1iPreFSvni.a6So.7c2G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJwTlwACgkQAVBC80lX
0Gxspwf/YQhrwk/tVyL8lqzhKezG6Dk3aS7piRkFropCVqbH2PqzUJnUMXZS/TI4
dJDp+0mmbhj7fxYV7pz5pxFjRo964iak2SXBCV32b/VBs9X3cOxTWIT+PcPgFwx8
7F6YUDlMmTg8mXuHJ9XKno0GI1pugOTdkWA8G5VkmTGygONDx7B1i7X0yeXw6OI4
rlEdxCA3iV0jsZEt95q4eHz59a3287N2ce7VzdhyfTENBTh3Fpy/1L/wREoBSLV5
LB0BXEncheguJ2XEm7pFZBB8a8upHHdXCVyzTpUFDuJsKnZrrb3u+J8DKxa8oi7i
uRMB4nM8giMwe/nkqm7TSJ4By8VQXw==
=h0GC
-----END PGP SIGNATURE-----

--Sig_//Vy1iPreFSvni.a6So.7c2G--
