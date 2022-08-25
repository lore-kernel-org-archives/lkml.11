Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8FDC28D13
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 14:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238413AbiHYOUl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 10:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240825AbiHYOSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:18:47 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 63966AE9F5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:18:46 -0700 (PDT)
Received: (qmail 2280 invoked by uid 1000); 25 Aug 2022 10:18:44 -0400
Date:   Thu, 25 Aug 2022 10:18:44 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jack Pham <jackp@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v2] usb: ehci: Use endpoint in URB to get maxpacket
Message-ID: <YweExOC5uvYkc+kA@rowland.harvard.edu>
References: <20220824193813.13129-1-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824193813.13129-1-khalid.masum.92@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 01:38:13AM +0600, Khalid Masum wrote:
> usb_maxpacket() looks up the endpoint number in the pipe which can fail
> if the interface or configuration changes before the routine is called.
> This is unexpected and may even cause a modulo by zero afterwards.
> 
> So use usb_endpoint_maxp() routine which uses the endpoint stored in URB
> to get the maxpacket.
> 
> Addresses-Coverity: 744857 ("Division or modulo by zero")
> Addresses-Coverity: 1487371 ("Division or modulo by zero")
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
> ---
> Changes since v1:
>  - Update commit description
>  - Use usb_endpoint_maxp() instead of checking whether getting maxpacket
>    failed
>  - Link: https://lore.kernel.org/lkml/20220823182758.13401-1-khalid.masum.92@gmail.com/
> 
>  drivers/usb/host/ehci-q.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
> index 807e64991e3e..666f5c4db25a 100644
> --- a/drivers/usb/host/ehci-q.c
> +++ b/drivers/usb/host/ehci-q.c
> @@ -645,7 +645,7 @@ qh_urb_transaction (
>  		token |= (1 /* "in" */ << 8);
>  	/* else it's already initted to "out" pid (0 << 8) */
>  
> -	maxpacket = usb_maxpacket(urb->dev, urb->pipe);
> +	maxpacket = usb_endpoint_maxp(&urb->ep->desc);
>  
>  	/*
>  	 * buffer gets wrapped in one or more qtds;
> @@ -1218,7 +1218,7 @@ static int ehci_submit_single_step_set_feature(
>  
>  	token |= (1 /* "in" */ << 8);  /*This is IN stage*/
>  
> -	maxpacket = usb_maxpacket(urb->dev, urb->pipe);
> +	maxpacket = usb_endpoint_maxp(&urb->ep->desc);
>  
>  	qtd_fill(ehci, qtd, buf, len, token, maxpacket);

Acked-by: Alan Stern <stern@rowland.harvard.edu>
