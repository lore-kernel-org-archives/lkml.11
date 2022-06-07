Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7057C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 12:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243774AbiFGMXQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 08:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243651AbiFGMWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:22:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A974F68B2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:22:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CFD7B81F85
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B523C385A5;
        Tue,  7 Jun 2022 12:22:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LBBel72C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654604519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5crPd/ksoB52wnt1QWnc0dRKkI8RoZ5ZCdKpuIJg3ns=;
        b=LBBel72CvuhkFnWKdIouYW94bXyc4OQ34mJt3NIdCV7Ggss6zMaiAvpXMo5HU/Fawg2HBB
        eQRaFqY7GWFU17DDQPRKenLte7GvvA0+N28RnIfRWINj8ASy9p/ADZtWj04TfW7KHPnQ5K
        NEOU4vJoMEuF9Jm5759dY9IlZk0O38E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 453d7396 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 7 Jun 2022 12:21:58 +0000 (UTC)
Date:   Tue, 7 Jun 2022 14:21:55 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH] random: defer use of bootloader randomness to
 random_init()
Message-ID: <Yp9C4xY0+CguTd7l@zx2c4.com>
References: <20220607111514.755009-1-Jason@zx2c4.com>
 <CAMj1kXFDYX3fAdO6hxH9DTFP7+LNYz0fL9Dy8eKsH_xGwXxatQ@mail.gmail.com>
 <Yp8+6Y+bEcmR1LS0@zx2c4.com>
 <CAMj1kXFPxP3y6Ma1AonMSiW5DP0veB+NAj+ggfvrWvAARsOmgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFPxP3y6Ma1AonMSiW5DP0veB+NAj+ggfvrWvAARsOmgA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Tue, Jun 07, 2022 at 02:15:27PM +0200, Ard Biesheuvel wrote:
> Note that jump labels use asm() blocks, which are opaque to the
> compiler, and so it is not guaranteed that codegen will be better than

I actually spent a lot of time looking at the codegen on a few
platforms.

> > > - Why do we need to enable this static key so early?
> >
> > We don't need to enable it especially early. I've now sent three
> > different approaches for deferring it until later and you suggested one.
> > The first of mine is kind of ugly (checking static_key_initialized and
> > such at different points).  Your suggested one after that did the same
> > but deferred into crng_reseed(), which I'm not a fan of. My second one
> > is this patch, which is flawed for the reason you pointed out. But
> > perhaps my third one is the right amount of simple and okay? That's the
> > one I linked up top, [1]. Let me know what you think of that.
> >
> > My motivation for not wanting to defer it is that if the arch solution
> > winds up being easy and straight forward (as it was for arm64), then it
> > would be nice to not need to clutter up random.c as a result.
> 
> If clutter is a concern, how about getting rid of the
> execute_in_process_context() dance, and just use a late_initcall()
> instead?

As I already explained in [1], this does not work. If the order is
(A)(B), then all this will happen *after* the late init call.

[1] https://lore.kernel.org/lkml/Yp8oOH+9V336LrLk@zx2c4.com/

Jason
