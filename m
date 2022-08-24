Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430BEC32796
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Aug 2022 16:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239608AbiHXQsR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 12:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236605AbiHXQsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:48:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF954DF18;
        Wed, 24 Aug 2022 09:48:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DC8AB8259B;
        Wed, 24 Aug 2022 16:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0B0C433D6;
        Wed, 24 Aug 2022 16:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661359693;
        bh=sjpYGFIJ+m4vZ7surdq6d5jz3f80uBPmrxte8+TEnRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k5tV8z0KSmJp9Q8eIvyPCN0fsbRehnl2RBXBiXeYFzoBpqY+B6FSVJoFtMbEk0oC4
         +6DIHLa5g2KydN/gaiA//ccKtiSlAkbhE1Pas2iLjqNMuzbNB9Za9VvHZl1A21oFo2
         XQ4MWbltwpcctlBbomOXByzXiwkze8eE0/GFRTQI=
Date:   Wed, 24 Aug 2022 18:48:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jean-Francois Le Fillatre <jflf_kernel@gmx.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: add quirks for Lenovo OneLink+ Dock
Message-ID: <YwZWSud0hr/+PpgI@kroah.com>
References: <20220824162641.11805-1-jflf_kernel@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824162641.11805-1-jflf_kernel@gmx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 06:26:41PM +0200, Jean-Francois Le Fillatre wrote:
> From: JFLF <jflf_kernel@gmx.com>
> 
> The Lenovo OneLink+ Dock contains two VL812 USB3.0 controllers:
> 17ef:1018 upstream
> 17ef:1019 downstream
> 
> Those two controllers both have problems with some USB3.0 devices,
> particularly self-powered ones. Typical error messages include:
> 
>   Timeout while waiting for setup device command
>   device not accepting address X, error -62
>   unable to enumerate USB device
> 
> By process of elimination the controllers themselves were identified as
> the cause of the problem. Through trial and error the issue was solved
> by using USB_QUIRK_RESET_RESUME for both chips.
> 
> Signed-off-by: Jean-Francois Le Fillatre <jflf_kernel@gmx.com>

Does not match your "From:" line :(

> ---
>  drivers/usb/core/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)

Forgot to list below the --- line what changed from v1 :(

