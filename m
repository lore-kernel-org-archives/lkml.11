Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D8AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 13:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354091AbiDONkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 09:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354101AbiDONkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:40:24 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E518BE12;
        Fri, 15 Apr 2022 06:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=BOAhwHUPSM+JCjTiYm2spjP9JaC7ZzVEZgiYumkURbk=; b=TbkE71iHLRmKz6slCznm3IDV3g
        wn5AddDaxIz0BilXV5zBOCzeaF+d4DENi7hrRmgasOe3nqsdLRjx6d4mcMji+r9uDMvyBSULSC9np
        hGWYkSa406fW5bNA9dpgoj5n28mBef/XJieNIpwsmeZEtyH68Xq2kn3eYYRgnps4PUtA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nfM8o-00FyVp-3q; Fri, 15 Apr 2022 15:37:38 +0200
Date:   Fri, 15 Apr 2022 15:37:38 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 07/12] net: dsa: rzn1-a5psw: add statistics
 support
Message-ID: <Yll1IsIYKHC/n+sg@lunn.ch>
References: <20220414122250.158113-1-clement.leger@bootlin.com>
 <20220414122250.158113-8-clement.leger@bootlin.com>
 <YlirO7VrfyUH33rV@lunn.ch>
 <20220415140402.76822543@fixe.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415140402.76822543@fixe.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +static void a5psw_get_ethtool_stats(struct dsa_switch *ds, int port,
> > > +				    uint64_t *data)
> > > +{
> > > +	struct a5psw *a5psw = ds->priv;
> > > +	u32 reg_lo, reg_hi;
> > > +	unsigned int u;
> > > +
> > > +	for (u = 0; u < ARRAY_SIZE(a5psw_stats); u++) {
> > > +		/* A5PSW_STATS_HIWORD is global and thus, access must be
> > > +		 * exclusive
> > > +		 */  
> > 
> > Could you explain that a bit more. The RTNL lock will prevent two
> > parallel calls to this function.
> 
> Ok, I wasn't sure of the locking applicable here.

In general, RTNL protects you for any user space management like
operation on the driver. In this case, if you look in net/ethtool, you
will find the IOCTL handler code takes RTNL before calling into the
main IOCTL dispatcher. If you want to be paranoid/document the
assumption, you can add an ASSERT_RTNL().

The semantics for some of the other statistics Vladimir requested can
be slightly different. One of them is in atomic context, because a
spinlock is held. But i don't remember if RTNL is also held. This is
less of an issue for your switch, since it uses MMIO, however many
switches need to perform blocking IO over MDIO, SPI, IC2 etc to get
stats, which you cannot do in atomic context. So they end up returning
cached values.

Look in the mailing list for past discussion for details.

    Andrew
