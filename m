Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849ECC28D13
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Aug 2022 00:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244442AbiHTAAc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 20:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244257AbiHTAAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:00:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE98106FB5;
        Fri, 19 Aug 2022 17:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91C7CB829C5;
        Sat, 20 Aug 2022 00:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50B32C433D6;
        Sat, 20 Aug 2022 00:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660953617;
        bh=3RIo8oq+qxMgaOqNJAKO9xrgGxDbf3ufKXVarp6XBEY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=p0HU/xY2sH95V73jNbGWmlspxN4NoibDKt7BaLrJNy6oYUFp9e51TBCNQy93pfW4s
         PnBv+hSgHh/N49NtYm+lXONBA5IMtYlmt3RyViY8JKRNPMjbgrYQY+QEaPhEXaPWBd
         1SC50vSw3fxyn4kS3XAJ+ruy/ahjUnShos+bH0Ufj8qwZElDVVM6WRhrfKf+cjE/mT
         ESFtF68r3lA5XJnhwOAwIfFa/Etn47BdpyjdgOoKDPtYw7hZl80oMX4XQL2qqnubza
         4VgIBr8KOHQWCkVrsiQhOq1NCVZACCqED+5MBBoD1WcEvm9RPsI7XoPrlxgTH0WA7Z
         cCSfdiU+jh/8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AA30E2A05E;
        Sat, 20 Aug 2022 00:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] amt: remove unneccessary skb pointer check
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166095361723.16371.15901843679218279030.git-patchwork-notify@kernel.org>
Date:   Sat, 20 Aug 2022 00:00:17 +0000
References: <20220818093114.2449179-1-yangyingliang@huawei.com>
In-Reply-To: <20220818093114.2449179-1-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ap420073@gmail.com, davem@davemloft.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Aug 2022 17:31:14 +0800 you wrote:
> The skb pointer will be checked in kfree_skb(), so remove the outside check.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/net/amt.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [-next] amt: remove unneccessary skb pointer check
    https://git.kernel.org/netdev/net-next/c/6745bc9b0351

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


