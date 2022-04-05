Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929E6C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 01:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839386AbiDFBBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 21:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387516AbiDENPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:15:16 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27BAD557A;
        Tue,  5 Apr 2022 05:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=/Jzy8onOXUPJU7Y+hs/6t3GRIWLkNmZwe+i4nNa4Yxc=; b=xTGGnE8UM+/e5BXzMVCICfkA3l
        78wgvNqyPrLXzotrawBoBiAINgodkOn60B6J1YFAtkLIva9JxM5iWZyv6FvWxA6mlbYPUjCRcu8Bv
        PGMzaaxFPXK4JIOVFeiKVmdwsVWZv52IUFxApOygAB2B0qeU3YjnxsFJIJs0llcFmuLo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nbiAO-00EFPI-74; Tue, 05 Apr 2022 14:20:12 +0200
Date:   Tue, 5 Apr 2022 14:20:12 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michael Walle <michael@walle.cc>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v3 2/3] dt-bindings: net: mscc-miim: add clock
 and clock-frequency
Message-ID: <Ykwz/GKpsaug6RpD@lunn.ch>
References: <20220405120951.4044875-1-michael@walle.cc>
 <20220405120951.4044875-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405120951.4044875-3-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 02:09:50PM +0200, Michael Walle wrote:
> Add the (optional) clock input of the MDIO controller and indicate that
> the common clock-frequency property is supported. The driver can use it
> to set the desired MDIO bus frequency.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

