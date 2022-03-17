Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69697C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 08:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiCQIB7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 04:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiCQIB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:01:57 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FDD7EBB8D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:00:41 -0700 (PDT)
Received: from [192.168.1.3] (ns.gsystem.sk [62.176.172.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 580F27A025B;
        Thu, 17 Mar 2022 09:00:39 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Meng Tang <tangmeng@uniontech.com>
Subject: Re: [PATCH] net: 3com: 3c59x: Change the conditional processing for vortex_ioctl
Date:   Thu, 17 Mar 2022 09:00:36 +0100
User-Agent: KMail/1.9.10
Cc:     klassert@kernel.org, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220317043344.15317-1-tangmeng@uniontech.com>
In-Reply-To: <20220317043344.15317-1-tangmeng@uniontech.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202203170900.36931.linux@zary.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 March 2022, Meng Tang wrote:
> In the vortex_ioctl, there are two places where there can be better
> and easier to understand:
> First, it should be better to reverse the check on 'VORTEX_PCI(vp)'
> and returned early in order to be easier to understand.
> Second, no need to make two 'if(state != 0)' judgments, we can
> simplify the execution process.

Congratulations, you've just added 3 lines of code and broke a driver.
Your "simplified" version does not work with EISA devices.

Why? Please stop "improving" drivers if you can't test them.
 
> Signed-off-by: Meng Tang <tangmeng@uniontech.com>
> ---
>  drivers/net/ethernet/3com/3c59x.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/3com/3c59x.c b/drivers/net/ethernet/3com/3c59x.c
> index ccf07667aa5e..c22de3c8cd12 100644
> --- a/drivers/net/ethernet/3com/3c59x.c
> +++ b/drivers/net/ethernet/3com/3c59x.c
> @@ -3032,16 +3032,19 @@ static int vortex_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
>  	struct vortex_private *vp = netdev_priv(dev);
>  	pci_power_t state = 0;
>  
> -	if(VORTEX_PCI(vp))
> -		state = VORTEX_PCI(vp)->current_state;
> +	if (!VORTEX_PCI(vp))
> +		return -EOPNOTSUPP;
>  
> -	/* The kernel core really should have pci_get_power_state() */
> +	state = VORTEX_PCI(vp)->current_state;
>  
> -	if(state != 0)
> +	/* The kernel core really should have pci_get_power_state() */
> +	if (!state) {
> +		err = generic_mii_ioctl(&vp->mii, if_mii(rq), cmd, NULL);
> +	} else {
>  		pci_set_power_state(VORTEX_PCI(vp), PCI_D0);
> -	err = generic_mii_ioctl(&vp->mii, if_mii(rq), cmd, NULL);
> -	if(state != 0)
> +		err = generic_mii_ioctl(&vp->mii, if_mii(rq), cmd, NULL);
>  		pci_set_power_state(VORTEX_PCI(vp), state);
> +	}
>  
>  	return err;
>  }



-- 
Ondrej Zary
