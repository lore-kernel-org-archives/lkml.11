Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BEEC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Mar 2022 15:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiCEPlQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Mar 2022 10:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiCEPlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 10:41:14 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB10823BEF;
        Sat,  5 Mar 2022 07:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=mq+oVdjzUV5/PGYLllzSBMDbNl5gTK9JnEFs/8f6PNo=; b=rQDLFY+mXacacX96NhGlm/P1Wm
        cKc5tEm2kGzyjwYwOOofrWLHm+HvytH+UYAZk/Ceukq5wtjBjruPKmTKlOUontpEkkWmWerAvWeuZ
        dJ6bXPIt1gABlyJdUI460w1hJhf/lviXoav6N8qHnWd5joBCRNHJIZVJbVi2ty4ts+Ew=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nQWVs-009Obl-3W; Sat, 05 Mar 2022 16:40:08 +0100
Date:   Sat, 5 Mar 2022 16:40:08 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     rajur@chelsio.com, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: cxgb3: Fix an error code when probing the driver
Message-ID: <YiOEWOID23zxaSod@lunn.ch>
References: <1646490284-22791-1-git-send-email-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646490284-22791-1-git-send-email-zheyuma97@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 02:24:44PM +0000, Zheyu Ma wrote:
> During the process of driver probing, probe function should return < 0
> for failure, otherwise kernel will treat value >= 0 as success.
> 
> Therefore, the driver should set 'err' to -EINVAL when
> 'adapter->registered_device_map' is NULL. Otherwise kernel will assume
> that the driver has been successfully probed and will cause unexpected
> errors.
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
> index bfffcaeee624..662af61fc723 100644
> --- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
> +++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
> @@ -3346,6 +3346,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	}
>  	if (!adapter->registered_device_map) {
>  		dev_err(&pdev->dev, "could not register any net devices\n");
> +		err = -EINVAL;

ENODEV would be better.

       Andrew
