Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BC1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 15:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbiEIQAg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 12:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238713AbiEIQAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:00:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1B2226886;
        Mon,  9 May 2022 08:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0WguLFeUBe7Wk0++99jTQ0bgKg9H2buPPHpI5INuNlg=; b=HYJJdKWmzJz2iYrdKnVLTSls2U
        03QLzUKgSCwBE3Eeyg3P6v2NR624iMFXViu9RgTKZtuxRnp7dK9OWsUvXlkhXtPrguUwMJRmDkhcY
        ZGcnmfRsP2Db+UBEV+Z+3MELI9AztxMVh+O1t/Dywjl1Vn/3gDF9f31++a06aMc5V7AhgfC52WNHL
        cfWPL7bKWIXJ0I0MHC06g/8ysklIGPPfJsHP/OF2/QAmpzULfsrC9AMBb17cA/Mi9gvjacejNaV3a
        Q+DI0YqTxH4Xi7rLFWN3u5KehoTOjJiBWzROtHp5o0v3snMT0Ou7ppppa8rX4KExvMIf0j0N4/4V2
        lCSvLwLQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60648)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1no5kM-0003In-Bi; Mon, 09 May 2022 16:56:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1no5kL-0005EF-5S; Mon, 09 May 2022 16:56:29 +0100
Date:   Mon, 9 May 2022 16:56:29 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: micrel: Fix incorret variable type in micrel
Message-ID: <Ynk5rc4/MrmBwBNP@shell.armlinux.org.uk>
References: <20220509134951.2327924-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509134951.2327924-1-wanjiabing@vivo.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please correct the spelling error of "incorrect" in the subject line.
Thanks.


On Mon, May 09, 2022 at 09:49:51PM +0800, Wan Jiabing wrote:
> In lanphy_read_page_reg, calling __phy_read() might return a negative
> error code. Use 'int' to check the negative error code.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/net/phy/micrel.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index a06661c07ca8..c34a93403d1e 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -1959,7 +1959,7 @@ static int ksz886x_cable_test_get_status(struct phy_device *phydev,
>  
>  static int lanphy_read_page_reg(struct phy_device *phydev, int page, u32 addr)
>  {
> -	u32 data;
> +	int data;
>  
>  	phy_lock_mdio_bus(phydev);
>  	__phy_write(phydev, LAN_EXT_PAGE_ACCESS_CONTROL, page);
> @@ -2660,8 +2660,7 @@ static int lan8804_config_init(struct phy_device *phydev)
>  
>  static irqreturn_t lan8814_handle_interrupt(struct phy_device *phydev)
>  {
> -	u16 tsu_irq_status;
> -	int irq_status;
> +	int irq_status, tsu_irq_status;
>  
>  	irq_status = phy_read(phydev, LAN8814_INTS);
>  	if (irq_status > 0 && (irq_status & LAN8814_INT_LINK))
> -- 
> 2.36.0
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
