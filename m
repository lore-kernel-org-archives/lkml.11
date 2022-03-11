Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB5FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 06:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346739AbiCKGnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 01:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346755AbiCKGnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 01:43:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D1D18DAB7;
        Thu, 10 Mar 2022 22:42:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2F7FB82AD0;
        Fri, 11 Mar 2022 06:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B10BC340EC;
        Fri, 11 Mar 2022 06:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646980925;
        bh=KHmrA0e9XJ0drm0KHtDYjHPot3SnAT2Zkho6x2+qGDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PEdAuJ28Kk052LmQd6G2UpwvrpvYzpU8FVVIDz0LfW4Yl29FyDI7HvTeZdVVlA4mT
         qcy6y6e92W2iTPtOVL9UM5rwcPlFswHPWMrQBy6biYNEotdwMciISnXbR6KNx3BcFK
         xtpxDVtBgdbL6aweq6eJPgn7t4pGHhizjekcSs4k=
Date:   Fri, 11 Mar 2022 07:42:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH 5.10 38/58] KVM: arm64: Allow indirect vectors to be used
 without SPECTRE_V3A
Message-ID: <YirvObKn0ADrEOk+@kroah.com>
References: <20220310140812.869208747@linuxfoundation.org>
 <20220310140813.956533242@linuxfoundation.org>
 <20220310234858.GB16308@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310234858.GB16308@amd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 12:48:59AM +0100, Pavel Machek wrote:
> Hi!
> 
> What is going on here?
> 
> > commit 5bdf3437603d4af87f9c7f424b0c8aeed2420745 upstream.
> 
> Upstream commit 5bdf is very different from this. In particular,
> 
> >  arch/arm64/kvm/hyp/smccc_wa.S    |   66 +++++++++++++++++++++++++++++++++++++++
> 
> I can't find smccc_wa.S, neither in mainline, nor in -next. And it
> looks buggy. I suspect loop_k24 should loop 24 times, but it does 8
> loops AFAICT. Same problem with loop_k32.

The kvm portion of these patches is the "trickiest" portions.  I'll let
James explain them, as he did so to me when sending the backports.

thanks,

greg k-h
