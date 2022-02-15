Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CBAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 15:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbiBOPBs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:01:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbiBOPBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:01:43 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDDC13CE5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:01:33 -0800 (PST)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1nJzKT-0001Wq-7a; Tue, 15 Feb 2022 10:01:21 -0500
Message-ID: <63f930e411655a6ad37d4818d0ae19784c82f076.camel@surriel.com>
Subject: Re: [PATCH v2] mm: clean up hwpoison page cache page in fault path
From:   Rik van Riel <riel@surriel.com>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, linux-mm@kvack.org,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Date:   Tue, 15 Feb 2022 10:01:20 -0500
In-Reply-To: <2a881586-3f5e-c277-f373-a9014d631700@redhat.com>
References: <20220212213740.423efcea@imladris.surriel.com>
         <2a881586-3f5e-c277-f373-a9014d631700@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xmBlxiMQ0RX+8gFzH+9g"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xmBlxiMQ0RX+8gFzH+9g
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2022-02-15 at 12:22 +0100, David Hildenbrand wrote:
> On 13.02.22 03:37, Rik van Riel wrote:
> > Sometimes the page offlining code can leave behind a hwpoisoned
> > clean
> > page cache page. This can lead to programs being killed over and
> > over
> > and over again as they fault in the hwpoisoned page, get killed,
> > and
> > then get re-spawned by whatever wanted to run them.
>=20
> Hi Rik,
>=20
> am I correct that you are only talking about soft offlining as
> triggered
> from mm/memory-failure.c, not page offlining as in memory offlining
> mm/memory_hotunplug.c ?

That is correct in that I am talking only about memory-failure.c,
however the code in memory-failure.c has both hard and soft
offlining modes, and I suppose this patch covers both?

--=20
All Rights Reversed.

--=-xmBlxiMQ0RX+8gFzH+9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmILwEAACgkQznnekoTE
3oMtsAf/XQAcMuxVcOH1jkV3QUkXIetX7cd6gY7wiQ5Nw88ELC97QThAKEp/zTv5
RfVSqZmBLEaaW0oP81CrFinLrMk1IZZp8X8hkuK7V+086dGa1oxHoaF+k55yNpx9
6eIqlEiTloIgbTLVG6qKJhEZqgDCM0+fwBMVasVIAvfZ/scni5reBLJM2RZ3jVfl
xwBOvAIPZT+/8kxxQSuT+h2UDiATqZWdfGrGR/TuX86AxqVQEpNUovmufTST9tvd
yJpDju9ZHAbyB/tWquV+d5CBcXhQWqzw2aA3OH1te2nUz6M8azQA47gWZTBLzd80
ULrSoX/7Ez9S1U0VVYFIhivhGwbhmg==
=9B67
-----END PGP SIGNATURE-----

--=-xmBlxiMQ0RX+8gFzH+9g--
