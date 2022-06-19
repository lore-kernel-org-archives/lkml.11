Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C496BCCA47A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jun 2022 10:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiFSKuU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jun 2022 06:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbiFSKuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 06:50:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4492F101E1;
        Sun, 19 Jun 2022 03:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB8FBB80D23;
        Sun, 19 Jun 2022 10:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A13FCC3411D;
        Sun, 19 Jun 2022 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655635812;
        bh=yqYecZnBvOfgs8mxLlEYox9isXYnunSv+0+2HSzsWcw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nbditXRIPuY0QYvyxuJTWXTRPQBOVSdNV8fbVGmF+Xx/zjP7LwwHlGXVSDV8xZw7r
         jjUrdaNhv9Tq6fHicR27UOFyDu9SBP1oL/5dYVsDn0dGyAWqsICan8oLS6pt2Fe2Dp
         S63c3kxgqFRd7kswWqxhU0/g7Rl9yv6+9OufB2zyVr2BBD7nskIHJPRFkUrkNCiucY
         03TT/Cm5XHThdYInM+koErrhZAs9yupVuwm0d1DSAgdJsKPtr/U6jGnIfRgbmSPoW4
         33PgQZSOR/bnl7Y/xrHoeOUKYS8Uhm8UaZCehOyAC5U9Z4cedkBoqG2b0rsOLWT1c7
         PeC8xTTEZeGPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85E5FE7387E;
        Sun, 19 Jun 2022 10:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sfc: Fix typo in comment
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165563581254.13134.14691745929729925049.git-patchwork-notify@kernel.org>
Date:   Sun, 19 Jun 2022 10:50:12 +0000
References: <20220618131914.14470-1-wangxiang@cdjrlc.com>
In-Reply-To: <20220618131914.14470-1-wangxiang@cdjrlc.com>
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

On Sat, 18 Jun 2022 21:19:14 +0800 you wrote:
> Delete the redundant word 'and'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  drivers/net/ethernet/sfc/mcdi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - sfc: Fix typo in comment
    https://git.kernel.org/netdev/net-next/c/dd33c5932e55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


