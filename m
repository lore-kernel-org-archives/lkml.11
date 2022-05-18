Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5B9C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 14:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbiERORx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 10:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237557AbiERORs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:17:48 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B41CD340C3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:17:46 -0700 (PDT)
Received: (qmail 190933 invoked by uid 1000); 18 May 2022 10:17:45 -0400
Date:   Wed, 18 May 2022 10:17:45 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Li Zhengyu <lizhengyu3@huawei.com>
Cc:     dbaryshkov@gmail.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: host: ohci-tmio: Remove redundant if statement
Message-ID: <YoUACar4I9X2oJ/A@rowland.harvard.edu>
References: <20220518024347.213402-1-lizhengyu3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518024347.213402-1-lizhengyu3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 10:43:47AM +0800, Li Zhengyu wrote:
> (ret == 0) is true when (ret) is false, so remove it.
> Also remove unreachable code.
> 
> Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ohci-tmio.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
> index 49539b9f0e94..6bcb0cb53f7c 100644
> --- a/drivers/usb/host/ohci-tmio.c
> +++ b/drivers/usb/host/ohci-tmio.c
> @@ -243,12 +243,8 @@ static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
>  	ret = usb_add_hcd(hcd, irq, 0);
>  	if (ret)
>  		goto err_add_hcd;
> -
>  	device_wakeup_enable(hcd->self.controller);
> -	if (ret == 0)
> -		return ret;
> -
> -	usb_remove_hcd(hcd);
> +	return ret;
>  
>  err_add_hcd:
>  	tmio_stop_hc(dev);
> -- 
> 2.17.1
> 
