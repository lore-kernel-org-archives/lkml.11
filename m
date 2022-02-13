Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE83CC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Feb 2022 06:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiBMG5L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Feb 2022 01:57:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbiBMG5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 01:57:07 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276985DE4C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 22:57:02 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id BEA4820135E;
        Sun, 13 Feb 2022 06:56:59 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id C625F8087D; Sun, 13 Feb 2022 07:54:37 +0100 (CET)
Date:   Sun, 13 Feb 2022 07:54:37 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 05/10] random: group crng functions
Message-ID: <YgirLX70xHFXTMDf@owl.dominikbrodowski.net>
References: <20220212122318.623435-1-Jason@zx2c4.com>
 <20220212122318.623435-6-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212122318.623435-6-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -724,54 +563,433 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
>  	local_unlock_irqrestore(&crngs.lock, flags);
>  }
>  
> -static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
> +/*
> + * This function is for crng_init < 2 only.

No, it's for crng_init == 0 only.

> +/*
> + * This function is for crng_init < 2 only.

Same here.

> + * Batched entropy returns random integers. The quality of the random
> + * number is good as /dev/urandom. In order to ensure that the randomness

/dev/random

> +size_t __must_check get_random_bytes_arch(void *buf, size_t nbytes)

Sidenote: We should get rid of the sole caller of that function, and then of
this function. AFAICS, using get_random_bytes() (once rand_initialize() has
been called) should never be less secure than get_random_bytes_arch() IFF
arch_get_random_long() exists -- which is what the sole caller seems to be
interested in.

Otherwise, all looks good. Thanks,

	Dominik
