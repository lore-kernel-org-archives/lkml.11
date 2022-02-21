Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F093C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 03:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244329AbiBUD71 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Feb 2022 22:59:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242228AbiBUD7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:59:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4271451E74
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 19:59:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE2B361182
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 03:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E92DC340E9;
        Mon, 21 Feb 2022 03:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645415942;
        bh=aRT/691y4eTSJty4rbXCqFn+rNoVrr99ADul83Y+DFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7Bk5uLcqlRzn5JkiU0UjHLifVjm5FMxJl6YGM9XXbw4nUmNtsNLeVZBpNccN2IJ0
         zMpu9qks2IEJnk4AKtKTaffxBaNu9E556zMGPUkE+H6Nurp486sA7NcogeyboGxg3b
         Z1N9SGT5Y/OvKVoBJVwhEqvLgwJjhWGgLUEQU4qKIuTIE39iwEXgaTEvsZeJr6Bef/
         5cA4LDeOoRR0h52ApiFzFKMKOzsaB2vF9KM30m+t2d2p3I3QIqCVNu8C0wy6fw92oF
         WY+cLHOInRvPpKMk0+Uo+4Ks61nTeb3bLaNQIAYbL+d0cHIVIjLT03NJWxlYQtylrf
         0Fm/QPoOiWBvg==
Date:   Sun, 20 Feb 2022 19:59:00 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] random: zero buffer after reading secret entropy from
 userspace
Message-ID: <YhMOBAKe5bAlvVyb@sol.localdomain>
References: <20220209174456.644232-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209174456.644232-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 06:44:56PM +0100, Jason A. Donenfeld wrote:
> This buffer may contain entropic data that shouldn't stick around longer
> than needed, zero it out our temporary buffer at the end of
> write_pool().
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
>  drivers/char/random.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
