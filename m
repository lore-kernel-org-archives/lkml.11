Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC67C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 19:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353256AbiETTcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 15:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353226AbiETTb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:31:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6F8195792;
        Fri, 20 May 2022 12:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEB4361B59;
        Fri, 20 May 2022 19:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88021C34115;
        Fri, 20 May 2022 19:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653075116;
        bh=IJkerf8h8Ew+6kR4B+Gpq30axpkVygwfR6OjpOLtUAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ax1IvEJdBZ3q0i+3E70Haxnp5ABfRVUpVcEC1wXervF1Macm2x1TVtD16cODZoGrX
         NZKlfoaq8RvQzNeDgjPmG60Ua4w4vmMMWySL0SOWSQtSjtr2D0xATtuwT/18mQ/cAE
         H4l0iqWFRv8d0Cz9oDmR+UD0smxvyVA+utbMcbfQ=
Date:   Fri, 20 May 2022 21:19:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     monish.kumar.r@intel.com
Cc:     oneukum@suse.com, olebowle@gmx.com, davem@davemloft.net,
        wangjm221@gmail.com, chris.chiu@canonical.com,
        vpalatin@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, abhijeet.rao@intel.com
Subject: Re: [PATCH] Add USB_QUIRK_NO_LPM USB_QUIRK_RESET_RESUME quirks for
 Dell usb gen 2 device to not fail during enumeration.
Message-ID: <Yofpwy1/oe8FaKUb@kroah.com>
References: <20220520130044.17303-1-monish.kumar.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520130044.17303-1-monish.kumar.r@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 06:30:44PM +0530, monish.kumar.r@intel.com wrote:
> From: Monish Kumar R <monish.kumar.r@intel.com>
> 
> Found this bug on own testing
> 
> Signed-off-by: Monish Kumar R <monish.kumar.r@intel.com>
> ---
>  drivers/usb/core/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)

I have fixed this up by hand, but next time please run this through the
Intel open source review process first before sending it out so that I
will not have to fix up further patches.

thanks,

greg k-h
