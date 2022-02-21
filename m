Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B26C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 04:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbiBUEfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Feb 2022 23:35:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343853AbiBUEfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 23:35:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2674540E4E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:35:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B70AD6113B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DA9C340E9;
        Mon, 21 Feb 2022 04:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645418125;
        bh=dwZtDGQQX9fM6lCbHqZPpjk93gPQ/Aq82vtGnV09KjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EZZ/fQexQxELEi7dWIaqQD+WlOZqyXY87H1NScG6tTC7dWsBFGEKznrH8NbM/LGmX
         Z6dzDBoXc0FLu53oP4xmhTTCtP9ZoV9BXfz5wwz+11KXpmhTcnrHuxRNkGn3GxlATQ
         sE+w6RsmvNGWcb51e1BFsU0kxR7b9a7uvd3KPohA5do+SdTCHwroxmwYANyF5yMes9
         hRHwR3ObAHjI7kK2BHjv7P2UuB3duavfdp9pXVqcImbLYIGIV4U2dbZxNbbazljnZU
         fAtK/F4fYXsRxcqMx0MHr1xt5S6lIYuelQ+Bu0AlLisgrZYUEWkCH47otDhp5BanRC
         1593qMcFjMiig==
Date:   Sun, 20 Feb 2022 20:35:23 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Subject: Re: [PATCH v2 03/10] random: remove whitespace and reorder includes
Message-ID: <YhMWi+zuIH9XPvmS@sol.localdomain>
References: <20220212122318.623435-1-Jason@zx2c4.com>
 <20220212122318.623435-4-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212122318.623435-4-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 01:23:11PM +0100, Jason A. Donenfeld wrote:
> This is purely cosmetic. Future work involves figuring out which of
> these headers we need and which we don't.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 436b146b33be..7bb18422705a 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -193,11 +193,10 @@
>  #include <linux/syscalls.h>
>  #include <linux/completion.h>
>  #include <linux/uuid.h>
> +#include <linux/uaccess.h>
>  #include <crypto/chacha.h>
>  #include <crypto/blake2s.h>
> -
>  #include <asm/processor.h>
> -#include <linux/uaccess.h>
>  #include <asm/irq.h>
>  #include <asm/irq_regs.h>
>  #include <asm/io.h>
> -- 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
