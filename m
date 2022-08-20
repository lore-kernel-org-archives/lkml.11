Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F455C28D13
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Aug 2022 00:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244280AbiHTAAV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 20:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiHTAAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:00:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4F0106FA9;
        Fri, 19 Aug 2022 17:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC005618CD;
        Sat, 20 Aug 2022 00:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 440CCC43140;
        Sat, 20 Aug 2022 00:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660953617;
        bh=U1ivDwlnKX82ycFfnYH3WKIeh1tmao/eqlSag+Agkwk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GF2EP/bpkYKW+O8dfa18S5pL6f5vG5uLTogrFr3Bk87Ha3rZpetqbEOTgYGDCfeKD
         vkbBZvMjk3tV/MEyKe2OJ0pW2BzPaNJY9VAXMAWnBcyABu0j/HhGiBUL6N2cq+BCEP
         pMpCa0CKG440HztIQlgEnimBl4UCK1xVMdcaumkdNca8h5B4+fGDb2gK3c3JGmfJu9
         yiYHpR2sSyBl8Gmy2+dSbF2gTVJ1YIGb+0WA1/llI6ttE9eoHkAZDZPU6Tuu2gA6Kg
         RHFvnC23qaEKxUpywfcUsOEQUCQT8DhFi9HhZjkTlSqllnQ1n7SC2DKj9h0nqWnFot
         hPz/o+Gl5bvhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E2E8E2A050;
        Sat, 20 Aug 2022 00:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: prestera: add missing ABI compatibility check
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166095361718.16371.7500340870200772956.git-patchwork-notify@kernel.org>
Date:   Sat, 20 Aug 2022 00:00:17 +0000
References: <20220818111419.414877-1-maksym.glubokiy@plvision.eu>
In-Reply-To: <20220818111419.414877-1-maksym.glubokiy@plvision.eu>
To:     Maksym Glubokiy <maksym.glubokiy@plvision.eu>
Cc:     tchornyi@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, yevhen.orlov@plvision.eu,
        oleksandr.mazur@plvision.eu, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Aug 2022 14:14:19 +0300 you wrote:
> Fixes: fec7c9c73fd3 ("net: marvell: prestera: define MDB/flood domain entries and HW API to offload them to the HW")
> Signed-off-by: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
> Signed-off-by: Maksym Glubokiy <maksym.glubokiy@plvision.eu>
> ---
>  drivers/net/ethernet/marvell/prestera/prestera_hw.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] net: prestera: add missing ABI compatibility check
    https://git.kernel.org/netdev/net-next/c/917edfb98c48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


