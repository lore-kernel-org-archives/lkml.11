Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE0AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 15:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbiGHPuo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 11:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238430AbiGHPul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:50:41 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF37F73939
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 08:50:39 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D5E505F1; Fri,  8 Jul 2022 17:50:37 +0200 (CEST)
Date:   Fri, 8 Jul 2022 17:50:36 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v5.19-rc5
Message-ID: <YshSTPK8g5U2NZtR@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1xSl/lweFE1sGsPt"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1xSl/lweFE1sGsPt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 88084a3df1672e131ddc1b4e39eeacfd39864acf:

  Linux 5.19-rc5 (2022-07-03 15:39:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.19-rc5

for you to fetch changes up to c51b8f85c4157eb91c2f4ab34b0c52fea642e77c:

  MAINTAINERS: Remove iommu@lists.linux-foundation.org (2022-07-08 09:34:26 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.19-rc5

Including:

	- Patch for the Intel VT-d driver to fix device setup failures
	  when the PASID table is shared

	- Fix for Intel VT-d device hot-add failure due to wrong device
	  notifier order

	- Remove the old IOMMU mailing list from the MAINTAINERS file
	  now that it has been retired

----------------------------------------------------------------
Joerg Roedel (1):
      MAINTAINERS: Remove iommu@lists.linux-foundation.org

Lu Baolu (1):
      iommu/vt-d: Fix RID2PASID setup/teardown failure

Yian Chen (1):
      iommu/vt-d: Fix PCI bus rescan device hot add

 MAINTAINERS                 | 11 --------
 drivers/iommu/intel/dmar.c  |  2 +-
 drivers/iommu/intel/iommu.c | 24 ----------------
 drivers/iommu/intel/pasid.c | 69 ++-------------------------------------------
 drivers/iommu/intel/pasid.h |  1 -
 include/linux/intel-iommu.h |  3 --
 6 files changed, 4 insertions(+), 106 deletions(-)

Please pull.

Thanks,

	Joerg

--1xSl/lweFE1sGsPt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmLIUkwACgkQK/BELZcB
GuPRgxAA3tGreniU/4njpYaYJiXeIkJmwjzlWIRMmvzXFTop7uqtva5ODNDxek2P
pS6leA7LDyKjEegQuqQ3EKKTC0ZZR0WIgncZyTVjt4cPz6qd2+jZwlMChE/Pw3F/
FaCunDF90FLJYlWd1sX5ga1hUGaWK5x3NP1bnox69dvr5TrZSPjzIVGLsIY3qO9l
QmDsDIgREoRp19MpRUp7Qxsjt8aODMQjhTGkXpNXCuwgiXiUENagWpyBX2xfdTVc
Mx6MxJxkL/Ze2iVrUw8570qPcKIjHR1a6CZ4ophqftRZb3rLExm8qH50o//j7XRy
FbAxQWRMirsYXGD/Y9wqHq0U8IfJvbo5SupW8HO441s+DeMq52HOr7wpUV8f4e5N
Xc1qEPBkbiwVC/ULeQi/lCWutPpPFT7vrCPCWNQavvdxXpGRt+geVklS8iTuwHW9
zg5rVPxvqbRQbNVP+q4vRUcmuqHVDTxgssjlcRgOg6aj/gqtRqNWVdvH/vXW/fhR
DwDsW9EGevQnWCLuvpExr+rI36utS1gN0NDMlqSkPfFWK76MV4yHlRCJvmrCU6Oq
kCPAnSoyJuLVBGY0xfv/B4fnIOQrVWTTlX4FivvJBuIiKZdHpw5AIuGAWCXgwb5W
cprQaA8tdhzihbtsJ5qVQTpTiQZgA4zh2o1HpgWkdqfE7HD0xsY=
=LrN8
-----END PGP SIGNATURE-----

--1xSl/lweFE1sGsPt--
