Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6369C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 18:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiFFSUS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 14:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiFFSUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C979F92703;
        Mon,  6 Jun 2022 11:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 648A161335;
        Mon,  6 Jun 2022 18:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3DB5C385A9;
        Mon,  6 Jun 2022 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654539612;
        bh=44SzrEgcZC4Ze2JxLGZlcL4zkzuRWW91q9X/6/lv8K4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bHQv4B/DNvIk4Pfpos8c1wB/OOhY6ANTKT7P6TcHGHanR11JasFbC4bCj3xPr3tvU
         DfdnITF4zqNFkpyDT8MBm+K/TVYVgFdQyYnW6G43J6mn0VIZ5BOix2bS2jWpMgyTTX
         R3ns1axd6vlGrBSMnHDUz7c3Ibj/1NbkrqbfCeM198052417FHqjs6YzBKdTa942fd
         7d96UygE/9dkPY9zRPuS80IbN+QEDOzBn2OgYYTvGfhaB2sUyTkqjn3PE888PxPKUV
         KkV4l5MHtTFzo59L70LY0z3+GPx9iX7AxDt8esf9+CSWpG4YO9p5HSRZc15ZcE0RYX
         MDVtuJ6ROJ1FA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AAC82E737ED;
        Mon,  6 Jun 2022 18:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/1] net: phy: dp83867: retrigger SGMII AN when
 link change
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165453961269.17643.13140581506341939026.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Jun 2022 18:20:12 +0000
References: <20220526090347.128742-1-tee.min.tan@linux.intel.com>
In-Reply-To: <20220526090347.128742-1-tee.min.tan@linux.intel.com>
To:     Tan Tee Min <tee.min.tan@linux.intel.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, dmurphy@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        weifeng.voon@intel.com, michael.wei.hong.sit@intel.com,
        pei.lee.ling@intel.com, hong.aun.looi@intel.com,
        vee.khee.wong@intel.com, tee.min.tan@intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 May 2022 17:03:47 +0800 you wrote:
> There is a limitation in TI DP83867 PHY device where SGMII AN is only
> triggered once after the device is booted up. Even after the PHY TPI is
> down and up again, SGMII AN is not triggered and hence no new in-band
> message from PHY to MAC side SGMII.
> 
> This could cause an issue during power up, when PHY is up prior to MAC.
> At this condition, once MAC side SGMII is up, MAC side SGMII wouldn`t
> receive new in-band message from TI PHY with correct link status, speed
> and duplex info.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/1] net: phy: dp83867: retrigger SGMII AN when link change
    https://git.kernel.org/netdev/net/c/c76acfb7e19d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


