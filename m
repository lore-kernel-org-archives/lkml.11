Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1508DC32772
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 17:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350755AbiHSR5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 13:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350635AbiHSR4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:56:48 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D664F220C3;
        Fri, 19 Aug 2022 10:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Np1ibAFNVnfFgg0QIFE24X+BInAHnXNFqAN1Bvj0a9E=; b=U2083fO9ZNK/aBkQR0OkRDk/CH
        G2fmVJE+JuoZnt3CkavmBH9hR+4HGl8o6KO+H6aAGlwS2SfY5H6d1mL5wqvUqv+lXcHpWaKU1H74+
        ZXDojIUpeFnZh4aY1sQeFg+5ftuV39ggf6KataTvlcxGF33dgx6VglYXSpKjt6hlYjOQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oP5xg-00DwBs-9v; Fri, 19 Aug 2022 19:39:12 +0200
Date:   Fri, 19 Aug 2022 19:39:12 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marcus Carlberg <marcus.carlberg@axis.com>
Cc:     Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kernel@axis.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: support RGMII cmode
Message-ID: <Yv/KwIDbYewAGD/d@lunn.ch>
References: <20220819135629.32590-1-marcus.carlberg@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819135629.32590-1-marcus.carlberg@axis.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 03:56:29PM +0200, Marcus Carlberg wrote:
> Since the probe defaults all interfaces to the highest speed possible
> (10GBASE-X in mv88e6393x) before the phy mode configuration from the
> devicetree is considered it is currently impossible to use port 0 in
> RGMII mode.
> 
> This change will allow RGMII modes to be configurable for port 0
> enabling port 0 to be configured as RGMII as well as serial depending
> on configuration.
> 
> Signed-off-by: Marcus Carlberg <marcus.carlberg@axis.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
