Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6BFC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Feb 2022 06:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbiBMG5O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Feb 2022 01:57:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiBMG5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 01:57:07 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5058E5DE66
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 22:57:02 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id C55A92013E1;
        Sun, 13 Feb 2022 06:56:59 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 358F880E7C; Sun, 13 Feb 2022 07:55:24 +0100 (CET)
Date:   Sun, 13 Feb 2022 07:55:24 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 2/3] random: check for crng_init == 0, not crng_ready()
 in add_device_randomness()
Message-ID: <YgirXH6dh4ENIXDb@owl.dominikbrodowski.net>
References: <20220212231022.679926-1-Jason@zx2c4.com>
 <20220212231022.679926-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212231022.679926-3-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, Feb 13, 2022 at 12:10:21AM +0100 schrieb Jason A. Donenfeld:
> This has no real functional change, as crng_pre_init_inject() (and
> before that, crng_slow_init()) always checks for == 0, not >= 2. So
> correct the outer unlocked change to reflect that.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
