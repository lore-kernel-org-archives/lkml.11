Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEC3C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 14:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiCIOtP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 09:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiCIOtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:49:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1104CD4F;
        Wed,  9 Mar 2022 06:48:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ABF860F90;
        Wed,  9 Mar 2022 14:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF766C340E8;
        Wed,  9 Mar 2022 14:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646837294;
        bh=UM0WFg9q9w48swktQUse17RKS8k2QIrd2KQ/iF65Dtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VrJCGtA1H1sC6ng+6sTR6vEdgvomB73pxaJq8l6l7d35QZhHeJbW04yp5KPzp6C9M
         5T2asLont4COiNGY/J+/D3mDsAOcqQz76LDWBA79KCb0YmLXMKZroNcfMBDPAA0mkG
         I0j8w2ITsLlPu+JxJY2PjgSYR0+t2ZqDJ+/ezNks=
Date:   Wed, 9 Mar 2022 15:48:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Yongzhi Liu <lyz_cs@pku.edu.cn>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 012/105] dmaengine: shdma: Fix runtime PM imbalance
 on error
Message-ID: <Yii+KtAnZ3XSJtXg@kroah.com>
References: <20220307091644.179885033@linuxfoundation.org>
 <20220307091644.529997660@linuxfoundation.org>
 <20220309105420.GA22677@duo.ucw.cz>
 <YiiWduSVDz1yYA9z@kroah.com>
 <20220309123509.GA30506@duo.ucw.cz>
 <YiiuaHFKuAv30zxW@kroah.com>
 <20220309135708.GB30506@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220309135708.GB30506@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 02:57:08PM +0100, Pavel Machek wrote:
> On Wed 2022-03-09 14:40:56, Greg Kroah-Hartman wrote:
> > On Wed, Mar 09, 2022 at 01:35:09PM +0100, Pavel Machek wrote:
> > > On Wed 2022-03-09 12:58:46, Greg Kroah-Hartman wrote:
> > > > On Wed, Mar 09, 2022 at 11:54:20AM +0100, Pavel Machek wrote:
> > > > > Hi!
> > > > > 
> > > > > > From: Yongzhi Liu <lyz_cs@pku.edu.cn>
> > > > > > 
> > > > > > [ Upstream commit 455896c53d5b803733ddd84e1bf8a430644439b6 ]
> > > > > > 
> > > > > > pm_runtime_get_() increments the runtime PM usage counter even
> > > > > > when it returns an error code, thus a matching decrement is needed on
> > > > > > the error handling path to keep the counter balanced.
> > > > > 
> > > > > This patch will break things.
> > > > > 
> > > > > Notice that -ret is ignored (checked 4.4 and 5.10), so we don't
> > > > > actually abort/return error; we just printk. We'll do two
> > > > > pm_runtime_put's after the "fix".
> > > > > 
> > > > > Please drop from -stable.
> > > > > 
> > > > > It was discussed during AUTOSEL review:
> > > > > 
> > > > > Date: Fri, 25 Feb 2022 14:25:10 +0800 (GMT+08:00)
> > > > > From: 刘永志 <lyz_cs@pku.edu.cn>
> > > > > To: pavel machek <pavel@denx.de>
> > > > > Cc: sasha levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
> > > > > Subject: Re: [PATCH AUTOSEL 5.16 24/30] dmaengine: shdma: Fix runtime PM
> > > > > 	imbalance on error
> > > > 
> > > > So 5.15 and 5.16 is ok, but older is not?
> > > 
> > > I believe commit is wrong for mainline and all stable releases, and
> > > author seems to agree. Drop from everywhere.
> > 
> > Is it reverted in Linus's tree yet?
> 
> It will take you a minute to check.
> 
> Take a look at the patch. There's no return in error path, thus doing
> runtime_put is clearly bogus. Should take you less than minute to
> verify.
> 
> Please drop the patch.

I want to have it reverted in Linus's tree as well, otherwise that's a
regression that people will hit.

thanks,

greg k-h
