Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A96C00140
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 22:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiHJW3f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 18:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbiHJW32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:29:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A0D8D3FA;
        Wed, 10 Aug 2022 15:29:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M34Ny3M22z4x1P;
        Thu, 11 Aug 2022 08:29:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660170562;
        bh=Yh8cEFXsUsPqRCWFXvS4zQ3WyZG92Bk9SCcCNWzyj1s=;
        h=Date:From:To:Cc:Subject:From;
        b=WBHpeY5F1FlxEH0Lar/nbIwK3eNQi5PcuuKrq5vtvGfTugyQce/Y22TDVbWIORDqf
         tUVelTW1nc5qcpk8U/mvvJ/xdOTettA1oPe2BO4eICIApDhIP0UyP6MkROaiL2Mlos
         z9Rph+7MtFVCRNnmw407nVt2hkPSGM6UOp611rwMPtfAz+iBkbpwzXaHo4MvsiL81B
         dH8YnHANZCUk5CmI958SKKsOaB/+E9BtlM02FFZ2QU+Y2g5GtGyD9kNOI4ziBDem3m
         odjgCL1s0s+LMDjU9wig8xdxaqSo5Ne58zOd5DkWelsvaoaPdXbrtK509nk2kAQ8C9
         mBPe716jOT0qA==
Date:   Thu, 11 Aug 2022 08:28:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the vhost tree
Message-ID: <20220811082857.1ff15c69@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uKIkBrX1F/=qjIH_DvIOJgr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uKIkBrX1F/=qjIH_DvIOJgr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  5be8d7869e2d ("Bluetooth: virtio_bt: fix an error code in probe()")

Fixes tag

  Fixes: 212a6e51a630 ("Bluetooth: virtio_bt: fix device removal")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: bdbbdac22c63 ("Bluetooth: virtio_bt: fix device removal")

--=20
Cheers,
Stephen Rothwell

--Sig_/uKIkBrX1F/=qjIH_DvIOJgr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL0MSoACgkQAVBC80lX
0GxO1wf/Rh0OVVpwMs6g4LSFjSvqtYQ/2/G8NBkkLlPWvwLPg/OO4Uzq9c4hyqCp
ONM8QXUzuQUOBjKvvbMOyS774Mh85DXtofkTmq05zDoHxHtxtNQ93omJoIysTo5v
qLJFSi24UKYN298L2Cqp4T4D8qesb7ZMmOYBkby2DdrJRWumQb+RAkgIzBK7LUaH
dLSRqr3P8vL0UMw/bYHai9rmfjr/mJ8QfZ4nGMDPHqr62y5WEcGHhsj0Mef+D9GQ
eZRI83bmjDyGwilm/MSYB91KbBzTULsVZI7Ef0KrED15elaXZejkUZ7NtovW6AmD
lx8ChUHtZVy/SIyeEcvmpqGA42cC/A==
=bDqY
-----END PGP SIGNATURE-----

--Sig_/uKIkBrX1F/=qjIH_DvIOJgr--
