Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF7EC4332F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 14:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239712AbiESO2U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 10:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbiESO2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:28:18 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB0266ACF;
        Thu, 19 May 2022 07:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=dceFmCzIuiCcP5wjFfn/yD7Fkn2zWgT79IgEeu48Yi0=; b=b1Nrjuass/+FK8zHD3AIL1ECm/
        obo77XUp7+TJsL3t/I2yMs52kIqRd8QD6T9T2TjHxo8V8LmdX4aSRXP3Y555VTwfNuNtYl9kkhaHS
        NXurg3TofCsoFwWUEW4qdYNIrtIbxV5WGhqGcvAl1PtukDXwCSDmzAjrqdssLPfb0BCc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nrh8P-003UvM-5o; Thu, 19 May 2022 16:28:13 +0200
Date:   Thu, 19 May 2022 16:28:13 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Richard Cochran <richardcochran@gmail.com>,
        Horatiu.Vultur@microchip.com, Allan.Nielsen@microchip.com,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 4/6] net: phy: Add support for inband extensions
Message-ID: <YoZT/QMLiWVVctKx@lunn.ch>
References: <20220519135647.465653-1-maxime.chevallier@bootlin.com>
 <20220519135647.465653-5-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519135647.465653-5-maxime.chevallier@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int phy_set_inband_ext(struct phy_device *phydev, u32 mask, u32 ext)
> +{

> +/*
> + * TODO : Doc
> + */
> +enum {
> +	__PHY_INBAND_EXT_PCH = 0,
> +};

I'm not so happy with this API passing masks and values, when you are
actually dealing with a feature which is a boolean, exists, does not
exist.

> +int phy_inband_ext_enable(struct phy_device *phydev, u32 ext);
> +int phy_inband_ext_disable(struct phy_device *phydev, u32 ext);

I would prefer enum phy_inband_ext ext;

phy_inband_ext_set_available(struct phy_device *phydev, enum phy_inband_ext ext);

and add

phy_inband_ext_set_unavailable(struct phy_device *phydev, enum phy_inband_ext ext);

Internally you can then turn these into operations on a u32.

	   Andrew
