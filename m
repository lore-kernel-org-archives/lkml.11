Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E72C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 00:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbiBIAMi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 19:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiBIAMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:12:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD08C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 16:12:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B551CB81DC6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4456EC340E9;
        Wed,  9 Feb 2022 00:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644365552;
        bh=+lDjDsNwf6SStxbDnlsNNYszqjSvaFHXVsK0CTEn5jM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ObVkpqnOCG7krKAQ+yK1gExmRdNib/p+9xDXs0WiNYk6CqvZk3f3PAh4DuHUD9F3Z
         sUiK9cHgYvk37aw59I4Gx53f4tZ0fiRoZmErc1X9Grzm3tvla9da+ICs+1Foa9semp
         GvPHEnnyYpVZA4bsUaKymh5p8L1Qnd7/lpClycR9MJUCLwOfTLUDocjYHmbpilXqWY
         uctNESjDg4UayBjV6SQMD2uvx0/EvoOb/3XpyBlgxNKUcrGBVA5bQW5wOxN3oWYVcs
         wf4s7Yn6oMa9ARRnx/HDiYSwcnKeSptlxjNURbQ3yu9c9anhRmE+OeYhTrU/M0bI6+
         2audxkvQCj2+g==
Date:   Tue, 8 Feb 2022 16:12:30 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH v3 2/2] random: defer fast pool mixing to worker
Message-ID: <YgMG7niyv2+zzSWf@sol.localdomain>
References: <20220207153914.365931-1-Jason@zx2c4.com>
 <20220207153914.365931-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207153914.365931-3-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 04:39:14PM +0100, Jason A. Donenfeld wrote:
> +static void mix_interrupt_randomness(struct work_struct *work)
> +{
> +	struct fast_pool *fast_pool = container_of(work, struct fast_pool, mix);
> +
> +	/*
> +	 * Since this is the result of a trip through the scheduler, xor in
> +	 * a cycle counter. It can't hurt, and might help.
> +	 */
> +	fast_pool->pool[3] ^= random_get_entropy();
> +
> +	mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
> +	/* We take care to zero out the count only after we're done reading the pool. */
> +	WRITE_ONCE(fast_pool->count, 0);
> +	fast_pool->last = jiffies;
> +	credit_entropy_bits(1);
> +}

So, add_interrupt_randomness() can execute on the same CPU re-entrantly at any
time this is executing?  That could result in some pretty weird behavior, where
the pool gets changed half-way through being used, so what is used is neither
the old nor the new state of the pool.  Is there a reason why this is okay?

>  void add_interrupt_randomness(int irq)
>  {
>  	struct fast_pool *fast_pool = this_cpu_ptr(&irq_randomness);
>  	struct pt_regs *regs = get_irq_regs();
>  	unsigned long now = jiffies;
>  	cycles_t cycles = random_get_entropy();
> +	unsigned int new_count;
>  	u32 c_high, j_high;
>  	u64 ip;
>  
> @@ -999,9 +1012,10 @@ void add_interrupt_randomness(int irq)
>  
>  	fast_mix(fast_pool);
>  	add_interrupt_bench(cycles);
> +	new_count = ++fast_pool->count;
>  
>  	if (unlikely(crng_init == 0)) {
> -		if ((fast_pool->count >= 64) &&
> +		if (new_count >= 64 &&
>  		    crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
>  			fast_pool->count = 0;
>  			fast_pool->last = now;
> @@ -1009,20 +1023,16 @@ void add_interrupt_randomness(int irq)
>  		return;
>  	}
>  
> -	if ((fast_pool->count < 64) && !time_after(now, fast_pool->last + HZ))
> +	if (new_count & FAST_POOL_MIX_INFLIGHT)
>  		return;
>  
> -	if (!spin_trylock(&input_pool.lock))
> +	if (new_count < 64 && !time_after(now, fast_pool->last + HZ))
>  		return;
>  
> -	fast_pool->last = now;
> -	__mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
> -	spin_unlock(&input_pool.lock);
> -
> -	fast_pool->count = 0;
> -
> -	/* award one bit for the contents of the fast pool */
> -	credit_entropy_bits(1);
> +	if (unlikely(!fast_pool->mix.func))
> +		INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
> +	fast_pool->count |= FAST_POOL_MIX_INFLIGHT;
> +	queue_work_on(raw_smp_processor_id(), system_highpri_wq, &fast_pool->mix);
>  }

Is there a reason why the FAST_POOL_MIX_INFLIGHT is part of 'count' instead of a
separate boolean?

Also, a high level question.  Now that the call to mix_pool_bytes() would no
longer occur in hard IRQ context, how much reason is there to minimize the
amount of data passed to it?  Would it be feasible to just concatenate the
interrupt data into an array, and pass the whole array to mix_pool_bytes() --
eliminating the homebrew ARX thing entirely?

- Eric
