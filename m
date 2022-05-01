Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2025C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  1 May 2022 17:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352054AbiEARDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 May 2022 13:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240473AbiEARDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:03:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7ADBC0;
        Sun,  1 May 2022 10:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFD68B80E91;
        Sun,  1 May 2022 17:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C73BC385AE;
        Sun,  1 May 2022 17:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651424411;
        bh=l1DrxRfrHZ3UoGV2MYuGEotCSiWiPeK59jKSCQKDDkE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YZ5lp245eN7rbZhvRt8aFIdscFMfp8CtkiQDvkzcMO7s8nSihBad/iEhXxUd859Sz
         LQ86Fj2fqNu5104BpnkMRXUr1hAzA/bMG0QbIivFdS3UQiy4+Abw7oVBPYETq7/ePE
         fUFDfEt48PKUf+9tIAGi+ZeyGszP5/7t4R0/G9OLd+0w6APsA21vZ1VFEfjC3+bkVC
         r5N0WNh74t1e3ssFIi1d3L4Bl8H8RfO+w8nBDsGdR1/QXApThR6N6teY9dsKNOT4tJ
         +lMhJNsNyS0HKSAs3UVpMjYV94UEbHmay5Iop9nkEVoOSmwEXDQwqrkFiOZLbi8rGe
         oM68jaJeGEKUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F8B2F03847;
        Sun,  1 May 2022 17:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: b53: convert to phylink_pcs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165142441125.26534.13651898801015170990.git-patchwork-notify@kernel.org>
Date:   Sun, 01 May 2022 17:00:11 +0000
References: <20220429164303.712695-1-f.fainelli@gmail.com>
In-Reply-To: <20220429164303.712695-1-f.fainelli@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk, andrew@lunn.ch,
        vivien.didelot@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri, 29 Apr 2022 09:43:03 -0700 you wrote:
> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> 
> Convert B53 to use phylink_pcs for the serdes rather than hooking it
> into the MAC-layer callbacks.
> 
> Fixes: 81c1681cbb9f ("net: dsa: b53: mark as non-legacy")
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: b53: convert to phylink_pcs
    https://git.kernel.org/netdev/net/c/79396934e289

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


