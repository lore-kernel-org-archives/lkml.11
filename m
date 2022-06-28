Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43111C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 07:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245594AbiF1Hu7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 03:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245504AbiF1Hu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:50:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A0210EC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:50:55 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1o65zg-0003iD-3b; Tue, 28 Jun 2022 09:50:44 +0200
Message-ID: <897594cde5f294f9d5e96917bce1ac751338d0aa.camel@pengutronix.de>
Subject: Re: [PATCH net v1 1/2] net: asix: fix "can't send until first
 packet is send" issue
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Anton Lundin <glance@acc.umu.se>, Lukas Wunner <lukas@wunner.de>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        netdev@vger.kernel.org
Date:   Tue, 28 Jun 2022 09:50:42 +0200
In-Reply-To: <20220628044913.GB13092@pengutronix.de>
References: <20220624075139.3139300-1-o.rempel@pengutronix.de>
         <20220628044913.GB13092@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij,

subject of this patch looks strange. It should probably read "can't
receive until first packet is sent".

Regards,
Lucas

Am Dienstag, dem 28.06.2022 um 06:49 +0200 schrieb Oleksij Rempel:
> On Fri, Jun 24, 2022 at 09:51:38AM +0200, Oleksij Rempel wrote:
> > If cable is attached after probe sequence, the usbnet framework would
> > not automatically start processing RX packets except at least one
> > packet was transmitted.
> > 
> > On systems with any kind of address auto configuration this issue was
> > not detected, because some packets are send immediately after link state
> > is changed to "running".
> > 
> > With this patch we will notify usbnet about link status change provided by the
> > PHYlib.
> > 
> > Fixes: e532a096be0e ("net: usb: asix: ax88772: add phylib support")
> > Reported-by: Anton Lundin <glance@acc.umu.se>
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> In different mail thread Anton reported as tested.
> Tested-by: Anton Lundin <glance@acc.umu.se>
> 
> > ---
> >  drivers/net/usb/asix_common.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
> > index 632fa6c1d5e3..b4a1b7abcfc9 100644
> > --- a/drivers/net/usb/asix_common.c
> > +++ b/drivers/net/usb/asix_common.c
> > @@ -431,6 +431,7 @@ void asix_adjust_link(struct net_device *netdev)
> >  
> >  	asix_write_medium_mode(dev, mode, 0);
> >  	phy_print_status(phydev);
> > +	usbnet_link_change(dev, phydev->link, 0);
> >  }
> >  
> >  int asix_write_gpio(struct usbnet *dev, u16 value, int sleep, int in_pm)
> > -- 
> > 2.30.2
> > 
> > 
> 


