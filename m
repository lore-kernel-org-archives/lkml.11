Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F9EC3F6B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Aug 2022 14:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239282AbiHXOky (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 10:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238221AbiHXOkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:40:51 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 79FFA57278
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:40:50 -0700 (PDT)
Received: (qmail 380982 invoked by uid 1000); 24 Aug 2022 10:40:49 -0400
Date:   Wed, 24 Aug 2022 10:40:49 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexey Sheplyakov <asheplyakov@basealt.ru>,
        Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] usb: host: Use helper function to get endpoint
Message-ID: <YwY4cVdB3tVVMIqJ@rowland.harvard.edu>
References: <20220824130702.10912-1-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824130702.10912-1-khalid.masum.92@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 07:07:02PM +0600, Khalid Masum wrote:
> Current implementation to convert urb pipe number to struct 
> usb_host_endpoint in rquest_single_step_set_feature_urb is a little
> messy. 
> 
> Use usb_pipe_endpoint helper function to get the endpoint instead.
> 
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
> ---
>  drivers/usb/core/hcd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 94b305bbd621..107e29d5d3ae 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2165,8 +2165,7 @@ static struct urb *request_single_step_set_feature_urb(
>  		return NULL;
>  
>  	urb->pipe = usb_rcvctrlpipe(udev, 0);
> -	ep = (usb_pipein(urb->pipe) ? udev->ep_in : udev->ep_out)
> -				[usb_pipeendpoint(urb->pipe)];
> +	ep = usb_pipe_endpoint(udev, urb->pipe);
>  	if (!ep) {
>  		usb_free_urb(urb);
>  		return NULL;

Even this is awkward.  It's silly to look up the endpoint in a table 
when you already know that it is endpoint 0.  Just do:

	ep = &udev->ep0;

with no need to check for NULL.

Alan Stern
