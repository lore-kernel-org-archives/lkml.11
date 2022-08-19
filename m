Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868E7C32772
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 12:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349119AbiHSMuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 08:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348843AbiHSMum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:50:42 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2056CD7420;
        Fri, 19 Aug 2022 05:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=fr7QhwkLwW6Fg6KpvaCA3xcPZXCiv8cagCz8y0W6tfU=; b=vn/10w0ZffFTAgGrt9HcUXwWhm
        CXp0/SpdRITOdrUWFA18C156SubgIE/UpY5jKpPEqW65QQGIavky6LtT9idbPom4fh3bqJZXKenjs
        h6BQ12S9MEm/+1f3XVjYsEcZwCCXlLHBxXcUH4Q1K/9XhhVp774o/+d/Et3ITg3KbN+E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oP1SJ-00Dui5-Df; Fri, 19 Aug 2022 14:50:31 +0200
Date:   Fri, 19 Aug 2022 14:50:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     wei.fang@nxp.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: tja11xx: add interface mode and
 RMII REF_CLK support
Message-ID: <Yv+HFz/q1iGFfQ+m@lunn.ch>
References: <20220819074729.1496088-1-wei.fang@nxp.com>
 <20220819074729.1496088-3-wei.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819074729.1496088-3-wei.fang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* Configure REF_CLK as input in RMII mode */
> +#define TJA110X_RMII_MODE_REFCLK_IN       BIT(0)
> +
>  struct tja11xx_priv {
>  	char		*hwmon_name;
>  	struct device	*hwmon_dev;
>  	struct phy_device *phydev;
>  	struct work_struct phy_register_work;
> +	u32 quirks;

A quirk is generally a workaround for a bug. Configuring a clock is
not a quirk. I would rename this flags.

    Andrew
