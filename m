Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341FEC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 22 May 2022 20:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351372AbiEVUuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 May 2022 16:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242511AbiEVUuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 16:50:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD52D2A26B;
        Sun, 22 May 2022 13:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60A4D60ED7;
        Sun, 22 May 2022 20:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAF06C3411B;
        Sun, 22 May 2022 20:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653252612;
        bh=MGKHrhekhHwdENpJpMZAlUiTrcAJx816JTANE8lwR5E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oo66M+nMSBdkTCra/UiHkdH3pHsi/zcizC86wszHktDfOZl/TPdWgUPjmqyhL6r6y
         idbY95kxtVzQeSrbvi849nyhgimZT5SClSTNdKvvE71bwlAVjXFqDI6U8ltyn7zyRz
         Q9s237T+4EQXggfZhEOhBE2z85suHzR5G5MVMj85bHF8TilpgPHoeUifPGau+ISSme
         +oOhXkrj9lxIrE+HNtJMZXp4WjFBPJQW7O1d4rtOkGV2BMuY/BCu6YqQczTWB5mGYP
         hxVfK4e68zjtU0O+ob2pFqPKcSMyW/t+u/SMsyB9EhReZtvATH3qteMoS0Tj4YNWsl
         /oANbAoKINN5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1B13F03943;
        Sun, 22 May 2022 20:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: phy: DP83822: enable rgmii mode if
 phy_interface_is_rgmii
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165325261265.21066.3922504901469719799.git-patchwork-notify@kernel.org>
Date:   Sun, 22 May 2022 20:50:12 +0000
References: <20220520235846.1919954-1-tommaso.merciai@amarulasolutions.com>
In-Reply-To: <20220520235846.1919954-1-tommaso.merciai@amarulasolutions.com>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     michael@amarulasolutions.com, alberto.bianchi@amarulasolutions.com,
        linux-amarula@amarulasolutions.com, linuxfancy@googlegroups.com,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Sat, 21 May 2022 01:58:46 +0200 you wrote:
> RGMII mode can be enable from dp83822 straps, and also writing bit 9
> of register 0x17 - RMII and Status Register (RCSR).
> When phy_interface_is_rgmii rgmii mode must be enabled, same for
> contrary, this prevents malconfigurations of hw straps
> 
> References:
>  - https://www.ti.com/lit/gpn/dp83822i p66
> 
> [...]

Here is the summary with links:
  - [v3] net: phy: DP83822: enable rgmii mode if phy_interface_is_rgmii
    https://git.kernel.org/netdev/net-next/c/621427fbdada

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


