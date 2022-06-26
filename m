Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F70C43334
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jun 2022 10:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiFZKGT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jun 2022 06:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiFZKGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 06:06:18 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A434B4AE;
        Sun, 26 Jun 2022 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ETSXXR3XzgEhkm6ZhG3jzrQ5JVh23r2tv8xELktbMK0=; b=2VxIh+rLvtGkW1BMXzrLQTbgJh
        b0gPCfkzwwu5a0FknvqBQ2ICpc60iHlAnYvw68oXbqo6ZYV0xRLxBI/lggAVjMvhHutBCgh3cH/oK
        qrkGjqA7YjIK+Hy2sTNd4zD7FvnjAlkxGOZXJ/d5uKKiPeEXy+AI5RalhXZKxbqWBtRk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1o5P9W-008Hgp-AH; Sun, 26 Jun 2022 12:06:02 +0200
Date:   Sun, 26 Jun 2022 12:06:02 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     alexandru.tachici@analog.com
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gerhard@engleder-embedded.com,
        geert+renesas@glider.be, joel@jms.id.au, stefan.wahren@i2se.com,
        wellslutw@gmail.com, geert@linux-m68k.org, robh+dt@kernel.org,
        d.michailidis@fungible.com, stephen@networkplumber.org,
        l.stelmach@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [net-next 2/2] dt-bindings: net: adin1110: Add docs
Message-ID: <YrgvimyFdPVhL6hF@lunn.ch>
References: <20220624200628.77047-1-alexandru.tachici@analog.com>
 <20220624200628.77047-3-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624200628.77047-3-alexandru.tachici@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +patternProperties:
> +  "^phy@[0-1]$":
> +    description: |
> +      ADIN1100 PHY that is present on the same chip as the MAC.
> +    type: object
> +
> +    properties:
> +      reg:
> +        items:
> +          maximum: 1
> +
> +    allOf:
> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                const: adi,adin1110
> +        then:
> +          properties:
> +            compatible:
> +              const: ethernet-phy-id0283.bc91
> +        else:
> +          properties:
> +            compatible:
> +              const: ethernet-phy-id0283.bca1
> +
> +    required:
> +      - compatible
> +      - reg

Why is any of this needed? You register an MDIO bus and then use the
PHY at address 0 or 1. phylib should find the PHY and read its ID
register to load the driver. So i don't think there is anything useful
here.

	Andrew
