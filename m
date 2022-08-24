Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0C8C00140
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Aug 2022 05:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbiHXFQV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 01:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiHXFQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:16:18 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682EA7644D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 22:16:16 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 913A860697;
        Wed, 24 Aug 2022 07:16:14 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH -next] mm: pagewalk: Restore err initialization in walk_hugetlb_range()
Date:   Wed, 24 Aug 2022 07:16:11 +0200
Message-ID: <3830122.BTrY59CkKH@mobilepool36.emlix.com>
In-Reply-To: <20220823153055.2517764-1-nathan@kernel.org>
References: <20220823153055.2517764-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1700889.S5NpyQqGGO"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1700889.S5NpyQqGGO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
Date: Wed, 24 Aug 2022 07:16:11 +0200
Message-ID: <3830122.BTrY59CkKH@mobilepool36.emlix.com>
In-Reply-To: <20220823153055.2517764-1-nathan@kernel.org>
References: <20220823153055.2517764-1-nathan@kernel.org>
MIME-Version: 1.0

Am Dienstag, 23. August 2022, 17:30:56 CEST schrieb Nathan Chancellor:

> Restore the initialization of err to zero so that it cannot be used
> uninitialized.

There are actually 3 places that need fixing. I'll send a patch in a minute.

Eike
--nextPart1700889.S5NpyQqGGO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYwW0GwAKCRCr5FH7Xu2t
/PA1A/9g/6sS6lDuyk38tf1/eHYl+I53B+DD3z2sWtdm1dXVvg7zDye2aW4AXtaE
4IpyTOHFQdMtpQ1Vj9wSNdh6F4dcwduma8KBaDM7ZWg9PJD6MrTfaYn1wsdtqiiW
JQeCpb5maLzf2vnF3ZHOCLLxb6AU5LLwd+qhg1wYYosoNKEhfg==
=YTMg
-----END PGP SIGNATURE-----

--nextPart1700889.S5NpyQqGGO--



