Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B04C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 19:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiDFTzO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 15:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbiDFTxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A61C19750B;
        Wed,  6 Apr 2022 10:50:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E204961B49;
        Wed,  6 Apr 2022 17:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8BFC385A5;
        Wed,  6 Apr 2022 17:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649267435;
        bh=OTuMiMOd4RDZWmBCix2nDQHdZzlveUQCTb8m/MUvcHs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F1leZkzPgXlatMaUhsoBgDwylCeXv8KqD+lqete/fGVQQU3KR/dNbmrIxo67ZhwLE
         jvVjERepmp4YMV8+fFsVLYyNW93Nd1aE8MM8VtQiTXnB4VmwbglGCGatacxwJDc0ix
         TFyMwvAZkQMPqfLX1lQAo148d4NVVqu9qgjY58vknrKArJw0sZ0mtiKnwcXpitgJ3w
         VR1C/vPtTx5Ce7kUJ0V+2233IwQgS+DCTC81dVbK7qfgxdzzdyDzRnaQg3POei0+u1
         vxy5AwxIK/LrbI7qZg4mClRiXHj6fe0THdiI91e+A71FlGlJntV07UmsJLbjTVeJ6M
         h1ngfOgyBvbXw==
Date:   Wed, 6 Apr 2022 10:50:33 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     christopher.lee@cspi.com, davem@davemloft.net, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] myri10ge: fix an incorrect free for skb in
 myri10ge_sw_tso
Message-ID: <20220406105033.6e0f1978@kernel.org>
In-Reply-To: <20220406035556.730-1-xiam0nd.tong@gmail.com>
References: <20220406035556.730-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Apr 2022 11:55:56 +0800 Xiaomeng Tong wrote:
> All remaining skbs should be released when myri10ge_xmit fails to
> transmit a packet. Fix it within another skb_list_walk_safe.

I think it was also a UAF.

> diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
> index 50ac3ee2577a..21d2645885ce 100644
> --- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
> +++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
> @@ -2903,11 +2903,9 @@ static netdev_tx_t myri10ge_sw_tso(struct sk_buff *skb,
>  		status = myri10ge_xmit(curr, dev);
>  		if (status != 0) {
>  			dev_kfree_skb_any(curr);
> -			if (segs != NULL) {
> -				curr = segs;
> -				segs = next;
> +			skb_list_walk_safe(next, curr, next) {
>  				curr->next = NULL;
> -				dev_kfree_skb_any(segs);
> +				dev_kfree_skb_any(curr);
>  			}
>  			goto drop;
>  		}

Much better, thanks. 

kfree_skb_list() exists but the patch was already applied, so whatever.
