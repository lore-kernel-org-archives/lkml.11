Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D9AC433FE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 12:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbiEEMhY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 08:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377442AbiEEMhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:37:07 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6C555370;
        Thu,  5 May 2022 05:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=PvUfcZu3+OIYxxgafBIRO0yfRoqLT4xn7hrHgOjuIWU=; b=WwsgmAHfjiW6iu6vVNsXp7w3I3
        IjENS7wxFefoINmYixEyOkK/dGIdDcVmL5yteYo3LPuSHzjRqeuFUmaTxV/fFyN4FP5tF8YrX0ps6
        CMsZHE89uRxmmnY/2akxM8S6EnN6pyau72k3W7DOJSB00a3Dy3waLTRgzq8ch8Udg2Ew=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nmafW-001Lvz-Oq; Thu, 05 May 2022 14:33:18 +0200
Date:   Thu, 5 May 2022 14:33:18 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/7] net: phy:
 genphy_c45_pma_baset1_read_master_slave: read actual configuration
Message-ID: <YnPEDmoW+lmM6rmw@lunn.ch>
References: <20220505063318.296280-1-o.rempel@pengutronix.de>
 <20220505063318.296280-6-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505063318.296280-6-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 08:33:16AM +0200, Oleksij Rempel wrote:
> Since MDIO_PMA_PMD_BT1_CTRL register shows actual configuration (and
> forced state configuration is equal to the state), we should show
> this configuration for ethtool.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
