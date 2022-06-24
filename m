Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A08CCA473
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 13:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiFXN4T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 09:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiFXN4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:56:18 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678DA4D608
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:56:17 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 03495672; Fri, 24 Jun 2022 15:56:15 +0200 (CEST)
Date:   Fri, 24 Jun 2022 15:56:14 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.19-rc3
Message-ID: <YrXCfic1ua0DdDBQ@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i5gdFe3KS1rh1Ndu"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i5gdFe3KS1rh1Ndu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.19-rc3

for you to fetch changes up to c242507c1b895646b4a25060df13b6214805759f:

  MAINTAINERS: Add new IOMMU development mailing list (2022-06-24 15:36:11 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.19-rc3

Including:

	- Add a new IOMMU mailing list to the MAINTAINERS file to
	  prepare for the a list migration happening on July 5th. The
	  old list needs to stay in place until the switch happens to
	  guarantee seemless archiving of list email.

	- Fix compatible device-tree string for rcar-gen4 in Renesas
	  IOMMU driver.

----------------------------------------------------------------
Joerg Roedel (1):
      MAINTAINERS: Add new IOMMU development mailing list

Yoshihiro Shimoda (1):
      iommu/ipmmu-vmsa: Fix compatible for rcar-gen4

 MAINTAINERS                | 11 +++++++++++
 drivers/iommu/ipmmu-vmsa.c |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg

--i5gdFe3KS1rh1Ndu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmK1wn4ACgkQK/BELZcB
GuOZaBAApa52HkW7MJ1GuhOvN0LLqNWMUOI1ED+dgNjSeLXH47WANnM4g/23uXfl
82YBQ8Gp8Cq+Xtv9cJPb1ol5GwXYrG4c3FMwqcwp9l8fLwyb1VwPXPNvFrHSrrin
GqVuBuWzv1M4k2yrggeVMztd9pt2N4OFfnzSbVTxGoErbbSv3S0o6o7/N0Gk79AY
5GrOVCGKZXz6lgJzzyBQBOb35IHBkFHzZm0GLCO6xOGBxSsChAWGOqOkC5acggJo
i6aaukPeD4Das20Vkph9Q/xKSGEIfZwhC4Bh/tuUEczgdKopoDO7uua/yX2POdJK
E1o1T7+OaklNFofIbGBm/83FcjOqQ6V8pkMmuvisvhoxm7CWdFqUg5IwSyCKsMjW
jlAduZ12RqYv6fPWisdkGxwZXtJhe+tYMFl/SBMpYZ0fGSg78QrXM0w3oWErsU7a
UAu0Ev8kglohHLpHTBQLM3dKNhaTgs1ZUZP0ZrY52jfcoyC7sb9H5NUmfMBS2ja2
nLxZsKkdC42ZzrtgB4g0PeIlykD/iZ/gA9nlwoOFoOZEnl9jM3WlTUmRgJvk9WIu
n31JiCJlOgAEOKVgQqnwgvdUi8UdU2rdUAOfeK/A/elUWg5dGUqxEZ33xIVQlyZr
ZVDw7hdIMAF/0p33z3Lpo9ydGZ5lpD8SrlcvKDFdaNjj0PGJZMo=
=ajTF
-----END PGP SIGNATURE-----

--i5gdFe3KS1rh1Ndu--
