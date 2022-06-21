Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0543C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 14:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350456AbiFUOT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 10:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349027AbiFUOT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:19:27 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4525B13EAA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:19:26 -0700 (PDT)
Received: (qmail 876385 invoked by uid 1000); 21 Jun 2022 10:19:25 -0400
Date:   Tue, 21 Jun 2022 10:19:25 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     hminas@synopsys.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        amelie.delaunay@foss.st.com
Subject: Re: [PATCH 1/3] usb: host: ohci-platform: add TPL support
Message-ID: <YrHTba9s2NhBfQT2@rowland.harvard.edu>
References: <20220621130506.85424-1-fabrice.gasnier@foss.st.com>
 <20220621130506.85424-2-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621130506.85424-2-fabrice.gasnier@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 03:05:04PM +0200, Fabrice Gasnier wrote:
> From: Amelie Delaunay <amelie.delaunay@foss.st.com>
> 
> The TPL support is used to identify targeted devices during EH compliance
> test. The user can add "tpl-support" in the device tree to enable it.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---

For this patch and the 2/3 ehci-platform patch:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ohci-platform.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index 47dfbfe9e5190..0adae62651276 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -28,6 +28,7 @@
>  #include <linux/usb/ohci_pdriver.h>
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
> +#include <linux/usb/of.h>
>  
>  #include "ohci.h"
>  
> @@ -210,6 +211,8 @@ static int ohci_platform_probe(struct platform_device *dev)
>  	hcd->rsrc_start = res_mem->start;
>  	hcd->rsrc_len = resource_size(res_mem);
>  
> +	hcd->tpl_support = of_usb_host_tpl_support(dev->dev.of_node);
> +
>  	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
>  	if (err)
>  		goto err_power;
> -- 
> 2.25.1
> 
