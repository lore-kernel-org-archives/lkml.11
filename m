Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40101C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 21:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353335AbiDOVCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 17:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351369AbiDOVCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:02:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C83340D8;
        Fri, 15 Apr 2022 14:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B31DA62053;
        Fri, 15 Apr 2022 21:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19487C385A5;
        Fri, 15 Apr 2022 21:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650056412;
        bh=QCzScoDMvFxEYOw1D6/S7QM7F+u38RFg8Mxws8g3w0s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PPivEZ0DUbzbi6otD8/Aqpxn1fO+kiWRpiv8gx13o8RJMO+SjzfH2AIrjH/ncB7GP
         Z7dfJ8nRCYPcHkvGRYpl6Q/hFQBBk04PYAhYH76hFf5yi/6f/qtXANgWca1910O9Ck
         1OY3FyGy9Qvmh0M4/dsWwHhrkv+ITdpaISk/aruj2x+wWpiKziIpLKZqS+EQyL9YCY
         ymsQA1lsT37mUdb9nhF9IRZkeL4CicilDeU7w3lsDB/Av696ai/RGnOzf3S5jOH02R
         rl2ZrGBvjyN5pvALVeD5cBFiHXogxEaMyVQOgIxPWpNiND1LI4a+JZr/8mKkB6FbcD
         IHDSbbelvBTFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF75EE8DD67;
        Fri, 15 Apr 2022 21:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: ethool: add support to get/set tx push
 by ethtool -G/g
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165005641191.29090.910105060645731627.git-patchwork-notify@kernel.org>
Date:   Fri, 15 Apr 2022 21:00:11 +0000
References: <20220412020121.14140-1-huangguangbin2@huawei.com>
In-Reply-To: <20220412020121.14140-1-huangguangbin2@huawei.com>
To:     Guangbin Huang <huangguangbin2@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        mkubecek@suse.cz, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lipeng321@huawei.com,
        chenhao288@hisilicon.com, wangjie125@huawei.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Apr 2022 10:01:18 +0800 you wrote:
> From: Jie Wang <wangjie125@huawei.com>
> 
> These three patches add tx push in ring params and adapt the set and get APIs
> of ring params.
> 
> ChangeLog:
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: ethtool: extend ringparam set/get APIs for tx_push
    (no matching commit)
  - [net-next,v2,2/3] net: ethtool: move checks before rtnl_lock() in ethnl_set_rings
    https://git.kernel.org/netdev/net-next/c/bde292c07b48
  - [net-next,v2,3/3] net: hns3: add tx push support in hns3 ring param process
    https://git.kernel.org/netdev/net-next/c/1f702c1643f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


