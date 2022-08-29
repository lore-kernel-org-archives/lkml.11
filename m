Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615A1ECAAD2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 13:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiH2Nsg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 09:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiH2Nse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:48:34 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBFF95ADD;
        Mon, 29 Aug 2022 06:48:32 -0700 (PDT)
Received: (Authenticated sender: maxime.chevallier@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3CA3D60005;
        Mon, 29 Aug 2022 13:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661780911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2m4rearj/dPqMVh35stfnUCu34jNVDpj9BgSbwCobk=;
        b=cpXFf8wJUloAz4AAGoNGaIWIp4VrUAQGNigvSUVKi3Vwf/94zpYwHxmhp/61KGjFgxcoYV
        7uZoBBYgyMgYT6OzhdOECeGJy+sgLNoguJFXkxPJ7XZJBHDVqQuX91BDgxIlnjutlPt2xC
        VGfxDbpcsVXKujKBs21hYFcnHpuKNAJmq9tQ08qIPmOMALcx41guL3kNadh6bvKeyJYe/W
        HNfJTEPLh51zonCCa3oDKwCRRzrCgYP+VermwY7uKrkPX376W1TnVEA4rHvyk7xanzMF3H
        R1uQtiwjdvhOT4u7Xoh9V7CqTmbJFdQjd/rCJFc80tewzac7kvU+bH6Bw6A1gw==
Date:   Mon, 29 Aug 2022 15:48:26 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH net-next v3 1/5] net: ipqess: introduce the Qualcomm
 IPQESS driver
Message-ID: <20220829154826.270b693e@pc-10.home>
In-Reply-To: <YwpwVd+qgM+RR8nh@lunn.ch>
References: <20220826154650.615582-1-maxime.chevallier@bootlin.com>
        <20220826154650.615582-2-maxime.chevallier@bootlin.com>
        <YwpwVd+qgM+RR8nh@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew, and thanks for the review

On Sat, 27 Aug 2022 21:28:21 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > +static void ipqess_get_strings(struct net_device *netdev, u32
> > stringset,
> > +			       u8 *data)
> > +{
> > +	u8 *p = data;
> > +	u32 i;
> > +
> > +	switch (stringset) {
> > +	case ETH_SS_STATS:
> > +		for (i = 0; i < ARRAY_SIZE(ipqess_stats); i++) {
> > +			memcpy(p, ipqess_stats[i].string,
> > +			       min((size_t)ETH_GSTRING_LEN,
> > +				   strlen(ipqess_stats[i].string)
> > + 1));  
> 
> That looks pretty similar to strlcpy().

Indeed... and after digging I even found ethtool_sprintf() which seems
to fit even better :)

> > +static int ipqess_get_settings(struct net_device *netdev,
> > +			       struct ethtool_link_ksettings *cmd)
> >  
> 
> It would be traditional to have the k in the name.
> 
> > +{
> > +	struct ipqess *ess = netdev_priv(netdev);
> > +
> > +	return phylink_ethtool_ksettings_get(ess->phylink, cmd);
> > +}
> > +
> > +static int ipqess_set_settings(struct net_device *netdev,
> > +			       const struct ethtool_link_ksettings
> > *cmd) +{  
> 
> Here too.

Agreed, I'll address that. Thanks !

Maxime
 
>      Andrew

