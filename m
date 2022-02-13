Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE73C433FE
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Feb 2022 06:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiBMG5Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Feb 2022 01:57:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiBMG5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 01:57:07 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0625DE65
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 22:57:02 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id C7BA42013FE;
        Sun, 13 Feb 2022 06:56:59 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 366FB80A2B; Sun, 13 Feb 2022 07:55:20 +0100 (CET)
Date:   Sun, 13 Feb 2022 07:55:20 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 1/3] random: unify early init crng load accounting
Message-ID: <YgirWF8p24lW7+gp@owl.dominikbrodowski.net>
References: <20220212231022.679926-1-Jason@zx2c4.com>
 <20220212231022.679926-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212231022.679926-2-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, Feb 13, 2022 at 12:10:20AM +0100 schrieb Jason A. Donenfeld:
> crng_fast_load() and crng_slow_load() have different semantics:
> 
> - crng_fast_load() xors and accounts with crng_init_cnt.
> - crng_slow_load() hashes and doesn't account.
> 
> However add_hwgenerator_randomness() can afford to hash (it's called
> from a kthread), and it should account. Additionally, ones that can
> afford to hash don't need to take a trylock but can take a normal lock.
> So, we combine these into one function, crng_pre_init_inject(), which
> allows us to control these in a uniform way. This will make it simpler
> later to simplify this all down when the time comes for that.

I thought the call to crng_fast_load() from add_input_randomness() is on its
way out?

Otherwise, patch looks fine:

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
