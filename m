Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFB9C32772
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Aug 2022 01:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242555AbiHRBU0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 21:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiHRBUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:20:21 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3069F9C2D4;
        Wed, 17 Aug 2022 18:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=1wjNnEeWUlQ11d/DDSaV1am9RVfAubnHe8nnYNJpOAw=; b=miOb4XZuseYEdMTWbsL+Kt8p38
        lSKwWOMnNOj26DexFexCKZY/z4OQTmdQmoqUX80Y98C6xn3zfRspyUoA7NMduLU9P0rr4AsftzTrZ
        1QXm7X2wI2/rDn2VhMVNApabtaq39PMeeb629xgLdEJycITLY62uhEcK8ZuI7zkM+a70=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oOUCY-00DgZC-7A; Thu, 18 Aug 2022 03:20:02 +0200
Date:   Thu, 18 Aug 2022 03:20:02 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/2] dt: ar803x: Document disable-hibernation property
Message-ID: <Yv2TwkThceuU+m5l@lunn.ch>
References: <20220812145009.1229094-1-wei.fang@nxp.com>
 <20220812145009.1229094-2-wei.fang@nxp.com>
 <YvZggGkdlAUuQ1NG@lunn.ch>
 <DB9PR04MB8106F2BFD8150A1C76669F9C88689@DB9PR04MB8106.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR04MB8106F2BFD8150A1C76669F9C88689@DB9PR04MB8106.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Andrew,
> 
> 	Your suggestion is indeed an effective solution, but I checked both the datasheet
> and the driver of AR803x PHYs and found that the qca,clk-out-frequency and the
> qca,keep-pll-enabled properties are associated with the CLK_25M pin of AR803x PHYs.
> But there is a case that CLK_25M pin is not used on some platforms.
> Taking our i.MX8DXL platform as an example, the stmmac and AR8031 PHY are applied
> on this platform, but the CLK_25M pin of AR8031 is not used. So when I used the method
> you mentioned above, it did not work as expected. In this case, we can only disable the
> hibernation mode of AR803x PHYs and keep the RX_CLK always outputting a valid clock
> so that the stmmac can complete the software reset operation.

What happens to the RX_CLK when you unplug the cable? It is no longer
receiving anything, so i would expect the RX_CLK to stop ticking. Does
that cause problems for the MAC?

     Andrew
