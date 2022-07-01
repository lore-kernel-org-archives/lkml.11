Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD56AC43334
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 10:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbiGAKkf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236631AbiGAKkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2567B372;
        Fri,  1 Jul 2022 03:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FDB362472;
        Fri,  1 Jul 2022 10:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1EF6C341D5;
        Fri,  1 Jul 2022 10:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656672017;
        bh=Q2KxL9qb83dOBvl0LhoEG6wSJkqvXa43ptuF1Ms1cM4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fwzn0AnNht24myPNyhBPOcFvTLvJd22ADUS1y+V4caoHoXnC1o0e7UYotInV4+ciq
         34aDFCZeBlKXQVpeoH42R5TryTHKdd3l5Iz5vcVTuhyIK60d6dP2tN74l19G3TTN+W
         Xwdqy/VTEpaWIEBUq+ZYgAQ7DcQWy/eYAv6tVjWWCdFVBgUgO11XJU+/XYTB8tEofT
         eCbpfojRY+0O6JYBeB5wSd2vALdvibOISocEEH8ZT4cx767rtOBE41eZX6vsiHVWml
         8IsdeGCCUqznxpkQPQw0oz0kxC6f73o5aj1XYjRPFjDF5SjenUAcv3rNTh6+p6KZrE
         azzVB6VHpz6zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 991F3E49BB8;
        Fri,  1 Jul 2022 10:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] neterion/vxge: fix repeated words in comments
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165667201762.26485.7344145724918527749.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Jul 2022 10:40:17 +0000
References: <20220630080355.53566-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220630080355.53566-1-yuanjilin@cdjrlc.com>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jdmason@kudzu.us, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Thu, 30 Jun 2022 16:03:55 +0800 you wrote:
> Delete the redundant word 'frame'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/net/ethernet/neterion/vxge/vxge-config.c  | 2 +-
>  drivers/net/ethernet/neterion/vxge/vxge-ethtool.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - neterion/vxge: fix repeated words in comments
    https://git.kernel.org/netdev/net-next/c/023e79db59ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


