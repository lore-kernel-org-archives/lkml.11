Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFBBC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Apr 2022 08:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiDQJBX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Apr 2022 05:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiDQJBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 05:01:19 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE63512A86
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 01:58:44 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ng0jk-003jh6-NN; Sun, 17 Apr 2022 18:58:30 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sun, 17 Apr 2022 16:58:29 +0800
Date:   Sun, 17 Apr 2022 16:58:29 +0800
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
Message-ID: <YlvWtc/dJ6luXzZf@gondor.apana.org.au>
References: <Ylko07++4naWJ5LE@gondor.apana.org.au>
 <CAMj1kXH=ybJWBzmMqkrkvyF8nM3UpTchUOq+oweW=BqW2TOyRw@mail.gmail.com>
 <YllE+wWqP6F+1nwa@gondor.apana.org.au>
 <CAMj1kXFjLbtpJLFh-C_k3Ydcg4M7NqrCfOXnBY2iSxusWtBLbA@mail.gmail.com>
 <YllM24eca/uxf9y7@gondor.apana.org.au>
 <CAMj1kXH5O32H1nnm6y7=3KiH7R-_oakxzBpZ20wK+8kaD46aKw@mail.gmail.com>
 <YlvK9iefUECy361O@gondor.apana.org.au>
 <YlvQTci7RP5evtTy@arm.com>
 <YlvRbvWSWMTtBJiN@gondor.apana.org.au>
 <YlvU6ou14okbAbgW@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlvU6ou14okbAbgW@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 09:50:50AM +0100, Catalin Marinas wrote:
>
> Right, if that's what you prefer. Something like:
> 
> diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> index 2324ab6f1846..bb645b2f2718 100644
> --- a/include/linux/crypto.h
> +++ b/include/linux/crypto.h
> @@ -645,7 +645,7 @@ struct crypto_tfm {
>  	
>  	struct crypto_alg *__crt_alg;
>  
> -	void *__crt_ctx[] CRYPTO_MINALIGN_ATTR;
> +	void *__crt_ctx[] __aligned(ARCH_DMA_MINALIGN);
>  };
> 
> But once we do that, are there any other CRYPTO_MINALIGN left around?

This is still implying the whole structure is aligned to the given
value, which it is not.

Please just add the padding as needed.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
