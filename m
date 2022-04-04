Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE415C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 12:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiDDMCU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 08:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiDDMCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:02:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C1034B8A;
        Mon,  4 Apr 2022 05:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5A6960FEB;
        Mon,  4 Apr 2022 12:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C12EC36AED;
        Mon,  4 Apr 2022 12:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649073615;
        bh=vVpln7g36eE4ZDpdrV988KGVvNKsKCXBgdy3O7R+gyE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EEACCrby9UEEZzZV7Xb6Gn96HzGqr2hTvVXXiUUg+P9MVswQgeVg+A46u9scbADOr
         lOAPJAzgBtWvg+9q7Zd+Xe2O0DmNrroxYaez0mu8VpWMb2Bbo2dAaLhe9486BN1vqn
         AFaSytqTRmp9ZbXS/JF5XZW2TsKmEhtm05V7ntVzhTff6SLj3Y+i5smsUG356N9Ol2
         gXMkDoLvuEAovJ45K6rss3Ji9pAlOy4wC0xuLBUxhKfbKBdSNulnipu18LDLSGMoDn
         Jqgm9J1fy5KjxszFISbQCcU7T80NTwYrTOVJ9pptHDvHlPlVZJCq+P2P2UCw4IMmKI
         kD8yyiZjYeGCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DD34E85D53;
        Mon,  4 Apr 2022 12:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] net: phy: micrel: Remove latencies support lan8814
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164907361518.19769.7734375413743952286.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Apr 2022 12:00:15 +0000
References: <20220401110522.3418258-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220401110522.3418258-1-horatiu.vultur@microchip.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, Divya.Koppera@microchip.com,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, UNGLinuxDriver@microchip.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri, 1 Apr 2022 13:05:19 +0200 you wrote:
> Remove the latencies support both from the PHY driver and from the DT.
> The IP already has some default latencies values which can be used to get
> decent results. It has the following values(defined in ns):
> rx-1000mbit: 429
> tx-1000mbit: 201
> rx-100mbit:  2346
> tx-100mbit:  705
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] dt-bindings: net: micrel: Revert latency support and timestamping check
    https://git.kernel.org/netdev/net/c/b117c88df0e3
  - [net,v2,2/3] net: phy: micrel: Remove latency from driver
    https://git.kernel.org/netdev/net/c/b814403a8cd8
  - [net,v2,3/3] net: phy: micrel: Remove DT option lan8814,ignore-ts
    https://git.kernel.org/netdev/net/c/76e9ccd68943

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


