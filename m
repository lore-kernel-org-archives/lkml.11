Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDA2C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Feb 2022 18:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242809AbiBSS3D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Feb 2022 13:29:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiBSS3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:29:02 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445CC6595;
        Sat, 19 Feb 2022 10:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=reP9JOLT8/GySfc6/C09NUIj+SFYzzGKZaOj+wqaV/Y=; b=GwAzgerQnOuYJUj3c5B1Oko+6E
        +o1JckBomXcuyHe/NrhP1tBvkovL735lZfEKma8soo4YDirNdjfMBqpditNDmcB9AH9i0Pj4d+/Sx
        5i95fp5LJzZwtbwPWtGBr6ABiXBy+k2xc2T7W1E0cN/GqOFd9Cz8X5xCGWrLrPAvz0ns=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nLUSw-006tRh-IM; Sat, 19 Feb 2022 19:28:18 +0100
Date:   Sat, 19 Feb 2022 19:28:18 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Heyi Guo <guoheyi@linux.alibaba.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dylan Hung <dylan_hung@aspeedtech.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Issue report] drivers/ftgmac100: DHCP occasionally fails during
 boot up or link down/up
Message-ID: <YhE2wl7XcTUQvEd4@lunn.ch>
References: <0e456c4d-aa22-4e7f-9b2c-3059fe840cb9@linux.alibaba.com>
 <YgwSAjGN2eWUpamo@lunn.ch>
 <4964f8c3-8349-4fad-e176-8c26840d1a08@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4964f8c3-8349-4fad-e176-8c26840d1a08@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 06:08:35PM +0800, Heyi Guo wrote:
> Hi Andrew,
> 
> The DHCP issue is gone after applying below patch. I put the lock statements
> outside of the pure reset function, for the phydev lock has been acquired
> before calling adjust_link. The lock order in ftgmac100_reset_task() was
> also changed, to make it the same as the lock procedure in adjust_link, in
> which the phydev is locked first and then rtnl_lock. I'm not quite sure
> whether it will bring in any potential dead lock. Any advice?

Did you run the code with CONFIG_PROVE_LOCKING enabled. That will help
detect possible deadlock situations.

       Andrew
