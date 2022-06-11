Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB2ECCA47A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jun 2022 15:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbiFKPMS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jun 2022 11:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiFKPMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 11:12:17 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D27E5E;
        Sat, 11 Jun 2022 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=exRU8msX6Y3QyHsCr7hN96t36OZdzWg/dTAY+I9xkAY=; b=Dx94jLIaFpDcAQfRCce7xl0Dzs
        GdriFDkiHlR+O00+UkNjjNFwdmeIy7V8lQEEE9NX7/khx7JHyZoYMmjfqKqjFXlR1/obmdac3s7Qa
        ch5K9aXrfr6HtDcw9SmYq5Hl0byXp+5gVtM4vH1faJn5AYPLGgii83qhirJjihWbYLp4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1o02mV-006WKA-4J; Sat, 11 Jun 2022 17:12:07 +0200
Date:   Sat, 11 Jun 2022 17:12:07 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] net: phy: dp83td510: add cable testing
 support
Message-ID: <YqSwx63kJQUlEVBH@lunn.ch>
References: <20220608123236.792405-1-o.rempel@pengutronix.de>
 <20220608123236.792405-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608123236.792405-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	} else {
> +		/* Most probably we have active link partner */
> +		stat = ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
> +	}

So drivers will make a few attempts to get a valid result. Have you
tried that?

> +
> +	*finished = true;
> +
> +	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A, stat);
> +
> +	/* Reset state machine, otherwise at least other TDR attempts may
> +	 * provide not reliable results.
> +	 */
> +	return phy_set_bits(phydev, MII_BMCR, BMCR_RESET);

I thought i made the comment that you should use the helper? The
helper will wait around for the bit to clear indicating the PHY is
ready for further configuration.

      Andrew
