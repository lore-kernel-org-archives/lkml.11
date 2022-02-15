Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B8AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 12:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbiBOMPB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 07:15:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiBOMO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:14:59 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEBF1074C8;
        Tue, 15 Feb 2022 04:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Bs8klJwTLBDrvOVFtUAi+wX0579+9qYln0qvbgucQxU=; b=kNOkfgULpIWj99EbMjYsAtK/ER
        2k8hgD8HcmXdPG/f5f3jKawpdoJTKDOVK/fBPHAmX0FOID7w5KbFJ1N+MqhLEuobMCJsNX4OqK1Y3
        SLmZwN/EJ4YBUxE91kezOy2wVEvqO+rDmTfL4ScUoJX+UNn5+yMEJhXzD3UaWfUwanJw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nJwj3-00655L-Hw; Tue, 15 Feb 2022 13:14:33 +0100
Date:   Tue, 15 Feb 2022 13:14:33 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] net: dsa: lantiq_gswip: fix use after free in
 gswip_remove()
Message-ID: <YguZKd6F2CNWdhLX@lunn.ch>
References: <1644921768-26477-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644921768-26477-1-git-send-email-khoroshilov@ispras.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 01:42:48PM +0300, Alexey Khoroshilov wrote:
> of_node_put(priv->ds->slave_mii_bus->dev.of_node) should be
> done before mdiobus_free(priv->ds->slave_mii_bus).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Fixes: 0d120dfb5d67 ("net: dsa: lantiq_gswip: don't use devres for mdiobus")

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
