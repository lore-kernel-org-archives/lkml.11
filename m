Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD0AC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Apr 2022 08:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbiDQIqa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Apr 2022 04:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiDQIqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 04:46:24 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D640722BDA
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 01:43:48 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ng0VJ-003jWG-6P; Sun, 17 Apr 2022 18:43:34 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sun, 17 Apr 2022 16:43:33 +0800
Date:   Sun, 17 Apr 2022 16:43:33 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YlvTNQGh+MfZFWKW@gondor.apana.org.au>
References: <YlVxGAHHD/j6lW3c@arm.com>
 <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com>
 <YlkV7NtatO7KFusX@gondor.apana.org.au>
 <CAMj1kXFW_zC-U5Ox9_=4gKCwWOmkR7wPNb6UQhiz8viNWTRU-w@mail.gmail.com>
 <YlkkGpVx8rhcsBot@gondor.apana.org.au>
 <YllALIgZcQJ6asdA@arm.com>
 <YlllpH+PB8XVUn6h@arm.com>
 <YlvLqkIdrCp/rOsG@gondor.apana.org.au>
 <YlvSEHul1Rv3Ap34@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlvSEHul1Rv3Ap34@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 09:38:40AM +0100, Catalin Marinas wrote:
> 
> I don't think we need to do anything here. A structure like:
> 
> struct x {
> 	char y;
> 	char z[] CRYPTO_MINALIGN_ATTR;
> };
> 
> is already of size 128. Without CRYPTO_MINALIGN_ATTR, its size would be
> 1 but otherwise the whole structure inherits the alignment of its
> member and this translates into an aligned size.

No we should not lie to the compiler, we have code elsewhere
that uses the alignment to compute the amount of extra padding
needed to create greater padding.  If CRYPTO_MINALIGN is misleading
then that calculation will fall apart.

So keep CRYPTO_MINALIGN at whatever alignment you lower kmalloc
to, and then add the padding you need to separate the Crypto API
bits from the context.  In fact, that is exactly what cra_alignmask
is supposed to do.

Sure we currently limit the maximum alignment to 64 bytes because
of stack usage but we can certainly look into increasing it as
that's what you're doing here anyway.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
