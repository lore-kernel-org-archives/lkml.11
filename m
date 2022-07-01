Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05189C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 10:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbiGAKkv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbiGAKkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:40:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F30B7B34C;
        Fri,  1 Jul 2022 03:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2EB0B82F84;
        Fri,  1 Jul 2022 10:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90963C341CF;
        Fri,  1 Jul 2022 10:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656672017;
        bh=ItJZC5qVEX/PWQpiyM/GbJwpOi0Wi/JD3rN5eLbNSlo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cflp/fbjoTBhWNeGlSHo6eshDU6b3Lt7dLWgnXTZVKKccp7SOshnOOleU8Q0hNmfN
         4ZJyoaaqAXqrYYXOnuxjCx8ryVLlzZooX+XlIljv3RqG/ZS5JFjBPaOYfN50qCzL9B
         VRt5ai8fgjY5swF1peQ5H6o3pTohAsoRQ20hs46K1qxbCldjpfAAs84mthOCHh3NI7
         TTQ381aQ25LWuDLoDQJkAan/RTfeuNM7YmQAHv0Ha6m1ietknYRkvDqIB01v9OL8Hd
         5SIuSiOMvbmI63P5PvL7hKTmxUz85+rEu5nRRV+6xwAC25lIFlKInN/0G5aU/fQeD4
         DkL9KmmOfTlfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 742E3E49FA2;
        Fri,  1 Jul 2022 10:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] marvell/octeontx2/af: fix repeated words in comments
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165667201746.26485.4859577590270393211.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Jul 2022 10:40:17 +0000
References: <20220630054204.47501-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220630054204.47501-1-yuanjilin@cdjrlc.com>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Thu, 30 Jun 2022 13:42:04 +0800 you wrote:
> Delete the redundant word 'so'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - marvell/octeontx2/af: fix repeated words in comments
    https://git.kernel.org/netdev/net-next/c/36704239c8fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


