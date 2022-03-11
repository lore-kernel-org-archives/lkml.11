Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24822C43217
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 16:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350213AbiCKQWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbiCKQV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:21:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80391D1782;
        Fri, 11 Mar 2022 08:20:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2E94B827DC;
        Fri, 11 Mar 2022 16:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151FEC340E9;
        Fri, 11 Mar 2022 16:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647015653;
        bh=KNC521NAaMPjvKe7AFt0UDDQNR5Ego3Zh4NJj71IBEk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PDezsjcCoKYAprW61cNEeo1YPnFyqu0xwZ7lae5SnAbqDB/RboqC3aycU/p3xq1TA
         FmoCuNklzjURmFDWGLMoRCan6J00DL1GzcZwcvZHdy+TbzyXpyRkNa/lPUMLjLrXuG
         /ggGWLRrJ1f3DM6HBKSOl29Pvje1i1sGTqI+bU7PbLiAwq4Gy79KXc35gqT2M7SdL4
         TuFYTZdJnxrmdIpfDKZe81VPXAPAIcQ1VpWaK6P4A251iZExlBjBeu/BhiYeoc1Y2x
         +4DzyJ5JyXe8ZNV/yj7MFglvjHTYw8B0Ozh9sAEI0Xqu7GxTCGPAoQgFfJoNWh6FP5
         criaNWbmhZc3Q==
Date:   Fri, 11 Mar 2022 08:20:51 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     cgel.zte@gmail.com
Cc:     sebastian.hesselbarth@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH V2] net: mv643xx_eth: use platform_get_irq() instead of
 platform_get_resource()
Message-ID: <20220311082051.783b7c0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220310062035.2084669-1-chi.minghao@zte.com.cn>
References: <20220310062035.2084669-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 06:20:35 +0000 cgel.zte@gmail.com wrote:
> @@ -3189,9 +3188,10 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
>  	timer_setup(&mp->rx_oom, oom_timer_wrapper, 0);
>  
>  
> -	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	BUG_ON(!res);
> -	dev->irq = res->start;
> +	irq = platform_get_irq(pdev, 0);
> +	if (WARN_ON(irq < 0))
> +		return irq;

You can't just return from here, there are operations that need 
to be undone, look at the end of this function :/ Please follow 
up with an incremental fix ASAP.

> +	dev->irq = irq;
>  
