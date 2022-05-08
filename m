Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B9BC43217
	for <linux-kernel@archiver.kernel.org>; Sun,  8 May 2022 12:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiEHNCL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 May 2022 09:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiEHNBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 09:01:11 -0400
Received: from relay3.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA727E000
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 05:57:20 -0700 (PDT)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id DDFFA1209C5;
        Sun,  8 May 2022 12:57:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 124CA1B;
        Sun,  8 May 2022 12:57:18 +0000 (UTC)
Message-ID: <d0b220993b2fb1d306bb959707ceb374596de559.camel@perches.com>
Subject: Re: [PATCH] random: use symbolic constants for crng_init states
From:   Joe Perches <joe@perches.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>
Date:   Sun, 08 May 2022 05:57:18 -0700
In-Reply-To: <20220508112609.138889-1-Jason@zx2c4.com>
References: <20220508112609.138889-1-Jason@zx2c4.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 124CA1B
X-Stat-Signature: uqug9g81j776quzgfa9g5fpmenixazgk
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19gEG4H1+pqISvFAw5X/GjL8BEUfwnxsTo=
X-HE-Tag: 1652014638-133398
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-05-08 at 13:26 +0200, Jason A. Donenfeld wrote:
> crng_init represents a state machine, with three states, and various
> rules for transitions. For the longest time, we've been managing these
> with "0", "1", and "2", and expecting people to figure it out. To make
> the code more obvious, replace these with proper enum values
> representing the transition, and then redocument what each of these
> states mean.

good idea

> diff --git a/drivers/char/random.c b/drivers/char/random.c
[]
> @@ -72,16 +72,16 @@
[]
> -/* Various types of waiters for crng_init->2 transition. */
> +static enum {
> +	CRNG_EMPTY = 0, /* Little to no entropy collected */
> +	CRNG_EARLY = 1, /* At least POOL_EARLY_BITS collected */
> +	CRNG_READY = 2  /* Fully iniitalized with POOL_READY_BITS collected */

typo: initialized

>  enum {
>  	POOL_BITS = BLAKE2S_HASH_SIZE * 8,
> -	POOL_INIT_BITS = POOL_BITS, /* No point in settling for less. */
> -	POOL_FAST_INIT_BITS = POOL_INIT_BITS / 2
> +	POOL_READY_BITS = POOL_BITS, /* When crng_init->CRNG_READY */
> +	POOL_EARLY_BITS = POOL_READY_BITS / 2 /* When crng_init->CRNG_EARLY */

Seems odd to use a divisor with an enum


