Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E4FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Jul 2022 02:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbiGGCwU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 22:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiGGCwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:52:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822D92F64A;
        Wed,  6 Jul 2022 19:52:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38918B81FB2;
        Thu,  7 Jul 2022 02:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C540C341C6;
        Thu,  7 Jul 2022 02:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657162334;
        bh=qHdfcR92KphIlwMQSdb9bKDFM89WG7PyeIshziXWI0I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n1KVKNxFhjVGMUg7wrJwh6QDUailEsLG3FV7Pe5Y9NdQnCvPdYv4WNhtPC4+JYla8
         dPJKyd0MM7ozFhQIWyMou7+Wz8aTFfams0f36WUlZ14H4TgT5i8W9L/hoKusTE4N6E
         Jbd9fVKqV6G8w729lzlifSuHFk7GzAGG3+Cjc81oQ9FzK5vOoLzbTcY5Fwe3ps3nyj
         xg7+NGZ7bAPZLxnsi4IAculXNu7Xs0ClaNE7bfcdUGrlro+S0bxM4Iu5PVnPnui9XQ
         ajwsVRiIZklyJQYmDItssy4F9BprGirOubfB/DW+pO2N/rG52i/+mfDOzXlankcn6M
         E4xaK5aO5TWuw==
Date:   Wed, 6 Jul 2022 19:52:13 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sieng-Piaw Liew <liew.s.piaw@gmail.com>
Cc:     chris.snook@gmail.com, davem@davemloft.net, edumazet@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ag71xx: switch to napi_build_skb() to reuse
 skbuff_heads
Message-ID: <20220706195213.6b751af8@kernel.org>
In-Reply-To: <20220705004434.1453-1-liew.s.piaw@gmail.com>
References: <20220705004434.1453-1-liew.s.piaw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Jul 2022 08:44:34 +0800 Sieng-Piaw Liew wrote:
> --- a/drivers/net/ethernet/atheros/ag71xx.c
> +++ b/drivers/net/ethernet/atheros/ag71xx.c
> @@ -825,7 +825,7 @@ static int ag71xx_tx_packets(struct ag71xx *ag, bool flush)
>  		if (!skb)
>  			continue;
>  
> -		dev_kfree_skb_any(skb);
> +		napi_consume_skb(skb, !flush);

!flush is not sufficient here, napi can be called with a budget of 0.
