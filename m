Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2473C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 17:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382774AbiEERnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 13:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382758AbiEERnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:43:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33695C877;
        Thu,  5 May 2022 10:39:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 715DF61EFF;
        Thu,  5 May 2022 17:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA8BC385A4;
        Thu,  5 May 2022 17:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651772393;
        bh=9rmHzPlhZSBR/Nd84HkVwuqBYbzPc1wFE/i+OrPsMbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sIFMIAQZ6DkfJh6A+B2PH83sZoeu2XWrgfPx7nCognD/tN0/G4TZDawEZUvOrfZCB
         0b7W2ve4tiIvNAFc1/Mrpsx+Zp/earkU7XMa7zP4Zy4yhoberA0Eu0mLaiDv1e8/MY
         HM9KmuhRGGbQGHBXL6IYt/QGtXhZThz6SsvadZDk=
Date:   Thu, 5 May 2022 14:17:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     monish.kumar.r@intel.com
Cc:     olebowle@gmx.com, oneukum@suse.com, vpalatin@chromium.org,
        wangjm221@gmail.com, chris.chiu@canonical.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        abhijeet.rao@intel.com
Subject: Re: [PATCH] Add USB_QUIRK_NO_LPM USB_QUIRK_RESET_RESUME quirks for
 Dell usb gen 2 device to not fail during enumeration.
Message-ID: <YnPARed/HKdnwPKV@kroah.com>
References: <20220505101459.7804-1-monish.kumar.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505101459.7804-1-monish.kumar.r@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 03:44:59PM +0530, monish.kumar.r@intel.com wrote:
> From: Monish Kumar R <monish.kumar.r@intel.com>
> 
> Signed-off-by: Monish Kumar R <monish.kumar.r@intel.com>
> ---
>  drivers/usb/core/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 97b44a68668a..257ac37464e8 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -515,6 +515,10 @@ static const struct usb_device_id usb_quirk_list[] = {
>  
>  	/* INTEL VALUE SSD */
>  	{ USB_DEVICE(0x8086, 0xf1a5), .driver_info = USB_QUIRK_RESET_RESUME },
>         
> +	/*DELL USB GEN2 */
> +	{ USB_DEVICE(0x413c, 0xb062), .driver_info = USB_QUIRK_NO_LPM },
> +	{ USB_DEVICE(0x413c, 0xb062), .driver_info = USB_QUIRK_RESET_RESUME },

Are you sure you need both?  How was this tested that both are actually
set?

thanks,

greg k-h
