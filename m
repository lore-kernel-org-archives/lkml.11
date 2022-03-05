Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13F4C433FE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Mar 2022 15:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiCEPqw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Mar 2022 10:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiCEPqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 10:46:47 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96C040E45;
        Sat,  5 Mar 2022 07:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=KTaxi+VjxQloBsr2gUQQMZC/bCUg45g0x+XpL+FdNfA=; b=ydvYvtbFKoicxn+qQTW9aOnDEh
        rVms2Kyl/zddzxygQQWD3XIhcy3qPCm/qvqq9+83gN3gAo4Jzelc2nehaEZrhTSf+fZVGHraQushq
        EbWqp+q3exDOjTp8pPa0YVykvuQwlmEBKtpHt9LmzYx6abYKpFfvrWbIFb73GX7rmKeI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nQWbS-009Od8-6K; Sat, 05 Mar 2022 16:45:54 +0100
Date:   Sat, 5 Mar 2022 16:45:54 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethernet: sun: Free the coherent when failing in probing
Message-ID: <YiOFslV7l82AkQ3Y@lunn.ch>
References: <1646492104-23040-1-git-send-email-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646492104-23040-1-git-send-email-zheyuma97@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 02:55:04PM +0000, Zheyu Ma wrote:
> When the driver fails to register net device, it should free the DMA
> region first, and then do other cleanup.
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
