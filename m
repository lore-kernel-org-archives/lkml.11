Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239A3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 15:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350659AbiETPIe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 11:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350708AbiETPIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:08:24 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4A61796EC
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:08:10 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id v5so6837137qvs.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pEvlCe4V/em2drNfzpLbMhZO2cZ4QaTzSiWNKrAJWLg=;
        b=fDlsXLxHdjDEr3FdcNIarMitIOHtvIay9vzF9SWR5X9ssFh7o6sPmkRHtXZoa4xww7
         xB+6RTwOogVLrZIkB8uE3vyrYOgVGY1Ew0lYx3yBuQ0oTuuMuPOLyvPkxHHx38JGUuJA
         xb086y0rBJ5DDxKV7x7N07O7hyIpCvs5VviyrH0xWfmQP4ZPoeC+2lzSs/Js2JBhDj5p
         b7ExWgLH+yxnw4mRuEWjS9lveIbfd4/YBhvYrQjGmhm028lP8wZC0dcgEwUiO4iRqwcs
         wWn2Vwq5cS17fK9SdzcMxLp/UdvHHjxxkrUSm8pLqIivVIh+gwWShap91NnL88rM0qSv
         i+Cg==
X-Gm-Message-State: AOAM533wBehR7d5FA13qHTLxFoE7Apq93RF3lf/TkaVEKJ1i04PTlmnU
        ylTdxJ4fese2JrpEzSjfZEdMOWL0Lthhbw==
X-Google-Smtp-Source: ABdhPJwrO906sM0PqbDLCf0ueoWTP+6X5XV3BiGhLP+CWCghyy/JzqP45VWseq84RBxxt7n4AvlwYA==
X-Received: by 2002:ad4:5bab:0:b0:461:dcad:838e with SMTP id 11-20020ad45bab000000b00461dcad838emr7975830qvq.34.1653059289196;
        Fri, 20 May 2022 08:08:09 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id j4-20020a37b904000000b0069fc13ce225sm3052354qkf.86.2022.05.20.08.08.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 08:08:08 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2ff155c239bso90615077b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:08:08 -0700 (PDT)
X-Received: by 2002:a81:9b0c:0:b0:2f4:c522:7d3c with SMTP id
 s12-20020a819b0c000000b002f4c5227d3cmr10719893ywg.316.1653059288103; Fri, 20
 May 2022 08:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <c15bedc83d90a14fffcd5b1b6bfb32b8a80282c5.1653057096.git.geert@linux-m68k.org>
 <286a1eef-e857-a31f-839b-00a4c835dfa9@roeck-us.net>
In-Reply-To: <286a1eef-e857-a31f-839b-00a4c835dfa9@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 20 May 2022 17:07:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX3EYrGPPUEZ3_YPyr6zHnV-xEW3mYB_QyFYaqg_grF-w@mail.gmail.com>
Message-ID: <CAMuHMdX3EYrGPPUEZ3_YPyr6zHnV-xEW3mYB_QyFYaqg_grF-w@mail.gmail.com>
Subject: Re: [PATCH] m68k: atari: Make Atari ROM port I/O write macros return void
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Günter,

On Fri, May 20, 2022 at 4:52 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 5/20/22 07:32, Geert Uytterhoeven wrote:
> > The macros implementing Atari ROM port I/O writes do not cast away their
> > output, unlike similar implementations for other I/O buses.
> > When they are combined using conditional expressions in the definitions of
> > outb() and friends, this triggers sparse warnings like:
> >
> >      drivers/net/appletalk/cops.c:382:17: error: incompatible types in conditional expression (different base types):
> >      drivers/net/appletalk/cops.c:382:17:    unsigned char
> >      drivers/net/appletalk/cops.c:382:17:    void
> >
> > Fix this by adding casts to "void".
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks!

> > Removing the casts instead causes issues with functions propagating void
> > return values (return expression in void function), which BTW sparse
> > complains about, too.
>
> We live and learn. I didn't even know that this was valid syntax.

I knew about the syntax, but didn't realize immediately why it was
done that way.

Initially I thought it was some relic from the "always cast to void
to make it clear you do not care about the return value"-frenzy, which
are inside Linux visible mostly in the various "(void)acpi_<foo>(...);"
calls.  AFAIK these are checked by some external tools.
In Linux, we have __must_check to annotate the important cases.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
