Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5652C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 19:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbiFBTqe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 15:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237242AbiFBTqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:46:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2026DB1A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2A2BB81F2E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 19:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3664BC34115;
        Thu,  2 Jun 2022 19:46:26 +0000 (UTC)
Date:   Thu, 2 Jun 2022 20:46:22 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, Will Deacon <will@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>, patches@lists.linux.dev
Subject: Re: [PATCH] arm64: Initialize jump labels before setup_machine_fdt()
Message-ID: <YpkTjv6i+IlO32wM@arm.com>
References: <20220602022109.780348-1-swboyd@chromium.org>
 <165419885870.2681883.10934677413962491141.b4-ty@arm.com>
 <CAHmME9qBOwb==N9AWSSb8VhCXANsieWi7JpiiiUMvjU2rdb5XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qBOwb==N9AWSSb8VhCXANsieWi7JpiiiUMvjU2rdb5XA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Thu, Jun 02, 2022 at 09:42:49PM +0200, Jason A. Donenfeld wrote:
> On Thu, Jun 2, 2022 at 9:41 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Wed, 1 Jun 2022 19:21:09 -0700, Stephen Boyd wrote:
> > > A static key warning splat appears during early boot on arm64 systems
> > > that credit randomness from devicetrees that contain an "rng-seed"
> > > property. This is because setup_machine_fdt() is called before
> > > jump_label_init() during setup_arch(). Let's swap the order of these two
> > > calls so that jump labels are initialized before the devicetree is
> > > unflattened and the rng seed is credited.
> > >
> > > [...]
> >
> > Applied to arm64 (for-next/core), thanks!
> >
> > [1/1] arm64: Initialize jump labels before setup_machine_fdt()
> >       https://git.kernel.org/arm64/c/73e2d827a501
> 
> I'm not sure precisely what your for-next tag corresponds to, but just
> FYI, this should probably go into 5.19 asap and be marked for stable@.

The for-next/core branch should go in 5.19-rc1 (I'll send a pull request
tomorrow). There's no need to cc stable since the fixed commit just went
in (unless you mean something else by "marked for stable").

-- 
Catalin
