Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9118FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 18:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiBUSyj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:54:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbiBUSxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:53:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34537111
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:53:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3541614FB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 18:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D07C340E9;
        Mon, 21 Feb 2022 18:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645469597;
        bh=4gzlRRMq6XhlfZGzpOExTVP9X+cX8RqM5SLF621F3vU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kO/Tpt1W3aTRvibUYuWGJWSDL+IPziq6HpgBaVheBS2JwifIYL5wnP6J/gLJODFvT
         aPvvBqaEZuFUF0tJFRMn2XCQ+InAqgTYWQ/hPOxyXxW/DLeGu6Ee0XimrGz2zR+5kX
         fvH1mfp9wryRU3x9x/rCUVwh59Wet618s4BIj+n0=
Date:   Mon, 21 Feb 2022 19:53:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] staging: r8188eu: odm cleanups
Message-ID: <YhPfmkMORaBraQNr@kroah.com>
References: <20220221073306.16636-1-straube.linux@gmail.com>
 <YhPIOp/k/u9GUv73@kroah.com>
 <fc8e4d44-fa64-f8bf-a442-87c1437978fa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc8e4d44-fa64-f8bf-a442-87c1437978fa@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 07:48:22PM +0100, Michael Straube wrote:
> On 2/21/22 18:13, Greg KH wrote:
> > On Mon, Feb 21, 2022 at 08:33:01AM +0100, Michael Straube wrote:
> > > This set removes two more functions from the unwanted hal/odm layer.
> > > Tested on x86_64 with Inter-Tech DMG-02.
> > > 
> > > v2:
> > > Fixed a typo in the commit message of patch 2/5.
> > > unsed -> used
> > > 
> > > Michael Straube (5):
> > >    staging: r8188eu: remove ODM_CmnInfoHook()
> > >    staging: r8188eu: convert two u8 variables to bool
> > >    staging: r8188eu: remove enum odm_bw
> > >    staging: r8188eu: convert type of pBandWidth in odm_dm_struct
> > >    staging: r8188eu: remove ODM_CmnInfoUpdate()
> > > 
> > >   drivers/staging/r8188eu/hal/odm.c             | 56 +------------------
> > >   drivers/staging/r8188eu/hal/rtl8188e_dm.c     | 19 ++++---
> > >   drivers/staging/r8188eu/include/odm.h         | 29 +---------
> > >   drivers/staging/r8188eu/include/rtw_mlme.h    |  2 +-
> > >   drivers/staging/r8188eu/include/rtw_pwrctrl.h |  2 +-
> > >   5 files changed, 16 insertions(+), 92 deletions(-)
> > > 
> > > -- 
> > > 2.35.1
> > > 
> > > 
> > 
> > This patch series does not apply to my tree.  Please rebase and resend.
> > 
> 
> Hi Greg,
> 
> looks like you already applied v1 of this series.
> The only change in v2 was fixing a typo in a commit message..

Ah, that makes more sense, sorry I missed that, my fault.  We can live
with the typo :)
