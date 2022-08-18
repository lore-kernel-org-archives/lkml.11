Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E79C32773
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Aug 2022 18:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344589AbiHRSJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 14:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbiHRSJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:09:12 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390EF2D1E1;
        Thu, 18 Aug 2022 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=4W/aoPf5GNNuTfMXQkzVTZJ9l4lhjOI8qy1yL9WshF8=; b=tvSGMJgXeSd26CcpK+LbxWkl7z
        DPMxTTW5ByIEXCbI9EzJ78G5kzxW1pRJE98SVAIbQjpMbQlCyiv/OGDFzvx3iWSRs/xbd6L2+KBm8
        y74tvVV3pQRRf7HZD1A2J6BGcHlXJZjnDP4YqQeMvFQb5bVxF2+CUn4OgM7T3PwUwbMc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oOjwy-00DovG-9J; Thu, 18 Aug 2022 20:09:00 +0200
Date:   Thu, 18 Aug 2022 20:09:00 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Camelia Alexandra Groza <camelia.groza@nxp.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Bhadram Varka <vbhadram@nvidia.com>
Subject: Re: [PATCH net] net: dpaa: Fix <1G ethernet on LS1046ARDB
Message-ID: <Yv6APO13Y5AessyQ@lunn.ch>
References: <20220818164029.2063293-1-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818164029.2063293-1-sean.anderson@seco.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 12:40:29PM -0400, Sean Anderson wrote:
> As discussed in commit 73a21fa817f0 ("dpaa_eth: support all modes with
> rate adapting PHYs"), we must add a workaround for Aquantia phys with
> in-tree support in order to keep 1G support working. Update this
> workaround for the AQR113C phy found on revision C LS1046ARDB boards.
> 
> Fixes: 12cf1b89a668 ("net: phy: Add support for AQR113C EPHY")
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Acked-by: Camelia Groza <camelia.groza@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
