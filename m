Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D3CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 12:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243311AbiEEMkD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 08:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241182AbiEEMj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:39:59 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBD253B45;
        Thu,  5 May 2022 05:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=8iNSslQ9qUJi4oE7RW4OwjyL3eLhK6/G1EOBdiPiNNA=; b=P58Kj6go44/D08fZTr6Okz3hpn
        4TogPbG0T+VVDlS9MXGFj7KquwA8+9NaNnyr/Siey4kSFb3E6sXrN3BVKEBk4dnBRsq2W+kznaQ8c
        JTKt3FFcVzpUajNhIDTP/xdqblaI9vW3GXQNuZmWfspkAyP3VBxxVu1QBfNnO0I0f3Vg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nmaiK-001Lyh-LP; Thu, 05 May 2022 14:36:12 +0200
Date:   Thu, 5 May 2022 14:36:12 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 7/7] net: phy: dp83td510: Add support for the
 DP83TD510 Ethernet PHY
Message-ID: <YnPEvKRfX23rRxcA@lunn.ch>
References: <20220505063318.296280-1-o.rempel@pengutronix.de>
 <20220505063318.296280-8-o.rempel@pengutronix.de>
 <20220505121241.GA19896@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505121241.GA19896@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 02:12:41PM +0200, Oleksij Rempel wrote:
> On Thu, May 05, 2022 at 08:33:18AM +0200, Oleksij Rempel wrote:
> > The DP83TD510E is an ultra-low power Ethernet physical layer transceiver
> > that supports 10M single pair cable.
> > 
> > This driver was tested with NXP SJA1105, STMMAC and ASIX AX88772B USB Ethernet
> > controller.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > +static int dp83td510_read_status(struct phy_device *phydev)
> > +{
> > +	u16 phy_sts;
> > +	int ret, cfg;
> 
> Heh, here is unused variable. Need to fix it.

Apart from that:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks for the rework, it made the driver much better.

    Andrew
