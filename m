Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20355C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 06:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbiFTGq5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 02:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbiFTGqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:46:53 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76EF290;
        Sun, 19 Jun 2022 23:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=A2WROcb7Qxyl2Mskb2fLVaUscol1a36e8XmYAc3J46I=; b=kkVBh6cUCfmAnJaxhGCDF9wb4r
        2AuLR7hYDyCBIPI3sh7S65rfNg/48t/r70TCICEnoivH6M5LyeLD9O7YilJhH7NFoIOncRAnfuuzZ
        W2gme0sIaGS5tzlJ14hZ+LhqEj7dPjGBTs1Y4nmJnO/Zjt70TNsdCqzyaRPA9NNSPneY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1o3BAk-007aK9-Jn; Mon, 20 Jun 2022 08:46:06 +0200
Date:   Mon, 20 Jun 2022 08:46:06 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Frank <Frank.Sae@motor-comm.com>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, yinghong.zhang@motor-comm.com,
        fei.zhang@motor-comm.com, hua.sun@motor-comm.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net: phy: Add driver for Motorcomm yt8521 gigabit
 ethernet phy
Message-ID: <YrAXrt/6+Gskf+Sn@lunn.ch>
References: <20220620023621.1852-1-Frank.Sae@motor-comm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620023621.1852-1-Frank.Sae@motor-comm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -1,15 +1,112 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Driver for Motorcomm PHYs
> + * motorcomm.c: Motorcomm 8511/8521 PHY driver.
>   *
> - * Author: Peter Geis <pgwipeout@gmail.com>
> + * Author: Frank <Frank.Sae@motor-comm.com>

Please don't remove Peter, he still authored some of the code.

> +#define YTPHY_KERNEL_DRIVER_VERSION		"1.0.47"

Version numbers are meaningless since you also need to know the kernel
version it is embedded in. Please remove.

> -MODULE_DESCRIPTION("Motorcomm PHY driver");
> -MODULE_AUTHOR("Peter Geis");
> +MODULE_DESCRIPTION("Motorcomm 8511/8521 PHY driver");
> +MODULE_AUTHOR("Frank");
>  MODULE_LICENSE("GPL");
> +MODULE_VERSION(YTPHY_KERNEL_DRIVER_VERSION);

Same comments as above.

I have more comments, they will come later today hopefully.

  Andrew
