Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF232C28D13
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 23:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241396AbiHSXkU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 19:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiHSXkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:40:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5C6102F2F;
        Fri, 19 Aug 2022 16:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63868618A0;
        Fri, 19 Aug 2022 23:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2E4AC433D7;
        Fri, 19 Aug 2022 23:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660952415;
        bh=peVML7qODNJT6PC67kFwcejZMQDAsDUQFq1wwHC3RKE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=i94JXdRk4xeGPnpF86KLCWCD+WkZ9V/ltn+YdPJIRi6sLQjsHG5kkZCxZ8TEA8HYZ
         LAJc32G1OIbcGv5bLkzAPiCNF/TfCCyCwVuaNT9yNRMHVHR/xshL8XhrIuJYmrbaiT
         k2d1qzUVqKd5/rgcZyJKJdUGJNqBgEnI+XUHkG4E/l263cmyK5SblPoBUEBy0ykr6v
         OK2LOBmxkBX1k6olr2QaQGFS7kMrtMTpg2NbR1EJ6I05X6q/qia4745coreVg8Wh4l
         VOFzcmViATRq29L7OAE5ybg6/s5hSwF9d/I0pHfsc8SSkho1Sdih/hZfRZF9vzHuUF
         UkNQAb/1JJwNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92B8AC43142;
        Fri, 19 Aug 2022 23:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dpaa: Fix <1G ethernet on LS1046ARDB
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166095241559.6172.2322704205622088907.git-patchwork-notify@kernel.org>
Date:   Fri, 19 Aug 2022 23:40:15 +0000
References: <20220818164029.2063293-1-sean.anderson@seco.com>
In-Reply-To: <20220818164029.2063293-1-sean.anderson@seco.com>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, camelia.groza@nxp.com,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        madalin.bucur@nxp.com, andrew@lunn.ch, hkallweit1@gmail.com,
        vbhadram@nvidia.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Aug 2022 12:40:29 -0400 you wrote:
> As discussed in commit 73a21fa817f0 ("dpaa_eth: support all modes with
> rate adapting PHYs"), we must add a workaround for Aquantia phys with
> in-tree support in order to keep 1G support working. Update this
> workaround for the AQR113C phy found on revision C LS1046ARDB boards.
> 
> Fixes: 12cf1b89a668 ("net: phy: Add support for AQR113C EPHY")
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Acked-by: Camelia Groza <camelia.groza@nxp.com>
> 
> [...]

Here is the summary with links:
  - [net] net: dpaa: Fix <1G ethernet on LS1046ARDB
    https://git.kernel.org/netdev/net/c/9dbdfd4a9f34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


