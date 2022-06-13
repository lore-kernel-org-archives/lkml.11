Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DE3C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 15:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244145AbiFMPZO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 11:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387207AbiFMPY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:24:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD384137C69;
        Mon, 13 Jun 2022 05:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D3BB614C9;
        Mon, 13 Jun 2022 12:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD92EC3411B;
        Mon, 13 Jun 2022 12:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655124612;
        bh=JoRQPCKpZ50r7Vm43APNqBWNBVopKKU31DzC8GydWrk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hM2fscbMgqqJ5nxnuSFmGYI1YaXxKlUxZEAbrytYNfjeImUZXt2uAO4CoHN91pfM4
         NWxXhwzrnkfDb1Fqu9DfRNPLfqiuoCyFCyZ25g0uF6lAOz8HZoSEZe+9yOOB8U1F9R
         Vz4T3Ygk/ncCyhD+3mpu9cFCGOGK5NZFUP/X0AJsO1AHBjF2mMzPf29mkbt/bltFr8
         CcDXBO6hd5ta66Syvq8Yzf9Qjip7qn6EF+sQ604PKlmR7wtxZehO51iTZn0sJJCT44
         RMfPxnqFQzOvtsEmpckl7ma1G1RbqW5J10GdYpYiJcA7KD0+YcxeAU+y3nl3ojweNM
         wCiD+hZzthIKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2A05E57538;
        Mon, 13 Jun 2022 12:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-vf: Add support for adaptive interrupt
 coalescing
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165512461272.14727.15986698743424790428.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Jun 2022 12:50:12 +0000
References: <20220612174536.2403843-1-sumang@marvell.com>
In-Reply-To: <20220612174536.2403843-1-sumang@marvell.com>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Sun, 12 Jun 2022 23:15:36 +0530 you wrote:
> Fixes: 6e144b47f560 (octeontx2-pf: Add support for adaptive interrupt coalescing)
> Added support for VF interfaces as well.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net] octeontx2-vf: Add support for adaptive interrupt coalescing
    https://git.kernel.org/netdev/net/c/619c010a6539

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


