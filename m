Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990CCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 16:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357894AbiDLQ6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 12:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiDLQ6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:58:12 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046D15F4E7;
        Tue, 12 Apr 2022 09:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=bGcwjLyjvl5dn6F/AAd6kF2H/xuD2//ppVdPFaXyoyw=; b=KfcVsXIP/D6eIxwwC6KK9WdnHe
        TnJHvsGANv3CumK3rrWWlTF2klyknbonBbGdKsLG0Rqcnf/EYkAYkkNxdMOmcQgK4FZq8zkE2GMQz
        7D0M2Au5tvriRvJ+LYd01jSfDFPp1yAq/Fepey1IFnnuy7fipxVLjA8DHK8MKJdz2ynk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1neJnw-00FUEg-Rb; Tue, 12 Apr 2022 18:55:48 +0200
Date:   Tue, 12 Apr 2022 18:55:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Arun Ramadoss <arun.ramadoss@microchip.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        UNGLinuxDriver@microchip.com
Subject: Re: [Patch net-next 1/3] net: phy: LAN937x: added
 PHY_POLL_CABLE_TEST flag
Message-ID: <YlWvFLU9TCPd+fC+@lunn.ch>
References: <20220412063317.4173-1-arun.ramadoss@microchip.com>
 <20220412063317.4173-2-arun.ramadoss@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412063317.4173-2-arun.ramadoss@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 12:03:15PM +0530, Arun Ramadoss wrote:
> Added the phy_poll_cable_test flag for the lan937x phy driver.
> Tested using command -  ethtool --cable-test <dev>
> 
> Signed-off-by: Arun Ramadoss <arun.ramadoss@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
