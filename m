Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87708C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 05:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344552AbiBUFfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 00:35:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344545AbiBUFfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:35:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E33E4AE1A
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 21:34:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39807611EE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D624C340E9;
        Mon, 21 Feb 2022 05:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645421697;
        bh=VBlEvlHOLGTDybZZzMukE+NhuuRSv6OX0PR8ydFljic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJ6WZmhiUMixrg2XcvhdSFs5piFazAVog70zlNWSvSPA9nuHByxBevdFvAmztuie/
         TXXQOZRDcrFUcuPJvrubIeENCGtia1vlIjITwXF7/m5dClrhxnq0fKbFvCD1VIuZ6o
         5MlgH2kbYOvHrk9Uuvp6Sf1kb+osVQVCORugiEw8VfDWSu+NGulepuqmUeKWrufxAs
         LtOEsyLnNP2vUnQ3RMYnYnZzzSHs8IC/lxYD7CAR9R0La8T88iVOyaIqtwtmjXXDPU
         dNy7RIH9CtwuIj9Z/sGPCBx/2QqZB1xjWKyaezU06/xafclUKyRvfnIHBC/GEFpwny
         t4M/un8LwrJ7A==
Date:   Sun, 20 Feb 2022 21:34:56 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux@dominikbrodowski.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: do not take pool spinlock at boot
Message-ID: <YhMkgL3h6puTZX20@sol.localdomain>
References: <20220212002859.622233-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212002859.622233-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 01:28:59AM +0100, Jason A. Donenfeld wrote:
> Since rand_initialize() is run while interrupts are still off and
> nothing else is running, we don't need to repeatedly take and release
> the pool spinlock, especially in the RDSEED loop.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Dominik - I'm still a bit unclear about early boot semantics that you
> seem to know well. Is this patch correct?
> 
>  drivers/char/random.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index d4b692c9de68..8088348190e6 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -966,10 +966,10 @@ int __init rand_initialize(void)
>  			rv = random_get_entropy();
>  			arch_init = false;
>  		}
> -		mix_pool_bytes(&rv, sizeof(rv));
> +		_mix_pool_bytes(&rv, sizeof(rv));
>  	}
> -	mix_pool_bytes(&now, sizeof(now));
> -	mix_pool_bytes(utsname(), sizeof(*(utsname())));
> +	_mix_pool_bytes(&now, sizeof(now));
> +	_mix_pool_bytes(utsname(), sizeof(*(utsname())));
>  
>  	extract_entropy(base_crng.key, sizeof(base_crng.key));
>  	++base_crng.generation;
> -- 
> 2.35.0

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
