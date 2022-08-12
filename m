Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954B1C00140
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Aug 2022 15:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbiHLPgn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Aug 2022 11:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiHLPgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:36:37 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4D352DF6;
        Fri, 12 Aug 2022 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=tZiCBSbwBqTOJKgCUdOCzKrZdzh7JNhfWJyMmmQhiSo=; b=Ud+hEThvKtIN5qh+Tft2LlJC6m
        NT3NWsrfDsQ2DxwF8+/BDPEDlagfe2x7BQXnaesnWF9bxuG4fM43OQXvRc6oP/C6gXZC1iLfEP4Xh
        SY4LYt9ZDcJF73akCViFPAqzbbNyTXzURUquw07S1eVZGpO90tURLCvZ4ofGWNWFkTx4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oMWi0-00D8uy-MD; Fri, 12 Aug 2022 17:36:24 +0200
Date:   Fri, 12 Aug 2022 17:36:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     wei.fang@nxp.com
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] dt: ar803x: Document disable-hibernation property
Message-ID: <YvZzeDaeHC0W7+Mh@lunn.ch>
References: <20220812145009.1229094-1-wei.fang@nxp.com>
 <20220812145009.1229094-2-wei.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812145009.1229094-2-wei.fang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2022 at 12:50:08AM +1000, wei.fang@nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The hibernation mode of Atheros AR803x PHYs is default enabled.
> When the cable is unplugged, the PHY will enter hibernation
> mode and the PHY clock does down. For some MACs, it needs the
> clock to support it's logic. For instance, stmmac needs the PHY
> inputs clock is present for software reset completion. Therefore,
> It is reasonable to add a DT property to disable hibernation mode.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/qca,ar803x.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/qca,ar803x.yaml b/Documentation/devicetree/bindings/net/qca,ar803x.yaml
> index b3d4013b7ca6..d08431d79b83 100644
> --- a/Documentation/devicetree/bindings/net/qca,ar803x.yaml
> +++ b/Documentation/devicetree/bindings/net/qca,ar803x.yaml
> @@ -40,6 +40,12 @@ properties:
>        Only supported on the AR8031.
>      type: boolean
>  
> +  qca,disable-hibernation:
> +    description: |
> +    If set, the PHY will not enter hibernation mode when the cable is
> +    unplugged.
> +    type: boolean

The description itself needs indenting 2 space.

I would suggest you do what the bot suggests and install the dtschema
tools.

	Andrew
