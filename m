Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803F8C433FE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 02:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiCCC0M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 21:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiCCC0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:26:10 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8F55520C;
        Wed,  2 Mar 2022 18:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=yUceJcox2WM5GQXNG5jUmRNjg1E8B4XIv1l/QFUjdaU=; b=fvMVhlmfr9r4RbabSF5C00ZKPE
        DA5rOXuA5IGtzRjy8v43JVT+LOvrEZdAuDvhuKRpMPTwSbvfojGLAJzKgr6oCNQ9CHU3zkayrL52R
        OOkL43carAmR48mAVbXCXCBUrAlPXFrKr8BRjefiVpv7+/TaKIg7GEaK1/AxS9tNs0vI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nPb9R-00912y-6X; Thu, 03 Mar 2022 03:25:09 +0100
Date:   Thu, 3 Mar 2022 03:25:09 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2] net: dsa: qca8k: pack driver struct and
 improve cache use
Message-ID: <YiAnBbECC4ANIwCf@lunn.ch>
References: <20220228110408.4903-1-ansuelsmth@gmail.com>
 <20220303015327.k3fqkkxunm6kihjl@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303015327.k3fqkkxunm6kihjl@skbuf>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 03:53:27AM +0200, Vladimir Oltean wrote:
> On Mon, Feb 28, 2022 at 12:04:08PM +0100, Ansuel Smith wrote:
> > Pack qca8k priv and other struct using pahole and set the first priv
> > struct entry to mgmt_master and mgmt_eth_data to speedup access.
> > While at it also rework pcs struct and move it qca8k_ports_config
> > following other configuration set for the cpu ports.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> 
> How did you "pack" struct qca8k_priv exactly?

As far as i can see, nothing in qca8k_priv is on the hot path. So i
doubt anything changed here will make a difference. The MDIO bus is
the bottleneck, not the memory interface.

    Andrew
