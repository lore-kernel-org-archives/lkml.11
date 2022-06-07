Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EDCC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 11:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242675AbiFGLJq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 07:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242566AbiFGLJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:09:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D5B11047E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BA8761630
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC647C385A5;
        Tue,  7 Jun 2022 11:04:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RmRcAWBG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654599893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pLbg+TRUH6aNHSqlpwLrYjAG/GDDxPAkzL7dlKJUm+U=;
        b=RmRcAWBGSH3K7FBjd1mGn0C2bl3pEIa7D0gY/o4J5ba4EU5YNnMsZxUrFHa52s3NBus7Ab
        U++HjufPsObfnIwyDc93cfeD8zM/fqf35gCyMcwkgtsHCWRsFE8bWN0FpyRnzjW8EYTRe2
        cSDW0F1IbcriTJy1zN8muYL773odWXE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6df8dc51 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 7 Jun 2022 11:04:52 +0000 (UTC)
Date:   Tue, 7 Jun 2022 13:04:47 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH] random: do not use jump labels before they are
 initialized
Message-ID: <Yp8wz2Ey4J4u+ZlK@zx2c4.com>
References: <20220607100210.683136-1-Jason@zx2c4.com>
 <CAMj1kXEAuh-tokcqvKCQF5Vq+jZKj4ZM=PyGaHKapXPJKVyOrg@mail.gmail.com>
 <Yp8oOH+9V336LrLk@zx2c4.com>
 <Yp8rcFrqK/IkzKXj@zx2c4.com>
 <CAMj1kXHV833uMJYrdUagJpH5hoj4ivC6zxMJvNnxLAF2NG3_sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHV833uMJYrdUagJpH5hoj4ivC6zxMJvNnxLAF2NG3_sg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Tue, Jun 07, 2022 at 12:56:20PM +0200, Ard Biesheuvel wrote:
> Could we do this to defer the static key manipulation? That way, the
> first call to crng_reseed() that occurs after the static keys API
> becomes available will set the static key, and patch itself away at
> the same time.

That's almost the same as the patch I just posted, except you
pushed the logic down into crng_reseed() instead of credit_init_bits().
(A previous mini-project aimed to remove as much logic as possible from
crng_reseed(), counting on those blocks in crng_init_bits() to only ever
run once.) What this means is that the static key won't get changed
until whenever the next reseeding is. I guess that's "fine" but I think
I'd prefer to keep the entropy counting stuff as separate from the init
bits stuff as possible.

>> As a third, I could just defer doing anything with the bootloader seed
>> until random_init(). This might actually be the simplest solution...
>> I'll sketch something out. A downside, which might be sort of
>> significant, is that a few odd things actually use randomness before
>> random_init() is called. So these would miss out on having that seed.
>> I'll have to look what exactly to see if we're actually getting anything
>> real out of that.
>>
>
> This is kind of the point of using a firmware provided seed, i.e.,
> that it is available much earlier than anything else.

I'll send a patch for this anyway because I'm sort of curious now. Maybe
it'll be a dead end, for the reason you mentioned, but I think I'll
still try to evaluate it.

Jason
