Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4DCC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 23:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344088AbiCJXBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 18:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiCJXBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:01:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D7BE6D91;
        Thu, 10 Mar 2022 15:00:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8391461BF0;
        Thu, 10 Mar 2022 23:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD2D5C340EB;
        Thu, 10 Mar 2022 23:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646953210;
        bh=uZ1KrI/gt9CHhxEgRi523Od9M48dXgm685DeFJIjS2c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mf4u7MpXTV9FEJICLRcJKafB4rHMEjWfLkhiPcOWyLxeqEsWKJDaaP2KkdYhdsPaR
         +wBKqnX0GNtqXaMBn1VIL+jl+O+x/BVf+ynifv5KOsyAaSoCuudCEqI05eWpah1q2H
         XojqYXcyGqr36tIaKtgMfJZ2H1D5tpEMWPKBl+yCDXaXB3je/tvAz6FYtVxGQGpwps
         7Wr+9menuSIWmToTzyBaUqFpqkEfZgy/8gs21wMf3rtgFsEIhrGKudQN4BNGrn9IS2
         PKfgEKIVfQdlyuvrqURg4/gIRliBDzYxCvbJSzhEZJ9slUi1Z9RisL3gqdkHxAbc9x
         DKiuAU4zxx7Ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF93BE5D087;
        Thu, 10 Mar 2022 23:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: arc_emac: Fix use after free in arc_mdio_probe()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164695321078.6170.4849645757866961592.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Mar 2022 23:00:10 +0000
References: <20220309121824.36529-1-niejianglei2021@163.com>
In-Reply-To: <20220309121824.36529-1-niejianglei2021@163.com>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     davem@davemloft.net, kuba@kernel.org, caihuoqing@baidu.com,
        andrew@lunn.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Mar 2022 20:18:24 +0800 you wrote:
> If bus->state is equal to MDIOBUS_ALLOCATED, mdiobus_free(bus) will free
> the "bus". But bus->name is still used in the next line, which will lead
> to a use after free.
> 
> We can fix it by putting the name in a local variable and make the
> bus->name point to the rodata section "name",then use the name in the
> error message without referring to bus to avoid the uaf.
> 
> [...]

Here is the summary with links:
  - [v2] net: arc_emac: Fix use after free in arc_mdio_probe()
    https://git.kernel.org/netdev/net/c/bc0e610a6eb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


