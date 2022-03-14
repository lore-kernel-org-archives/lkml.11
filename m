Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DF5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 11:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbiCNLK0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 07:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238801AbiCNLKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:10:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5924213CE9;
        Mon, 14 Mar 2022 04:09:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHDLq4Hk7z4xLS;
        Mon, 14 Mar 2022 22:09:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647256147;
        bh=Pn1uR5RihtV7pTnv1JUsDYmzsaDWJ6firiRLmwfXPek=;
        h=Date:From:To:Cc:Subject:From;
        b=n5U06B3GSHe3a1Z+2k6iyL3TPdXQ4xShWl8Tc0PL/FA78Bw8jce/JZhPcMlgDp+FP
         kbt8IQ7xRMri04p0tjbS+7CF73eLu00Qokuza5lFkoTAPEPk3xr7Z75Y9KRdZutsA/
         bXooPOvzBsxGwMoedm+dV4u9Q2W5N89Xs8SnIh1WvUIeyp8Qre+df0AIBpHF4RtYML
         zU0fpKB4IXR5gVc6WMgA/X7PlsVtClsi5+oksOUUxJKImahhPn6s8/4Ahn8fAuRiVQ
         pglOimgfcEWNyM4at2HNCFCqcn7k1bQAA+6C5hWOOgsqF8sZTqWxgn0PnnUNGEnikC
         Xi85WnS64rtQA==
Date:   Mon, 14 Mar 2022 22:09:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the hid tree
Message-ID: <20220314220905.4e9eb8cf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j7RygJc+1yep=iCIVz/ba9I";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j7RygJc+1yep=iCIVz/ba9I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  f97ec5d75e92 ("HID: intel-ish-hid: Use dma_alloc_coherent for firmware up=
date")

Fixes tag

  Fixes: commit 91b228107da3 ("HID: intel-ish-hid: ISH firmware loader clie=
nt driver")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/j7RygJc+1yep=iCIVz/ba9I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIvIlEACgkQAVBC80lX
0GymBwf/Qh5HfPEx/3hy6ppWHQulrhF7G5Z0ZlEFfqOAbitnGPmMY2BEyJ1VNSY1
L1r5/fnWTUahYITXL7TNPswXrSv3EOkcWQyIVW+TnBjJA4uZwR81AuV6L+BpHpMY
qcuAYgIVWQv+XErp9HryOfafHvboO+iE/tijdYbGMRLOQYbXvQFfjsqwdM7TIeDb
7CT7v8xnrXYw2hkIX+4NKtKQeFZVVCdK8YMMJa6OdDW5c6PRQcrHqcwBX1ru8i0N
VjTHFUd9UxRRS/4YND9AlSFU2rn7fDqOtXVmMK0WzvKP33y9969tWj4/kSP2/n35
pnX1yhqIxMvjo5jLZkfwaar/dgRFJg==
=rz2q
-----END PGP SIGNATURE-----

--Sig_/j7RygJc+1yep=iCIVz/ba9I--
