Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD50CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 13:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242376AbiBJNrA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 08:47:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240962AbiBJNq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:46:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F79C59;
        Thu, 10 Feb 2022 05:46:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 410B3B82550;
        Thu, 10 Feb 2022 13:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703E6C004E1;
        Thu, 10 Feb 2022 13:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644500817;
        bh=tWYouo5XYl5NBkg5L+Q4uww5+VdxPNa14xREgHgSO/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2iE2/soT4PzPLy4r99jgTR2qI0UMBO03wXw5XNndFRDh8h+Qo9I3yg+yWnO8zyefZ
         QeiY/Ptp/Okh/LGh1h/PPpIqB7W8ijm3/bwcJJJuHXjPngYq6kyTHI6R2FRxXERrgg
         tODP8kSSfKmgcfgtqTmDmyJzHJAJIQyt9C/E5kwo=
Date:   Thu, 10 Feb 2022 14:46:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Husni Faiz <ahamedhusni73@gmail.com>
Cc:     b-liu@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/usb: Fix Coding Style Error
Message-ID: <YgUXTfnuSN4hseWr@kroah.com>
References: <20220210130801.377918-1-ahamedhusni73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210130801.377918-1-ahamedhusni73@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 06:38:01PM +0530, Husni Faiz wrote:
> Signed-off-by: Husni Faiz <ahamedhusni73@gmail.com>
> 
> 
> Removed trailing whitespace.
> 
> ---
>  drivers/usb/musb/musb_host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index 9ff7d891b4b7..cf25a2b7e3bb 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -563,7 +563,7 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, u8 epnum)
>  	ep->rx_reinit = 0;
>  }
>  
> -static void musb_tx_dma_set_mode_mentor(struct musb_hw_ep *hw_ep, 
> +static void musb_tx_dma_set_mode_mentor(struct musb_hw_ep *hw_ep,
>  					struct musb_qh *qh,
>  					u32 *length, u8 *mode)
>  {
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
