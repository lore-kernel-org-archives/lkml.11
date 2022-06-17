Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5206AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 03:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379811AbiFQDuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 23:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379746AbiFQDu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 23:50:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB17663DD;
        Thu, 16 Jun 2022 20:50:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 999B161DB8;
        Fri, 17 Jun 2022 03:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02247C341C6;
        Fri, 17 Jun 2022 03:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655437827;
        bh=qryEHpeEJUqn20vEoUi1DYcDxt737X17S9fdpDAEVIg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gfhXPoy3C8G9OV1nNevTaOrf3bPXdJ7BqKK9Qfuxq8+pwMzdJnNqEk4mfW7cHJp+k
         M868gXIRX4jPxSZS+JWQQPze2EDSncVJdSOLq8ZcotHfPWg5exMdb4s/RLQ0ucPWmM
         ab+tvOshrEbcxsQhRrYfNGhbrWZruc6L/KLG48r9zNQBOFQV5FiNcYGiTKxeZybEBa
         7HGC4Kc2dwqdJ3Dem8s1SgOFlVeOQLUvbTUX3mt14NncV9dmVPLYh7aNncaLbbB1B3
         iHCvXLmMwiSjw0DxylsvySHwMF39yp0mnIDGMf5owg6b/BG/SQKpaEP0/XXVzghgZY
         IE5wcM73Z50jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DAFA1E7385E;
        Fri, 17 Jun 2022 03:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] dt-bindings: dp83867: add binding for
 io_impedance_ctrl nvmem cell
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165543782689.2027.4534991935889934108.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Jun 2022 03:50:26 +0000
References: <20220614084612.325229-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20220614084612.325229-1-linux@rasmusvillemoes.dk>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, devicetree@vger.kernel.org,
        robh+dt@kernel.org, kuba@kernel.org, davem@davemloft.net,
        grygorii.strashko@ti.com, praneeth@ti.com,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jun 2022 10:46:09 +0200 you wrote:
> We have a board where measurements indicate that the current three
> options - leaving IO_IMPEDANCE_CTRL at the reset value (which is
> factory calibrated to a value corresponding to approximately 50 ohms)
> or using one of the two boolean properties to set it to the min/max
> value - are too coarse.
> 
> This series adds a device tree binding for an nvmem cell which can be
> populated during production with a suitable value calibrated for each
> board, and corresponding support in the driver. The second patch adds
> a trivial phy wrapper for dev_err_probe(), used in the third.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] dt-bindings: dp83867: add binding for io_impedance_ctrl nvmem cell
    https://git.kernel.org/netdev/net-next/c/ab1e9de84aff
  - [net-next,v2,2/3] linux/phy.h: add phydev_err_probe() wrapper for dev_err_probe()
    https://git.kernel.org/netdev/net-next/c/a793679827a8
  - [net-next,v2,3/3] net: phy: dp83867: implement support for io_impedance_ctrl nvmem cell
    https://git.kernel.org/netdev/net-next/c/5c2d0a6a0701

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


