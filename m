Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8B2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 21:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242008AbiBGVpk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 16:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiBGVph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:45:37 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B072C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:45:37 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id f6so1237343vsa.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lwNho10NSvUvgMsTPwNeOvofrX+IJ611XZs8ySHA1Wo=;
        b=LBxgTV4F2iQiPXVDRq7ADCCqouUP5XvK/lIQIaGw5372xy8vdbEcd+Gq6sFDu0BG6O
         UFcbCoKIC7XrpnRPmARzCDBxwChhmZeI5rXTetBg+pQ05Y1V0p8FTWyoqKjDKkBEZEH0
         5G/FZKRu95PXGzfQ4cG0meMf6H28mqTJD6Kx3lMFdADSzmmeN2ltFfBh3lDZWYTN+60e
         SrmL4lSgOKwF+LTQpdBwS43THXBpf0MzSuwQst7EK+h/SZGXe0QiTURnhwRrqUvUlQdj
         9Z/yJ0awQtytvQmDPUiGMa0hLRbNiSO1Lgtw+GTEG22XjfKxcuBel1fEEcFgO4M/0uA3
         M9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lwNho10NSvUvgMsTPwNeOvofrX+IJ611XZs8ySHA1Wo=;
        b=HjQpr9CtdGicJVQLypcr+oRfdNvQvOCjN5ipEPxQmuflg5r5q+oc03HiWtzxdLizx9
         w3RI/UvvV/ZYWZVfGnOHuOayclRCwFuxeCK+om6f2WELoeYd1/JPNCdgokBEJesWBirq
         3UFJUt+YiLwx/2zTha0maKI9TwnoIWTQ6JmrES+8AOOjuvDUapsVE0ZsdXyr4mnbJ60T
         uouFk5fntguXJFwEpyo8Hd7oHndsGNLdut67jyInHPHNkoPyxPfxBR4q+ZYpAQNd/8Q4
         IQTmJGFqE7UiGITffREyTgEcHM75NJ2pmBYhJdvw9zOvbtNd/HVR6w6Ho/sY+FVxve6s
         oZ+Q==
X-Gm-Message-State: AOAM5330+oo1oqhXZaoGgil4prW3HrfOz80iGDAvfm5aKEArPiMydUGx
        onID8rqfMqzn/Li9EbZYGicd0eMJCpU1Xkn5NCftDpfLoJY=
X-Google-Smtp-Source: ABdhPJzYW/EIs2vsiLv6XBj1/e2fLqmZlg4vGTJLvmNDMj7EsaPmA8ipg6pHpSj9xMvVzVnjGu+fnTaNDOvDennPOS0=
X-Received: by 2002:a67:e08d:: with SMTP id f13mr603569vsl.78.1644270336041;
 Mon, 07 Feb 2022 13:45:36 -0800 (PST)
MIME-Version: 1.0
References: <e10b79cf-d6d5-ffcc-bce4-edd92b7cb6b9@molgen.mpg.de> <CAHmME9pktmNpcBS_DJhJ5Z+6xO9P1wroQ9_gwx8KZMBxk1FBeQ@mail.gmail.com>
In-Reply-To: <CAHmME9pktmNpcBS_DJhJ5Z+6xO9P1wroQ9_gwx8KZMBxk1FBeQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 7 Feb 2022 22:45:09 +0100
Message-ID: <CAG48ez2P9-CAdgRizcp5T_uuoXRAt0xtodh1doiMW0fKZVX-7g@mail.gmail.com>
Subject: Re: BUG: KCSAN: data-race in add_device_randomness+0x20d/0x290
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     pmenzel@molgen.mpg.de, "Theodore Y. Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 7:42 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Thanks for the report. I assume that this is actually an old bug. Do
> you have a vmlinux or a random.o from this kernel you could send me to
> double check? Without that, my best guess, which I'd say I have
> relatively high confidence about, is that the "1 byte read" is
> actually a `movzx eax, cs:lfsr` referring to the `static u8 lfsr`
> here, which gets inlined into add_device_randomness:
>
> static int crng_slow_load(const u8 *cp, size_t len)
> {
>     unsigned long flags;
>     static u8 lfsr = 1;
>
> This was added in 2008 with dc12baacb95f ("random: use a different
> mixing algorithm for add_device_randomness()"). My understanding is
> that the race here isn't super problematic as we're in kind of a half
> assed "low effort" phase anyway. But I'll give it some thought. I'm
> CCing Jann as well who reported the original issue that motivated that
> change.

But the "lfsr" variable is never accessed outside the part of this
method that holds a global spinlock. So that can't really be it,
right?
