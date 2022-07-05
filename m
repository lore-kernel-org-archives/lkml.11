Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830F4C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 15:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiGEPPG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 11:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiGEPPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:15:04 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B6317A93;
        Tue,  5 Jul 2022 08:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=nYnoNRTdWkWiBqUgebCUS/PFXM8VPA/L3IkdWUEJjnc=; b=4sqOuWtNQYjMieKgStIO7ztR6W
        pkzOhJMPxDiN0eZ2SabAf/3AkALWaS3HgkSDww2QVrqPIDh99X0JIRJiJ03mj9w9G2IWRwroaQ0kQ
        9O465FyzibELkOLTru/lYRmVyDrWPfhHbj44rZAZJbrqXlbKrSwFb745lxUKr6m+FwtM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1o8kG9-009NYb-4v; Tue, 05 Jul 2022 17:14:41 +0200
Date:   Tue, 5 Jul 2022 17:14:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Divya Koppera <Divya.Koppera@microchip.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Madhuri.Sripada@microchip.com
Subject: Re: [PATCH net-next] net: phy: micrel: Fix latency issues in LAN8814
 PHY
Message-ID: <YsRVYeObzgMwry2T@lunn.ch>
References: <20220705110554.5574-1-Divya.Koppera@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705110554.5574-1-Divya.Koppera@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 04:35:54PM +0530, Divya Koppera wrote:
> Latency adjustments done for 1-step and 2-step
> from default latency register values to fix negative
> and high mean path delays.

You forgot to Cc: the PTP maintainer.

Doesn't this change break user space tools which have already measured
the latency and is doing a correction?

    Andrew
