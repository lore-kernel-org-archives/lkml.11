Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AC9C43334
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jun 2022 09:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiFZJQn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jun 2022 05:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiFZJQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:16:41 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8435412D3E;
        Sun, 26 Jun 2022 02:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=1gzj5oIHVtFlpBvDQAUEEcqsXk12AVODco7VgEIoQf8=; b=AZer2m1ttmyhsW7HUqwAleQ8dx
        XZYv8v4i/jV1WWmk/LMtxP+PaiZNdy6Kmb24Oz6LDeWuSE3k2DNrNE2cC4bBH15trYS1++n8nkSh+
        02CXBYT5KFWqbt52oWsbqCxl2eea1tYsrBtg8qQb8fo535rTrxjdC31OEfTYkQlHn1LU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1o5ONF-008HVF-32; Sun, 26 Jun 2022 11:16:09 +0200
Date:   Sun, 26 Jun 2022 11:16:09 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     alexandru.tachici@analog.com
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gerhard@engleder-embedded.com,
        geert+renesas@glider.be, joel@jms.id.au, stefan.wahren@i2se.com,
        wellslutw@gmail.com, geert@linux-m68k.org, robh+dt@kernel.org,
        d.michailidis@fungible.com, stephen@networkplumber.org,
        l.stelmach@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [net-next 1/2] net: ethernet: adi: Add ADIN1110 support
Message-ID: <Yrgj2WM5/O7YSUeZ@lunn.ch>
References: <20220624200628.77047-1-alexandru.tachici@analog.com>
 <20220624200628.77047-2-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624200628.77047-2-alexandru.tachici@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int adin1110_mdio_read(struct mii_bus *bus, int phy_id, int reg)
> +{
> +	struct adin1110_priv *priv = bus->priv;
> +	u32 val = 0;
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +
> +	val |= FIELD_PREP(ADIN1110_MDIO_OP, ADIN1110_MDIO_OP_RD);
> +	val |= FIELD_PREP(ADIN1110_MDIO_ST, 0x1);
> +	val |= FIELD_PREP(ADIN1110_MDIO_PRTAD, phy_id);
> +	val |= FIELD_PREP(ADIN1110_MDIO_DEVAD, reg);
> +
> +	/* write the clause 22 read command to the chip */

Please return -EOPNOTSUPP if asked to do a C45 transfer.

> +static int adin1110_mdio_write(struct mii_bus *bus, int phy_id, int reg, u16 reg_val)
> +{
> +	struct adin1110_priv *priv = bus->priv;
> +	u32 val = 0;
> +	int ret;

same here.

     Andrew
