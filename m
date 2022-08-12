Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69ADC25B08
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Aug 2022 14:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbiHLOQP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Aug 2022 10:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbiHLOPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:15:46 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBC622503;
        Fri, 12 Aug 2022 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=rhDpZQV7N5DyWCkzMowtGqMevTG9o2l5FtKTviLFUJA=; b=nWp+qc56gZkWjeRkFi7bz4D66a
        CSaYpGqpxney/hB+j+wlXkqtmcK29uGN00bA6rRAMd7LAfoXh8nSedsoPYXSlH6q+nDosU9kvZHDa
        s0GUB+44558l7JPvkcM9FggXeCgD4Aw2zhlTtyn8983gFi4a0QnqaKL3Iu8g7dOxmGsk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oMVRg-00D8ZY-QK; Fri, 12 Aug 2022 16:15:28 +0200
Date:   Fri, 12 Aug 2022 16:15:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     wei.fang@nxp.com
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] dt: ar803x: Document disable-hibernation property
Message-ID: <YvZggGkdlAUuQ1NG@lunn.ch>
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

It is not the first time we have seen this. What you should really be
concentrating on is the clock out. That is what the MAC requires here.

You already have the property qca,clk-out-frequency. You could maybe
piggy back off this. If that property is being used, you know the
clock output is used. So you should do what is needed to keep it
ticking.

You also have qca,keep-pll-enabled:

      If set, keep the PLL enabled even if there is no link. Useful if you
      want to use the clock output without an ethernet link.

To me, it seems like you already have enough properties, you just need
to imply that you need to disable hibernation in order to fulfil these
properties.

	Andrew
