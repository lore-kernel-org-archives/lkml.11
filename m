Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9D4C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jun 2022 10:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbiFSKuP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jun 2022 06:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbiFSKuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 06:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E3BF590;
        Sun, 19 Jun 2022 03:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3854C6100C;
        Sun, 19 Jun 2022 10:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92927C341C5;
        Sun, 19 Jun 2022 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655635812;
        bh=iu8ASHXmgzKiYX4GzaTve8HUSvW9Ocs3J/dZxFcdi4w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=njT+Ky35Cd8KRRhRlXW0kxWy5SFtyJYaXDYBVQnTgy1GmEgaeX6N1BhsG9sBNYB5O
         ZfjrF53h5BXT2FpI17/GAyrf7WXuMtQQMwIq3jjHmsOHWWpPl5c6vncTGDj+dJVd2f
         wAB3A+QoVwfTVK5EfNmiK/aKxSfLYfleA9GtgvEqpkLTQKFz3e4jjjXbfoGgns2d57
         ITxK7ksPV31cKHj29hjxCNL2N0JK3NDXJLQTxm6ATT1uvIVtMaOzle3o3ocv7xRXSb
         3dfB4/428NEsD/QF6GRdn0aNqOHssTRuA84Ey7yekDkJrqrIqVvZNC3SnUXKkunJvO
         2x+dhwXnSQm5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72BD2E737F0;
        Sun, 19 Jun 2022 10:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sfc/siena: Fix typo in comment
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165563581246.13134.8069680373605190135.git-patchwork-notify@kernel.org>
Date:   Sun, 19 Jun 2022 10:50:12 +0000
References: <20220618132241.15288-1-wangxiang@cdjrlc.com>
In-Reply-To: <20220618132241.15288-1-wangxiang@cdjrlc.com>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ecree.xilinx@gmail.com,
        habetsm.xilinx@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Sat, 18 Jun 2022 21:22:41 +0800 you wrote:
> Delete the redundant word 'and'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  drivers/net/ethernet/sfc/siena/mcdi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - sfc/siena: Fix typo in comment
    https://git.kernel.org/netdev/net-next/c/9776fe0f424b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


