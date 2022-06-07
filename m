Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA92C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 14:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbiFGOsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 10:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343535AbiFGOsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:48:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B528BCE86
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC8A9B8206D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D266C385A5;
        Tue,  7 Jun 2022 14:48:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RtzR44g4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654613298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z70E+/bePHMZXWFc5IMl07eyedk5gGD4ksSfdTvg+YM=;
        b=RtzR44g4nGZGdcERgigfe7dVpjd9fjVB8qtu3KRIR6eM/fXYSfSaYMXyfue0xJIk6qKmjQ
        tJTWUPoMGZTxdDtQ4T0h0kpJEqLpauFvlpOrOrSmsT/Pt+tCzympbY9UloKBrY683+NTyh
        Bv4BocTWarxLmW8GTxSkosMdaFZ5FwY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ebcf4317 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 7 Jun 2022 14:48:17 +0000 (UTC)
Date:   Tue, 7 Jun 2022 16:48:14 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH] random: defer use of bootloader randomness to
 random_init()
Message-ID: <Yp9lLkYXCo9BZxpk@zx2c4.com>
References: <20220607111514.755009-1-Jason@zx2c4.com>
 <CAMj1kXFDYX3fAdO6hxH9DTFP7+LNYz0fL9Dy8eKsH_xGwXxatQ@mail.gmail.com>
 <Yp8+6Y+bEcmR1LS0@zx2c4.com>
 <CAMj1kXFPxP3y6Ma1AonMSiW5DP0veB+NAj+ggfvrWvAARsOmgA@mail.gmail.com>
 <Yp9C4xY0+CguTd7l@zx2c4.com>
 <CAMj1kXH4ifsytLNpaVTHAumadMjj8rNEZbsn-8t=hH51ucG11A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXH4ifsytLNpaVTHAumadMjj8rNEZbsn-8t=hH51ucG11A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Tue, Jun 07, 2022 at 04:19:26PM +0200, Ard Biesheuvel wrote:
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/random.h>
> 
> static unsigned char buf[16];
> 
> int main(void)
> {
>   for (int i = 0; i < 1000000; i++) {
>     if (getrandom(buf, sizeof(buf),
>         GRND_RANDOM | GRND_NONBLOCK) < sizeof(buf)) {
>           fprintf(stderr, "getrandom() error!\n");
>           exit(-1);
>     }
>   }
>   return 0;
> }

I'm actually more worried about the random input flow than the random
output flow and branch misprediction. But more generally, I'd just like
to keep that code as cold as possible after crng init. It's code that's
only used in that one phase and then never again. It can be entirely
disabled.

Anyway, we've got a few solutions now to pick from on the random.c side
of things. I'm going to investigate the arm32 situation next. And then
we'll see what it all looks like.

Jason
