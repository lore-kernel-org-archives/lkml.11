Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE00C433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 12:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbiCGMLL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237610AbiCGMLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:11:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B1D7B54B;
        Mon,  7 Mar 2022 04:10:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAB2FB80EE1;
        Mon,  7 Mar 2022 12:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91AD8C340F5;
        Mon,  7 Mar 2022 12:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646655010;
        bh=djt0UBOpFTpN3goxeU7pzBlCpi/NSAoa5Ltm5FlZwjE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fqfejW2FX4fGiaPPz51njUxJWKpw1LWW7oR0IjKuofWQ6zJM+SiJaxXVV4gQ3arls
         0hcLW/dD9ZVUJvTj1gguTQw/9xMm2Q3j1LKjyCk2Qvcj2xofB7gx5AzvHadWjzq6uQ
         NrqmeAKIvvneOOT6z0XSGPUT2m52xfdpQtcH3a788KldxAyC2k72qXrnmXZ/WSa9PX
         sUhEsLSa0rAxlRhkd/3nVHzGaTqbMTZZpJPIF78pE9HlpMmFrOVAYqRHIX9GeizSd/
         nB4pIgXg2GIR/IJ97wn7o50P0HZLDQZDiKNv7X8S4VYz+my3vUngt2Fvm01s2+Yt8k
         ospyEZLIqVnVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 735E6E7BB18;
        Mon,  7 Mar 2022 12:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nfp: xsk: avoid newline at the end of message in
 NL_SET_ERR_MSG_MOD
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164665501046.29143.3896956016571840550.git-patchwork-notify@kernel.org>
Date:   Mon, 07 Mar 2022 12:10:10 +0000
References: <20220307090804.4821-1-guozhengkui@vivo.com>
In-Reply-To: <20220307090804.4821-1-guozhengkui@vivo.com>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     simon.horman@corigine.com, kuba@kernel.org, davem@davemloft.net,
        niklas.soderlund@corigine.com, louis.peens@corigine.com,
        yinjun.zhang@corigine.com, pabeni@redhat.com,
        oss-drivers@corigine.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Mon,  7 Mar 2022 17:07:59 +0800 you wrote:
> Fix the following coccicheck warning:
> drivers/net/ethernet/netronome/nfp/nfp_net_common.c:3434:8-48: WARNING
> avoid newline at end of message in NL_SET_ERR_MSG_MOD
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>  drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - nfp: xsk: avoid newline at the end of message in NL_SET_ERR_MSG_MOD
    https://git.kernel.org/netdev/net-next/c/0c1794c200e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


