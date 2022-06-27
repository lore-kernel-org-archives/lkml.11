Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F38C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 18:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbiF0Sj3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240402AbiF0Si3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 14:38:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D7F2FD;
        Mon, 27 Jun 2022 11:38:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4E09615AE;
        Mon, 27 Jun 2022 18:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B9DC3411D;
        Mon, 27 Jun 2022 18:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656355101;
        bh=tpQhZQHIo3oAgckmaPgCZ4BNKAUK0XRiFuSAp70Cu8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VTkRYWDjjVYa94ZaBuyuEozvQwpkROiN+nTDgabfp2ZHC/cee2Hx8BHgw1+hytmj6
         sEoo/0DTgdMw35V5KIXKGb/BvgMC6OnHs9LZhmuT/3JTcODy6ENw+XyScjZAatC/oH
         tHRNBiKZmg9p5Du1OBbQnRg5N/QrEB/J+B5w+fpZVtoMNgYhrfpvo4y8V1+/Nn/njU
         uAGEcVETRgXf94TzYpa3HjRdW3Ihx9HJq4Fe2lo4fdGw8rW4rawyvAk/0OCvukW1ZR
         lIvo/+fDZ226OOEky0wzu5BnRo6whDVUE9/X0njAvotepWFidSZWqw75CwqOxc0PEb
         JL7WIM+kIENfg==
Date:   Mon, 27 Jun 2022 11:38:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Praghadeesh T K S <praghadeeshthevendria@gmail.com>,
        Rain River <rain.1986.08.12@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        praghadeeshtks@zohomail.in,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] net: ethernet/nvidia: fix possible condition with no
 effect
Message-ID: <20220627113812.08ae31f0@kernel.org>
In-Reply-To: <Yrg+NZHBNcu3KFXn@lunn.ch>
References: <20220626103539.80283-1-praghadeeshthevendria@gmail.com>
        <Yrg+NZHBNcu3KFXn@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jun 2022 13:08:37 +0200 Andrew Lunn wrote:
> On Sun, Jun 26, 2022 at 10:35:39AM +0000, Praghadeesh T K S wrote:
> > Fix Coccinelle bug, removed condition with no effect.  
> 
> This is not a coccinelle bug. If it was, you would be patching
> coccinelle, not the kernel.

I'd say the commit message is better than the commit ;)
Praghadeesh, could you fix Coccinelle to avoid matching:

	if (/* case 1 */) {
		/* BLOCK 1*/
	} else (/* case 2 */ {
		/* BLOCK 2 */
	} else {
		/* default == BLOCK 2 */
	}

Because 99% of the time that construct is intentional.
