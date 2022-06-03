Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18FCC43334
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 14:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245168AbiFCOoS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 10:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbiFCOoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:44:17 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3B7CF19295
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 07:44:16 -0700 (PDT)
Received: (qmail 303030 invoked by uid 1000); 3 Jun 2022 10:44:15 -0400
Date:   Fri, 3 Jun 2022 10:44:15 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roland Stigge <stigge@antcom.de>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: ohci-nxp: Fix refcount leak in ohci_hcd_nxp_probe
Message-ID: <YpoePyzPNQZXhuNu@rowland.harvard.edu>
References: <20220603141231.979-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603141231.979-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 06:12:30PM +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 73108aa90cbf ("USB: ohci-nxp: Use isp1301 driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ohci-nxp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
> index 85878e8ad331..106a6bcefb08 100644
> --- a/drivers/usb/host/ohci-nxp.c
> +++ b/drivers/usb/host/ohci-nxp.c
> @@ -164,6 +164,7 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
>  	}
>  
>  	isp1301_i2c_client = isp1301_get_client(isp1301_node);
> +	of_node_put(isp1301_node);
>  	if (!isp1301_i2c_client)
>  		return -EPROBE_DEFER;
>  
> -- 
> 2.25.1
> 
