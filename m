Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BACDC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 12:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347140AbiCUMNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 08:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347256AbiCUMM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:12:59 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8631F35271;
        Mon, 21 Mar 2022 05:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=wfPqTrMLZmI62s7w5pDJOhr0oJWgwZyXFkacCjOAFtg=; b=S8EhJW9bc1yCRidAUH8gazE1IQ
        tPFmz4auIwvdRcZ2vgyddW+hz3/QfSTWPC8gCVlEDmU5C7a7L/6Upx1AoKFU8rAFH7jzdvZkQELzv
        9TPFPM2fQi/Yc5MRRE9B/UCIVcL4F052ICKlQoQzo7TGU87X5j7R0GuJVOCWRodjiANk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nWGsE-00BwHU-Tb; Mon, 21 Mar 2022 13:10:58 +0100
Date:   Mon, 21 Mar 2022 13:10:58 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Dylan Hung <dylan_hung@aspeedtech.com>
Cc:     robh+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH 0/2] Add reset deassertion for Aspeed MDIO
Message-ID: <YjhrUrXzLxvKtDP8@lunn.ch>
References: <20220321070131.23363-1-dylan_hung@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321070131.23363-1-dylan_hung@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 03:01:29PM +0800, Dylan Hung wrote:
> Add missing reset deassertion for Aspeed MDIO. There are 4 MDIOs
> embedded in Aspeed AST2600 and share one reset control bit SCU50[3].

Is the reset limited to the MDIO bus masters, or are PHYs one the bus
potentially also reset?

Who asserts the reset in the first place? Don't you want the first
MDIO bus to probe to assert and then deassert the reset in order that
all the hardware is reset?

    Andrew
