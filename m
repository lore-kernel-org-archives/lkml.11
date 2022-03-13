Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6335C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Mar 2022 15:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiCMPNC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Mar 2022 11:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiCMPMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 11:12:42 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676A58A308;
        Sun, 13 Mar 2022 08:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=odpq/6C/ci3tUnN9Bq31NutxIHpLW0ghl7LCm+IC2h8=; b=eUq1ETvX1riNMDWQiG7snzW2ZA
        YukKr9C7fuD62cF8Uv8g0mBTLvRpb8FJJgSakWjY2TaEPw8X8QGM1klkKvPBKxoY+0KrZsYkQTGPp
        qpmwBUWbAvlltVE8PJabBGbx6SXAZtiXXBCrTe2aRjg+0BZxEhmgvFPukaCgiZP8nMYA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nTPs8-00AdHZ-0i; Sun, 13 Mar 2022 16:11:04 +0100
Date:   Sun, 13 Mar 2022 16:11:04 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michael Walle <michael@walle.cc>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Foster <colin.foster@in-advantage.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mdio: mscc-miim: fix duplicate debugfs entry
Message-ID: <Yi4JiGzFPkNL8P3w@lunn.ch>
References: <20220312224140.4173930-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220312224140.4173930-1-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 11:41:40PM +0100, Michael Walle wrote:
> This driver can have up to two regmaps. If the second one is registered
> its debugfs entry will have the same name as the first one and the
> following error will be printed:
> 
> [    3.833521] debugfs: Directory 'e200413c.mdio' with parent 'regmap' already present!
> 
> Give the second regmap a name to avoid this.
> 
> Fixes: a27a76282837 ("net: mdio: mscc-miim: convert to a regmap implementation")
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
