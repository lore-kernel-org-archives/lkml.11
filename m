Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3740DC4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 22:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiEQW2A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 18:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiEQW16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:27:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAE84F9D5;
        Tue, 17 May 2022 15:27:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89C0FB81CA8;
        Tue, 17 May 2022 22:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB1CC34113;
        Tue, 17 May 2022 22:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652826475;
        bh=YRNg4fUJchn2hn6EXpKMnrT7d/thkCzgxNDNr+EhcWM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aQvLPLWSVFJ6A2aBESvJvAKy6Ha8ipgadZRTF0RbEtHztIX/Rl7hezbc9haclggwv
         egFR8HsIbMvNjHIzbG49fnyLRlrJS+dKZA3h5Z1ENOha+4Wv+lFeMc5WNE3XSpXnVg
         eN66ndseY0Pas3rVb+KzXtK2rcBNTLZWy9PFKiAmxm772N4TCu/2ghbwNMtkOApKJU
         IHp9QsIHL2bMbX/ZGYsXMn5vdcl9qQTllkUva8YNab3+pB1uPs6QeYRCeCShTpmaam
         HPN3rOrADs5Lgit1lMijJC/1wKlC56kJDlKjrVvr2/MrmolY/LNnSETCtNB+fu/oNv
         3BKsmx1quweNg==
Date:   Tue, 17 May 2022 15:27:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] net: fec: Avoid to allocate rx buffer using ATOMIC
 in ndo_open
Message-ID: <20220517152753.78685d6c@kernel.org>
In-Reply-To: <20220517100544.2326499-1-michael@amarulasolutions.com>
References: <20220517100544.2326499-1-michael@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022 12:05:44 +0200 Michael Trimarchi wrote:
> Subject: [RFC PATCH] net: fec: Avoid to allocate rx buffer using ATOMIC in ndo_open

nit: "Avoid allocating"

We need a commit message, guessing your motivation something like this
would be enough IMHO:

 Make ndo_open less sensitive to memory pressure.

> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 9f33ec838b52..09eb6ea9a584 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -3076,7 +3076,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
>  	rxq = fep->rx_queue[queue];
>  	bdp = rxq->bd.base;
>  	for (i = 0; i < rxq->bd.ring_size; i++) {
> -		skb = netdev_alloc_skb(ndev, FEC_ENET_RX_FRSIZE);
> +		skb = __netdev_alloc_skb(ndev, FEC_ENET_RX_FRSIZE, GFP_KERNEL);
>  		if (!skb)
>  			goto err_alloc;
>  

The patch LGTM, feel free to repost as non-RFC.
