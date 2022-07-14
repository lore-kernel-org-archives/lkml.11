Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED352C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 13:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbiGNNGj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 09:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238299AbiGNNGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:06:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B196951430;
        Thu, 14 Jul 2022 06:06:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6C1315A1;
        Thu, 14 Jul 2022 06:06:35 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.26.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC14E3F73D;
        Thu, 14 Jul 2022 06:06:33 -0700 (PDT)
Date:   Thu, 14 Jul 2022 14:06:28 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: FVP: kernel BUG at arch/arm64/kernel/traps.c:497 - Internal
 error: Oops - BUG: 0
Message-ID: <YtAU1AHLLgK/v7RP@FVFF77S0Q05N.cambridge.arm.com>
References: <CA+G9fYtOX-6=f70FA5PuDVA=kX=2L4spXKXS8=LHkUphafXowg@mail.gmail.com>
 <Ys1g8PH4M2W7Z50U@sirena.org.uk>
 <CA+G9fYu7mJ6X3_xhboODP_cjABE4QTJCON_NMduQ60x4Z7N78Q@mail.gmail.com>
 <Ys/9TSV5muvKXN6W@FVFF77S0Q05N>
 <YtABEDylGJkYLXrJ@sirena.org.uk>
 <YtASzuHo1MXe5LJH@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtASzuHo1MXe5LJH@FVFF77S0Q05N.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 01:57:50PM +0100, Mark Rutland wrote:
> On Thu, Jul 14, 2022 at 12:42:08PM +0100, Mark Brown wrote:
> > On Thu, Jul 14, 2022 at 12:26:05PM +0100, Mark Rutland wrote:
> > 
> > > I note that your log has:
> > 
> > > | Hit any key to stop autoboot:  1  0 
> > > | smh_open: ERROR fd -1 for file 'boot.img'
> > > | smh_open: ERROR fd -1 for file 'Image'
> > > | smh_open: ERROR fd -1 for file 'devtree.dtb'
> > > | smh_open: ERROR fd -1 for file 'ramdisk.img'
> > 
> > ...
> > 
> > > | Hit any key to stop autoboot:  0   
> > > | smh_open: ERROR fd -1 for file 'boot.img'
> > > | loaded file Image from 80080000 to 82F299FF, 02EA9A00 bytes
> > > | smh_open: ERROR fd -1 for file 'devtree.dtb'
> > > | smh_open: ERROR fd -1 for file 'ramdisk.img'
> > > | fdt - flattened device tree utility commands
> > 
> > > ... and I wonder if that has something to do with it, given it appears that
> > > your Image is corrupted somehow.
> > 
> > Naresh's command line is putting Image directly into RAM with
> > 
> >     --data cluster0.cpu0=/tuxrun-r4_1075p-lava-1/Image@0x80080000
> 
> Likewise in mine:
> 
> 	--data cluster0.cpu0=/mnt/data/models/fvp/naresh/Image@0x80080000
> 
> ... as I'm using the same command line, just with paths altered.

... and I've just reproduced the issue by running the script from a different
directory, since apprarently the semihosting interface just grabs the file from
the current directory.

I'm pretty sure this means that *something* is clobbering the Image early on
during boot, and the semihisting loading happens to refresh it.

Thanks,
Mark.
