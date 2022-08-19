Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56525C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 21:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352360AbiHSVPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352419AbiHSVP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:15:29 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CA1EA143;
        Fri, 19 Aug 2022 14:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=2Qg6GzOwAJdLWvA18NZ2FtUzFLSyUrTFFV3orfdLpz0=; b=4rDZ+GljqxdLz2ppeU2tdOSzy6
        2gJOeGo8TPKfjqGlKFelXkW57yeig5bSAo59ROXKpc0Wufdy4eFv9aOl6a6qX9GZ9ZwpHOGsU7VIL
        BTHH5PpGWtVi/GW16TlQVYhDvnpscrdSiWW3b/U0wHEAFIAnWNRu01SqDVcJZIcJqVh8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oP9Kf-00DxG2-CG; Fri, 19 Aug 2022 23:15:09 +0200
Date:   Fri, 19 Aug 2022 23:15:09 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH net-next v1 7/7] ethtool: add interface to interact with
 Ethernet Power Equipment
Message-ID: <Yv/9XVjRaa5jwpBo@lunn.ch>
References: <20220819120109.3857571-1-o.rempel@pengutronix.de>
 <20220819120109.3857571-8-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819120109.3857571-8-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> $ ip l
> ...
> 5: t1l1@eth0: <BROADCAST,MULTICAST> ..
> ...
> 
> $ ethtool --show-pse t1l1
> PSE attributs for t1l1:
> PoDL PSE Admin State: disabled
> PoDL PSE Power Detection Status: disabled
> 
> $ ethtool --set-pse t1l1 podl-pse-admin-control enable
> $ ethtool --show-pse t1l1
> PSE attributs for t1l1:
> PoDL PSE Admin State: enabled
> PoDL PSE Power Detection Status: delivering power

Here you seem to indicate that delivering power is totally independent
of the interface admin status, <BROADCAST,MULTICAST>. The interface is
admin down, yet you can make it deliver power. I thought there might
be a link between interface admin status and power? Do the standards
say anything about this? Is there some sort of industrial norm?

I'm also wondering about the defaults. It seems like the defaults you
are proposing is power is off by default, and you have to use ethtool
to enable power. That does not seem like the most friendly
settings. Why not an 'auto' mode where if the PHY has PoDL PSE
capabilities, on ifup it is enabled, on ifdown it is disabled? And you
can put it into a 'manual' mode where you control it independent of
administrative status of the interface?

    Andrew
