Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13B1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 16:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348776AbiC3QYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 12:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346416AbiC3QYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:24:21 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C492ABF61
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hvxDLidc/BvcilqIXkY+wQXhU96uSD+vF+LR3M1O2fM=; b=z89yXMmVTiEciHwphPDg3LH+YO
        HqnyQHc24QwDAx9/2+e+aIVoLiEIisljXAXKgrvXMhAdHYz60p7Z8FzlDlJDhcd8HfeDxzxQwqj8v
        KMgyhrom5PXVFJ54nSlyEXBFr2ntnRJFkNB72/EMizmXJ87MhP3XGgr3I7IH70H32lDw38ibOHcxC
        IKPYvuA1KorX8Ot1uAnE739/2wNMm0jo+q5ffCnUzrTG6hrUVbvsu5coUsWhWH61Oe6eHUDE20ggh
        GYfrGVxgabiK67T3uHT7zvLbn1Zl1UNppRaRRNn+V9AZU+9ZmPoBOIzQuBu/mJRzq39ycLxgrslWb
        D9rmDQuQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58018)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nZb5e-0003Rl-Kh; Wed, 30 Mar 2022 17:22:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nZb5d-0006l5-MF; Wed, 30 Mar 2022 17:22:33 +0100
Date:   Wed, 30 Mar 2022 17:22:33 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     patches@arm.linux.org.uk,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: decompressor: do not copy source files while
 building
Message-ID: <YkSDyRoFgSx3HY8X@shell.armlinux.org.uk>
References: <20211030175258.1716178-1-masahiroy@kernel.org>
 <Yis7Z90qvPz+EcTk@shell.armlinux.org.uk>
 <CAK7LNAT4k=Cseox6jEunLxU+w=VTQ08c9gdmt6=K2vvvSL49bg@mail.gmail.com>
 <CAK7LNARgJ7GapsRNPyG18rs-uxnXuMrQRVP=y2dKLLNRjU8tbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARgJ7GapsRNPyG18rs-uxnXuMrQRVP=y2dKLLNRjU8tbA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Your reply was too late for me, I've been away on vacation from 14th
March until now... and now I've got a whole truck-load of catch-up, so
it's likely I'll forget to sort this. Please send a patch to fix it,
thanks.

On Fri, Mar 25, 2022 at 11:54:07AM +0900, Masahiro Yamada wrote:
> Hi Russell,
> 
> 
> Was this issue fixed?
> (I see nothing happened in linux-next yet)
> 
> I will not send a patch because I assume you will
> fix this by yourself. If there is something you want
> me, please let me know.
> 
> Thanks.
> Masahiro Yamada
> 
> 
> 
> 
> 
> 
> On Mon, Mar 14, 2022 at 1:35 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Fri, Mar 11, 2022 at 9:07 PM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Sun, Oct 31, 2021 at 02:52:58AM +0900, Masahiro Yamada wrote:
> > > > As commit 7ae4a78daacf ("ARM: 8969/1: decompressor: simplify libfdt
> > > > builds") stated, copying source files during the build time may not
> > > > end up with as clean code as expected.
> > > >
> > > > Do similar for the other library files for further cleanups of the
> > > > Makefile and .gitignore.
> > > >
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > >
> > > Hi,
> > >
> > > I am now seeing the following every time I run a build:
> > >
> > >   GEN     Makefile
> > >   CALL    .../linux-rmk/scripts/atomic/check-atomics.sh
> > >   CALL    .../linux-rmk/scripts/checksyscalls.sh
> > >   CHK     include/generated/compile.h
> > >   Kernel: arch/arm/boot/Image is ready
> > >   AS      arch/arm/boot/compressed/lib1funcs.o
> > >   AS      arch/arm/boot/compressed/ashldi3.o
> > >   AS      arch/arm/boot/compressed/bswapsdi2.o
> > >   LD      arch/arm/boot/compressed/vmlinux
> > >   OBJCOPY arch/arm/boot/zImage
> > >   Kernel: arch/arm/boot/zImage is ready
> > >
> > > In other words, those three objects are always rebuilt even though
> > > they haven't changed.
> > >
> > > I've tried removing the arch/arm/boot/compressed directory in the
> > > build tree, but that doesn't make any difference.
> > >
> > > Running with V=2 shows:
> > >
> > >   AS      arch/arm/boot/compressed/lib1funcs.o - due to lib1funcs.o not in $(tar
> > > gets)
> > >   AS      arch/arm/boot/compressed/ashldi3.o - due to ashldi3.o not in $(targets)
> > >   AS      arch/arm/boot/compressed/bswapsdi2.o - due to bswapsdi2.o not in $(targets)
> > >
> > > It looks to me like:
> > > OBJS    += lib1funcs.o ashldi3.o bswapsdi2.o
> > >
> > > in your patch should have been added before:
> > >
> > > targets       := vmlinux vmlinux.lds piggy_data piggy.o \
> > >                  head.o $(OBJS)
> > >
> > > Please confirm.
> >
> >
> > Sorry for my late reply.
> >
> > Yes, you are right.
> >
> > OBJS    += lib1funcs.o ashldi3.o bswapsdi2.o
> >
> > should come before the 'targets' assignment.
> >
> >
> >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
