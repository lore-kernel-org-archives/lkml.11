Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9D4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 06:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349102AbiDOGRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 02:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350220AbiDOGRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:17:40 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B90751308
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:15:12 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 8F9F420140E;
        Fri, 15 Apr 2022 06:15:08 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 729918045D; Fri, 15 Apr 2022 08:14:35 +0200 (CEST)
Date:   Fri, 15 Apr 2022 08:14:35 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: use memmove instead of memcpy for remaining 32
 bytes
Message-ID: <YlkNS8I9NFPfJCUs@owl.dominikbrodowski.net>
References: <20220413235649.97640-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413235649.97640-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, Apr 14, 2022 at 01:56:49AM +0200 schrieb Jason A. Donenfeld:
> In order to immediately overwrite the old key on the stack, before
> servicing a userspace request for bytes, we use the remaining 32 bytes
> of block 0 as the key. This means moving indices 8,9,a,b,c,d,e,f ->
> 4,5,6,7,8,9,a,b. Since 4 < 8, for the kernel implementations of
> memcpy(), this doesn't actually appear to be a problem in practice. But
> relying on that characteristic seems a bit brittle. So let's change that
> to a proper memmove(), which is the by-the-books way of handling
> overlapping memory copies.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
