Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2FCC2BB41
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 09:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiHPJnR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 05:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiHPJme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:42:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4491BC135;
        Tue, 16 Aug 2022 01:57:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E3E3611EB;
        Tue, 16 Aug 2022 08:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599EDC433D6;
        Tue, 16 Aug 2022 08:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660640250;
        bh=3/vRXYAeMjGp2cIzyMyjGYylVgkaUhI3NpSv+xA0dq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gqFe9agbbvtCsrWNJWcll49KYAKUy7ea26mAaQYWKRttNVaDZC3PUfrglC9+8CD+3
         8yrxf/GxjIHZ2nd8CDVAAgSXgqtoTizgsfg6DFiOKHo1LRiQxxnFmqaFlNzwh40zyx
         ieVcYlvsHcSAoYhQ7oWJDVOF7qkWMkh4x6bLg+fE=
Date:   Tue, 16 Aug 2022 10:57:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ray Chi <raychi@google.com>
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        badhri@google.com, albertccwang@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: xhci: add check_init_status hook support
Message-ID: <Yvtb93dhvhTS5xYB@kroah.com>
References: <20220816083854.1491886-1-raychi@google.com>
 <20220816083854.1491886-3-raychi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816083854.1491886-3-raychi@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 04:38:54PM +0800, Ray Chi wrote:
> In general, xHCI didn't do anything for port initialization. However,
> there are some requirement or limitation on various platforms, so
> vendors need to do some error handlings if the device connected to a
> broken USB accessory.
> 
> This patch also add the hook to xhci_driver_overrides so that vendors
> can add their specific protection easily if needed.
> 
> Signed-off-by: Ray Chi <raychi@google.com>
> ---
>  drivers/usb/host/xhci.c | 17 +++++++++++++++++
>  drivers/usb/host/xhci.h |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 65858f607437..f237af9d6e2e 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -4358,6 +4358,20 @@ static int xhci_enable_device(struct usb_hcd *hcd, struct usb_device *udev)
>  	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ONLY);
>  }
>  
> +/*
> + * The function could get the status of port initialization.
> + */
> +static int xhci_check_init_status(struct usb_hcd *hcd, struct usb_device *udev, int r)
> +{
> +	/*
> +	 * In general, this function is not necessory. Some platforms may
> +	 * need doing error handling when the port initialization takes a
> +	 * long time to do. The device can use the override callback to
> +	 * do specific handlings.
> +	 */
> +	return 0;
> +}

For obvious technical and legal reasons, we are not allowed to add
"hooks" to the kernel where there are no in-kernel users.  Nor would you
want us to do so.

So I really do not understand this patch series at all.

What driver wants to do odd things here?  What needs to happen that the
in-tree drivers are not doing properly?  Why not get the needed fixes in
the in-kernel drivers instead of trying to add random hooks that some
out-of-tree code would use instead.

confused,

greg k-h
