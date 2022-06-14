Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596E0CCA47A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 18:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358108AbiFNSyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 14:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358659AbiFNSxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:53:35 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4C651E4A;
        Tue, 14 Jun 2022 11:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=nv1zvia7YW/sCDV/c7twLHwtsEJhBvBCb96DvXq4RLs=; b=by2kBTic1HD3b40bFBh0cXwH3g
        PymT00QkEyb05+61XIky0czYGuWXdgNLSYJwWZ3odJQAHMXI2F7P9Ql/Gjlxhopx2/806IO5wgOck
        n0VIywCwGmO0GSUgHghXfXx5dVCti4Ss7gjd7SDh0srUjVjTL0T/uFM7Wxfj7WIVoUks=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1o1BYu-006vA7-QV; Tue, 14 Jun 2022 20:46:48 +0200
Date:   Tue, 14 Jun 2022 20:46:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] dt-bindings: dp83867: add binding for
 io_impedance_ctrl nvmem cell
Message-ID: <YqjXmInBfE/oMc4m@lunn.ch>
References: <20220606202220.1670714-1-linux@rasmusvillemoes.dk>
 <20220606202220.1670714-2-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606202220.1670714-2-linux@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 10:22:18PM +0200, Rasmus Villemoes wrote:
> We have a board where measurements indicate that the current three
> options - leaving IO_IMPEDANCE_CTRL at the (factory calibrated) reset
> value or using one of the two boolean properties to set it to the
> min/max value - are too coarse.
> 
> There is no documented mapping from the 32 possible values of the
> IO_IMPEDANCE_CTRL field to values in the range 35-70 ohms, and the
> exact mapping is likely to vary from chip to chip. So add a DT binding
> for an nvmem cell which can be populated during production with a
> value suitable for each specific board.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
