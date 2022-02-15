Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67438C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 14:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbiBOOaX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 09:30:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238625AbiBOOaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:30:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52498EDF24;
        Tue, 15 Feb 2022 06:30:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E31376177D;
        Tue, 15 Feb 2022 14:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EB1AC340F1;
        Tue, 15 Feb 2022 14:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644935410;
        bh=Ul9wORTglUXgvl28HPxbdqaB6WKzDL2m9BqXLWKhVyk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ng8qN/j0zgUxGme3kedt/cjhrGSre7Ku6JJNnlxRWJjTFY1k9hXXlrn6lXuGyfex1
         xZlcwg1am5CZprhKYZ1icOWdWNkEPCCTlpg+XC9pV6CwWra+QVjqQCtFcgL9oVEr9o
         mvkNYQirBRq5RjzU91lICzMIrSozLLPwpvQlZD4TyXYdWyWJEi/UsLiP1hbCZjphCO
         oEYCUL0UQWdbZkw47KavM7TmWeN/JuIQYl3bE8+1ZiqRXt4i9puDGMG78VdrR6sa8S
         va5/SHGRap3yFNOCCzieAlpbKIILrtK7GEPx5p+1Wf3FcE2LatMKmOyxkaNuY/AqVP
         1r4tx6r3K7jWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34BA2E6BBD2;
        Tue, 15 Feb 2022 14:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: mediatek: remove PHY mode check on MT7531
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164493541021.26708.6388647130926392224.git-patchwork-notify@kernel.org>
Date:   Tue, 15 Feb 2022 14:30:10 +0000
References: <20220209143948.445823-1-dqfext@gmail.com>
In-Reply-To: <20220209143948.445823-1-dqfext@gmail.com>
To:     DENG Qingfang <dqfext@gmail.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, kuba@kernel.org, matthias.bgg@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, arinc.unal@arinc9.com,
        hauke@hauke-m.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Wed,  9 Feb 2022 22:39:47 +0800 you wrote:
> The function mt7531_phy_mode_supported in the DSA driver set supported
> mode to PHY_INTERFACE_MODE_GMII instead of PHY_INTERFACE_MODE_INTERNAL
> for the internal PHY, so this check breaks the PHY initialization:
> 
> mt7530 mdio-bus:00 wan (uninitialized): failed to connect to PHY: -EINVAL
> 
> Remove the check to make it work again.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: mediatek: remove PHY mode check on MT7531
    https://git.kernel.org/netdev/net/c/525b108e6d95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


