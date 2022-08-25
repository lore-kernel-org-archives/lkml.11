Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EB6ECAA25
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 18:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243577AbiHYS5A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 14:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243449AbiHYS45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:56:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9016DBD17D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:56:56 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1oRI20-0004Hp-Pp; Thu, 25 Aug 2022 20:56:44 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1oRI1y-0007Sw-6r; Thu, 25 Aug 2022 20:56:42 +0200
Date:   Thu, 25 Aug 2022 20:56:42 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        kernel test robot <lkp@intel.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        David Jander <david@protonic.nl>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH net-next v2 6/7] ethtool: add interface to interact with
 Ethernet Power Equipment
Message-ID: <20220825185642.GB2116@pengutronix.de>
References: <20220825130211.3730461-1-o.rempel@pengutronix.de>
 <20220825130211.3730461-7-o.rempel@pengutronix.de>
 <20220825110756.6361fff7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220825110756.6361fff7@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 11:07:56AM -0700, Jakub Kicinski wrote:
> On Thu, 25 Aug 2022 15:02:10 +0200 Oleksij Rempel wrote:
> > +void ethtool_set_ethtool_pse_ops(const struct ethtool_pse_ops *ops)
> > +{
> > +	rtnl_lock();
> > +	ethtool_pse_ops = ops;
> > +	rtnl_unlock();
> > +}
> > +EXPORT_SYMBOL_GPL(ethtool_set_ethtool_pse_ops);
> 
> Do we really need the loose linking on the PSE ops?
> It's not a lot of code, and the pcdev->ops should be 
> enough to decouple drivers, it seems.

Right now i have no good idea how to properly decouple pse-pd from phydev.

@Andrew, should i care about it on this stage or it is currently not a
big deal?

> > +static int pse_set_pse_config(struct net_device *dev,
> > +			      struct netlink_ext_ack *extack,
> > +			      struct nlattr **tb)
> > +{
> > +	struct phy_device *phydev = dev->phydev;
> > +	struct pse_control_config config = {};
> > +	const struct ethtool_pse_ops *ops;
> > +	int ret;
> > +
> > +	if (!tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL])
> > +		return 0;
> 
> If SET has no useful attrs the usual response is -EINVAL.

ack

> > +	ops = ethtool_pse_ops;
> > +	if (!ops || !ops->set_config)
> > +		return -EOPNOTSUPP;
> > +
> > +	config.admin_cotrol = nla_get_u8(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
> > +
> > +	if (!phydev)
> > +		return -EOPNOTSUPP;
> > +
> > +	// todo resolve phydev dependecy
> 
> My lack of phydev understanding and laziness are likely the cause,
> but I haven't found an explanation for this todo. What is it about?

sorry. old artifact, will be removed. It is part of phydev/phylink
related discussion in the last patch version.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
