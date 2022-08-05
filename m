Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C53C25B08
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Aug 2022 19:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbiHET5f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Aug 2022 15:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiHET5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 15:57:34 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50B826AD3;
        Fri,  5 Aug 2022 12:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Gu0qTJgy7dDy5YxspPiR5zd6gZJo4q1W9Yd7U2dJ0jI=; b=pqzbNPUXZJxqxl0WHYvAj009OV
        9CoLFJRFZUGfSH6agA4h/6IYcXmjuiiT8ni8yAHnvWG0h57hjPScme7DBgBQzl83MptKlYDHe2xpK
        aL8bLmMM+HYSGAdCwSg+ktyxcvqcnxWzWzXyk5adTkU47WLLxAyNafr4+NOxeqo5k+0s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oK3RT-00CWST-Js; Fri, 05 Aug 2022 21:57:07 +0200
Date:   Fri, 5 Aug 2022 21:57:07 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux@yadro.com, Nikita Shubin <n.shubin@yadro.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: dp83867: fix get nvmem cell fail
Message-ID: <Yu12E/NGEzCfPNVT@lunn.ch>
References: <20220805084843.24542-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805084843.24542-1-nikita.shubin@maquefel.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 11:48:43AM +0300, Nikita Shubin wrote:
> From: Nikita Shubin <n.shubin@yadro.com>
> 
> If CONFIG_NVMEM is not set of_nvmem_cell_get, of_nvmem_device_get
> functions will return ERR_PTR(-EOPNOTSUPP) and "failed to get nvmem
> cell io_impedance_ctrl" error would be reported despite "io_impedance_ctrl"
> is completely missing in Device Tree and we should use default values.
> 
> Check -EOPNOTSUPP togather with -ENOENT to avoid this situation.

Should be 'together'

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
