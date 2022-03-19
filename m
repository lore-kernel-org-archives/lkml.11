Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C282DC4332F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Mar 2022 00:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241634AbiCSAQD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 20:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiCSAQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 20:16:01 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0C1B246C;
        Fri, 18 Mar 2022 17:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=IPgIGRlVVbt8A06Re/ubCDTheHPnaj4pZqtit4kWpWE=; b=jmlO1ORBu3Jas7uVzeBKRc8pDT
        N+lDVStaMd3Nl1iCLuHCB+OELVtHFsuwl08czVqIGmmj7UsHuE16S4vXhiKAl0wKSTDiH9hOq51pZ
        bmWCXzpSsZ3TePz4Qe4xwbH+bOrayPON0UPNQg0ZLNTX0ozqlJ7FJE98PjTFrkY668Gg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nVMjj-00Bdp5-7r; Sat, 19 Mar 2022 01:14:27 +0100
Date:   Sat, 19 Mar 2022 01:14:27 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michael Walle <michael@walle.cc>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH net-next v3 2/3] net: mdio: mscc-miim: replace magic
 numbers for the bus reset
Message-ID: <YjUgYzXskLfQy0Fv@lunn.ch>
References: <20220318201324.1647416-1-michael@walle.cc>
 <20220318201324.1647416-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318201324.1647416-3-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 09:13:23PM +0100, Michael Walle wrote:
> Replace the magic numbers by macros which are already defined. It seems
> the original commit missed to use them.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
