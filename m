Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7255C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 07:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbiBQH7q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 02:59:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbiBQH7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:59:25 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68FEF258625;
        Wed, 16 Feb 2022 23:58:54 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nKbgi-0000vy-00; Thu, 17 Feb 2022 08:58:52 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0B097C250A; Thu, 17 Feb 2022 08:58:30 +0100 (CET)
Date:   Thu, 17 Feb 2022 08:58:29 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mips@vger.kernel.org, Rui Salvaterra <rsalvaterra@gmail.com>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ralink: mt7621: do memory detection on KSEG1
Message-ID: <20220217075829.GA5185@alpha.franken.de>
References: <20220211001345.3429572-1-gch981213@gmail.com>
 <20220216195423.GA17551@alpha.franken.de>
 <CAJsYDVJw2DJX97cRwoAofzq_jL0GhyaC5j7UuT6OzC=Lp8WkSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJsYDVJw2DJX97cRwoAofzq_jL0GhyaC5j7UuT6OzC=Lp8WkSQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 12:06:09PM +0800, Chuanhong Guo wrote:
> Hi!
> 
> On Thu, Feb 17, 2022 at 3:57 AM Thomas Bogendoerfer
> <tsbogend@alpha.franken.de> wrote:
> >
> > On Fri, Feb 11, 2022 at 08:13:44AM +0800, Chuanhong Guo wrote:
> > > It's reported that current memory detection code occasionally detects
> > > larger memory under some bootloaders.
> > > Current memory detection code tests whether address space wraps around
> > > on KSEG0, which is unreliable because it's cached.
> > >
> > > Rewrite memory size detection to perform the same test on KSEG1 instead.
> > > While at it, this patch also does the following two things:
> > > 1. use a fixed pattern instead of a random function pointer as the magic
> > >    value.
> > > 2. add an additional memory write and a second comparison as part of the
> > >    test to prevent possible smaller memory detection result due to
> > >    leftover values in memory.
> > >
> > > Fixes: 139c949f7f0a MIPS: ("ralink: mt7621: add memory detection support")
> > > Reported-by: Rui Salvaterra <rsalvaterra@gmail.com>
> > > Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> > > ---
> > >  arch/mips/ralink/mt7621.c | 36 +++++++++++++++++++++++-------------
> > >  1 file changed, 23 insertions(+), 13 deletions(-)
> >
> > applied to mips-fixes.
> 
> Oops.
> 
> As I mentioned in a previous mail, this patch has two cosmetic problems:
> 1. misplaced bracket in commit message "Fixes" tag
> 2. incorrect second test pattern: I meant to flip all the bits in the
> first pattern,
>    but I used "!" instead of "~". Any value will work just fine but it
> looks weird
>    to construct a zero using !MT7621_MEM_TEST_PATTERN.
> 
> Should I send a second patch to fix this patch or send a v2 of the
> original patch?

a second patch please.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
