Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078B9C4332F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 01:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1840121AbiDFBHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 21:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457609AbiDEQQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:16:25 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FEF192A4;
        Tue,  5 Apr 2022 09:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=EObZra2J2DNF7JHX8kmn2YgRW16ruDFpBBD35pTDrEE=; b=2Bp/upSPrGCRvSAEjivuaeF5vI
        rUCBH9VZ+sO1MqFPoiuEsA+VeVx04f8KO4VLyltt0VmQanX8/uryVnLEFBWo2z8nUBKkf2Bjpgsyv
        QqPJIizyO/y4NyoIwUbrpOePuLNt0UKcpr49YLWH0miTWgq/g+KT2Q30R6knI0+USECg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nblop-00EGgz-K3; Tue, 05 Apr 2022 18:14:11 +0200
Date:   Tue, 5 Apr 2022 18:14:11 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH net] net: phy: marvell-88x2222: set proper phydev->port
Message-ID: <Ykxq0wx7eMiZCXgx@lunn.ch>
References: <20220405150305.151573-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405150305.151573-1-i.bornyakov@metrotek.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 06:03:05PM +0300, Ivan Bornyakov wrote:
> phydev->port was not set and always reported as PORT_TP.
> Set phydev->port according to inserted SFP module.

This is definitely something for Russell to review.

But i'm wondering if this is the correct place to do this? What about
at803x and marvell10g? It seems like this should be done once in the
core somewhere, not in each driver.

     Andrew
