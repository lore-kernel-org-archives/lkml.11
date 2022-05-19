Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6750C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 19:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244337AbiESTCt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 15:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244411AbiESTCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:02:33 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486D166ACC;
        Thu, 19 May 2022 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=gcLhqH8l0QhaZQ3ExBnh7BQlfv3pT3Vbtm4El0QfRug=; b=WCeeD031Pgw5BpUlOxTy2DQ9oD
        baFXgxmaZ5TaVLSc4rvHr+D/GXsmG3AMKYCtepq2c324MbS1OuscRLWpPJyth1VeUlElEq7DS7NW7
        U/6a4W5TBbSVYJSYtdsdv9wmZV1boehAcDqCkBm82NmO0Rwf5sHQZbRCVL8yA/cOHOSY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nrlPi-003X3Y-Rr; Thu, 19 May 2022 21:02:22 +0200
Date:   Thu, 19 May 2022 21:02:22 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     michael@amarulasolutions.com, alberto.bianchi@amarulasolutions.com,
        linux-amarula@amarulasolutions.com, linuxfancy@googlegroups.com,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: phy: DP83822: enable rgmii mode if
 phy_interface_is_rgmii
Message-ID: <YoaUPvwccJZ6vT/S@lunn.ch>
References: <20220519185057.1657115-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519185057.1657115-1-tommaso.merciai@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 08:50:56PM +0200, Tommaso Merciai wrote:
> RGMII mode can be enable from dp83822 straps, and also writing bit 9
> of register 0x17 - RMII and Status Register (RCSR).
> When phy_interface_is_rgmii rgmii mode must be enabled, same for
> contrary, this prevents malconfigurations of hw straps
> 
> References:
>  - https://www.ti.com/lit/gpn/dp83822i p66
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Suggested-by: Alberto Bianchi <alberto.bianchi@amarulasolutions.com>
> Tested-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> ---
> Changes since v1:
>  - Improve commit msg
>  - Add definition of bit 9 reg rcsr (rgmii mode en)
>  - Handle case: phy_interface_is_rgmii is false

Please don't post a new version for at least 24 hours. Give people
time to review the code and make comments.

     Andrew
