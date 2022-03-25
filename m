Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793AAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 02:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348240AbiCYC4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 22:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346322AbiCYC4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:56:38 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825935373A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 19:55:05 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 22P2spT7012786
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 11:54:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 22P2spT7012786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648176892;
        bh=A2XAHS4w/c6OQnt3DiSdCXWg3b9aQRGqC1QA2pCAfcs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hPAxNkdsEK0j8nwHp5LgeC2S5Yj2cgvSvGrKUgWA13KHHBq3IglTmMv/XlT7oQE5U
         GyqOeLzCh+yU5AY6ochaPey8ARdcRz+B6/fjHmB2edmn0caEFmjyNO2uUoKeQn1JVz
         lEBePINEBGv/qwVuqAbSxqqI+oJdYYlsgG2vAXXweDKn/10kf58Xm+LyWJu7fzO+J2
         fVsEjQ5XcoBJJxBpN5rdI8S0vuL6AVSXpXHO/dRQHHAuv42vo3fa3G2QA14mz8PDCx
         pU/BfUQO2tzLUC4bUsKfieKs78Vf6sxusSXetAHxQEL4KsVFbWH+VfMkxwn+a+Vyng
         S566oqU0PJyWw==
X-Nifty-SrcIP: [209.85.214.181]
Received: by mail-pl1-f181.google.com with SMTP id j13so6726076plj.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 19:54:52 -0700 (PDT)
X-Gm-Message-State: AOAM531qrtpZhP8zT+PuXQni6E4JaAIJ2bWlfg0I66HbjD+7/HpM7GOH
        CP/Ooqi92210RuNDP2rqRCy+Zs71g8TEKkXLLvw=
X-Google-Smtp-Source: ABdhPJwceGcbdDHQWPNmV+hGiutHuGC1xFIxZoJerSDlExap4Xfb5ImNfr+p+109ljjyIFHGu3WNIbEv8TKrFecB/10=
X-Received: by 2002:a17:90a:1108:b0:1be:e1bd:e2f0 with SMTP id
 d8-20020a17090a110800b001bee1bde2f0mr9963550pja.144.1648176891365; Thu, 24
 Mar 2022 19:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211030175258.1716178-1-masahiroy@kernel.org>
 <Yis7Z90qvPz+EcTk@shell.armlinux.org.uk> <CAK7LNAT4k=Cseox6jEunLxU+w=VTQ08c9gdmt6=K2vvvSL49bg@mail.gmail.com>
In-Reply-To: <CAK7LNAT4k=Cseox6jEunLxU+w=VTQ08c9gdmt6=K2vvvSL49bg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 25 Mar 2022 11:54:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNARgJ7GapsRNPyG18rs-uxnXuMrQRVP=y2dKLLNRjU8tbA@mail.gmail.com>
Message-ID: <CAK7LNARgJ7GapsRNPyG18rs-uxnXuMrQRVP=y2dKLLNRjU8tbA@mail.gmail.com>
Subject: Re: [PATCH] ARM: decompressor: do not copy source files while building
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     patches@arm.linux.org.uk,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,


Was this issue fixed?
(I see nothing happened in linux-next yet)

I will not send a patch because I assume you will
fix this by yourself. If there is something you want
me, please let me know.

Thanks.
Masahiro Yamada






On Mon, Mar 14, 2022 at 1:35 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Mar 11, 2022 at 9:07 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Sun, Oct 31, 2021 at 02:52:58AM +0900, Masahiro Yamada wrote:
> > > As commit 7ae4a78daacf ("ARM: 8969/1: decompressor: simplify libfdt
> > > builds") stated, copying source files during the build time may not
> > > end up with as clean code as expected.
> > >
> > > Do similar for the other library files for further cleanups of the
> > > Makefile and .gitignore.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >
> > Hi,
> >
> > I am now seeing the following every time I run a build:
> >
> >   GEN     Makefile
> >   CALL    .../linux-rmk/scripts/atomic/check-atomics.sh
> >   CALL    .../linux-rmk/scripts/checksyscalls.sh
> >   CHK     include/generated/compile.h
> >   Kernel: arch/arm/boot/Image is ready
> >   AS      arch/arm/boot/compressed/lib1funcs.o
> >   AS      arch/arm/boot/compressed/ashldi3.o
> >   AS      arch/arm/boot/compressed/bswapsdi2.o
> >   LD      arch/arm/boot/compressed/vmlinux
> >   OBJCOPY arch/arm/boot/zImage
> >   Kernel: arch/arm/boot/zImage is ready
> >
> > In other words, those three objects are always rebuilt even though
> > they haven't changed.
> >
> > I've tried removing the arch/arm/boot/compressed directory in the
> > build tree, but that doesn't make any difference.
> >
> > Running with V=2 shows:
> >
> >   AS      arch/arm/boot/compressed/lib1funcs.o - due to lib1funcs.o not in $(tar
> > gets)
> >   AS      arch/arm/boot/compressed/ashldi3.o - due to ashldi3.o not in $(targets)
> >   AS      arch/arm/boot/compressed/bswapsdi2.o - due to bswapsdi2.o not in $(targets)
> >
> > It looks to me like:
> > OBJS    += lib1funcs.o ashldi3.o bswapsdi2.o
> >
> > in your patch should have been added before:
> >
> > targets       := vmlinux vmlinux.lds piggy_data piggy.o \
> >                  head.o $(OBJS)
> >
> > Please confirm.
>
>
> Sorry for my late reply.
>
> Yes, you are right.
>
> OBJS    += lib1funcs.o ashldi3.o bswapsdi2.o
>
> should come before the 'targets' assignment.
>
>
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
