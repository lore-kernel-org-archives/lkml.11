Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EFAC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 05:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiBOFUV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 00:20:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiBOFUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:20:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D749DD57;
        Mon, 14 Feb 2022 21:20:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8148961312;
        Tue, 15 Feb 2022 05:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB316C340F1;
        Tue, 15 Feb 2022 05:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644902409;
        bh=4+pEcBL1Eid/mimbRZCtDHmyhM5IZrVdynLj15q1Zyo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=M6G6sbBhtE6O15nLGWFUDc7NfKZPnsAXtmIIsNNSefmgZQCNeXluBvoa2L53LVFon
         7iolqLF6VR6Br7oR8y/ow0TpQa9nnny09BuS3lI1PiYz8eUaZPCJsCNcfO8jwuKGb9
         0VpeIyNola0R3ysvbrMNAQvjt+nqu/P43NNFiMr3SIyHrx5THSXhGPOCwrbXMXxP5g
         9difYs2XfreMmWAvqMfFF20u8K4mfgtEVRS+dyp09tZPX3llS44fFP0Qm60F3e16ZC
         +PobzRG8g1PUKUVIS3uVbYfAQPtwAn1UwH65v1jtr4U7N4WRIr24WQyokXc861WanF
         vJRjzNavBVZDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BDB55E6D447;
        Tue, 15 Feb 2022 05:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: dsa: mv88e6xxx: Fix validation of built-in
 PHYs on 6095/6097
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164490240977.24821.13416312294211301534.git-patchwork-notify@kernel.org>
Date:   Tue, 15 Feb 2022 05:20:09 +0000
References: <20220213185154.3262207-1-tobias@waldekranz.com>
In-Reply-To: <20220213185154.3262207-1-tobias@waldekranz.com>
To:     Tobias Waldekranz <tobias@waldekranz.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        olteanv@gmail.com, linux@armlinux.org.uk, kabel@kernel.org,
        rmk+kernel@armlinux.org.uk, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Feb 2022 19:51:54 +0100 you wrote:
> These chips have 8 built-in FE PHYs and 3 SERDES interfaces that can
> run at 1G. With the blamed commit, the built-in PHYs could no longer
> be connected to, using an MII PHY interface mode.
> 
> Create a separate .phylink_get_caps callback for these chips, which
> takes the FE/GE split into consideration.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: dsa: mv88e6xxx: Fix validation of built-in PHYs on 6095/6097
    https://git.kernel.org/netdev/net-next/c/d0b78ab1ca35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


