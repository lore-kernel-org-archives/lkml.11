Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB46CCA473
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 15:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245689AbiFOPyU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 11:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241258AbiFOPyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:54:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 320C31EEC1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655308453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TEmJ1fJ8Yf6oDfx0MBc+zDdacxWq2un2XNoeG1V4KKU=;
        b=FEMNpxkvKwADUdqE0kEgkLuOBuRM9Wj/u9QOyN59Fios5Jbbpx8wzoI2TZbTLlxF7Qu0ZY
        24gIpvympXZEaqwHoEApMAYN7X++dudUJ+8+F6pBYh3mFh8g7Nel5RvL4txrnviclkPZbR
        U8TgnjOk7OPV0eOSV/RhhAUm9t0hcgc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-D_983ZWxOxWyh_k1LNsgaw-1; Wed, 15 Jun 2022 11:54:10 -0400
X-MC-Unique: D_983ZWxOxWyh_k1LNsgaw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5728B38005CB;
        Wed, 15 Jun 2022 15:54:10 +0000 (UTC)
Received: from localhost (unknown [10.39.192.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2EE51415107;
        Wed, 15 Jun 2022 15:54:09 +0000 (UTC)
Date:   Wed, 15 Jun 2022 14:54:29 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     vgoyal@redhat.com, miklos@szeredi.hu,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtiofs: delete unused parameter for
 virtio_fs_cleanup_vqs
Message-ID: <YqnklWCUQBamzmJJ@stefanha-x1.localdomain>
References: <20220610020838.1543-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VSfWJTB4dTlkafrv"
Content-Disposition: inline
In-Reply-To: <20220610020838.1543-1-wangdeming@inspur.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VSfWJTB4dTlkafrv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2022 at 10:08:38PM -0400, Deming Wang wrote:
> fs parameter not used. So, it needs to be deleted.
>=20
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  fs/fuse/virtio_fs.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--VSfWJTB4dTlkafrv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmKp5JUACgkQnKSrs4Gr
c8i8ogf+JVNIK5wafiTY0HlfRmCOIhYMJ8AbK4vwM0rKJeoQc+tgLDPQHHCVMGDM
lqtAdpnNzCHGOTTe8+sbTVhxhH+THmJvh1c7fX630vgW6MQWQICOT1ablFIJN/jF
4snTGcSXXaPWMp9B4YJp4n+LBkH3WPHLYGuy1tzgDSYRCnv7ofeKitJ5b3BVWhuc
zBgS6VNklGbEycPII0gUR8doCeW3laSbHT/3Cai3lVs6iqfZlv/wfvpG8gszeHqm
IFb5Y93cFAWvxZg11kx8g8Ps3GirNj/y1tq/USKPaQ1PlbQmSZKrSW/6eku2RMXO
yvOmooxFHUf/aUVMw/BqAynlUDfLLg==
=BmCq
-----END PGP SIGNATURE-----

--VSfWJTB4dTlkafrv--

