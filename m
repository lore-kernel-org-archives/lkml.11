Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E3DC433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 15:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbiEIPQI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 11:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbiEIPP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:15:56 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BA115E624;
        Mon,  9 May 2022 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=pqsJDz6qnnvShqx1Sral3htZd6sOhUooH5JnGt+uNbA=; b=nl/ZNhhfBjpKQcfCiuuktzjyYF
        7hzJCoDh+Z4e21DuYXpsouSMiCAjGQFIO2m/d3/wkURLxL5MY46JA/QOEPbVsbAhoy62WXWD4qGUR
        cw/L0waUJLGU3WOMfPy/Dd8hMzm6G641/Yn+oonq7SI7tletQQubpJTfAa/2RUtRVrHg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1no535-001xeg-BT; Mon, 09 May 2022 17:11:47 +0200
Date:   Mon, 9 May 2022 17:11:47 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: phy: micrel: Fix incorret variable type in
 micrel
Message-ID: <YnkvM5iuSuAOqBg+@lunn.ch>
References: <20220509144519.2343399-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509144519.2343399-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 10:45:19PM +0800, Wan Jiabing wrote:
> In lanphy_read_page_reg, calling __phy_read() might return a negative
> error code. Use 'int' to check the error code.
> 
> Fixes: 7c2dcfa295b1 ("net: phy: micrel: Add support for LAN8804 PHY")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
