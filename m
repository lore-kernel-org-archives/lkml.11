Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F88C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 15:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiCIP6T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 10:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiCIP6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:58:16 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C0113C26F;
        Wed,  9 Mar 2022 07:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=qW2VCBDnPQYpT6M3ugNgUmJT+AvAVhZfE5koYfv1Ils=; b=qtWwj8LPMb2Nt+HIeRqBcFJtoE
        cBebLsfftvs8n04bEm+nJPNmPp6Cp0GXb4OM+z4qiF3Mdq6CE/Ev5Gk9p7YAw9EZ74KDgA5zhj5GE
        CJYwJ74HxVGGsQsXDReDRe2SUa0mkTJnxXKPBuWsKjLEgqXXMiKuwt05h095e9dZRUs4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nRygQ-009z8C-Nn; Wed, 09 Mar 2022 16:57:02 +0100
Date:   Wed, 9 Mar 2022 16:57:02 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, paskripkin@gmail.com
Subject: Re: net: asix: best way to handle orphan PHYs
Message-ID: <YijOTgDA95c3uaTl@lunn.ch>
References: <20220309121835.GA15680@pengutronix.de>
 <YiisJogt/WO5gLId@lunn.ch>
 <20220309144523.GE15680@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309144523.GE15680@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> EEPROM provides information, which PHY address should be used. If
> address is 0x10, it is internal PHY. Different parts of ASIX driver use
> this logic.

O.K, so the solution should be generic, unless there are devices with
bad EEPROM content.

> Ok, so if phy_suspend() is the preffered way, I need to get phydev
> without attaching it. Correct? Do we already have some helpers to do it?

mdiobus_get_phy() will get you the phydev is you know the bus and the
address.

	Andrew
