Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927D7C4167E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 20:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346385AbiC1Usg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 16:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346495AbiC1UpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:45:16 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A5EA18F;
        Mon, 28 Mar 2022 13:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=PVRdwLRjbdaCvrvFVMElpF1SE8OywHiiQwb+mQwE81s=; b=qWapL4vKx4xwxmY09OrhllQm6L
        BU1dDFYxJsD5tKND/6b+wQ3Aym8PGQ5Bam6kelQ7+mzYRc3h4I696m1e2DXKbUt5hDDrRTHVH39++
        y5VXmy60nj4chA4+9DQtcph/1RD8vEXdSAjOfeBciXG+CW7MGeyBeXJlUq7BZljC3EZk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nYwCs-00D4Cm-4L; Mon, 28 Mar 2022 22:43:18 +0200
Date:   Mon, 28 Mar 2022 22:43:18 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michael Walle <michael@walle.cc>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: lan966x: fix kernel oops on ioctl when I/F is
 down
Message-ID: <YkId5ssdyHH8JZ64@lunn.ch>
References: <1ee5aec079e3eefff8475017ff1044bf@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ee5aec079e3eefff8475017ff1044bf@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > So rather than testing of running, it would be better to test if the
> > phydev is NULL or not.
> 
> What about the following:
> 
> static int lan966x_port_ioctl(struct net_device *dev, struct ifreq *ifr,
> 			     int cmd)
> {
> 	struct lan966x_port *port = netdev_priv(dev);
> 
> 	if (!phy_has_hwtstamp(dev->phydev) && port->lan966x->ptp) {
> 		switch (cmd) {
> 		case SIOCSHWTSTAMP:
> 			return lan966x_ptp_hwtstamp_set(port, ifr);
> 		case SIOCGHWTSTAMP:
> 			return lan966x_ptp_hwtstamp_get(port, ifr);
> 		}
> 	}
> 
> 	if (!dev->phydev)
> 		return -ENODEV;
> 
> 	return phy_mii_ioctl(dev->phydev, ifr, cmd);

Yes, that is good.

     Andrew
