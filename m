Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0A2ECAAD1
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 13:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiHaNKT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiHaNKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:10:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C554623BC8;
        Wed, 31 Aug 2022 06:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6138F61A4D;
        Wed, 31 Aug 2022 13:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4BB9C433D7;
        Wed, 31 Aug 2022 13:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661951415;
        bh=RAkY63hNFx/8vl1JXaeD588viNSZjReZ0dLnnzI+628=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RO7h0BT37QqUqTIs2/5ZTaCLtPCsREONHwXJqLz+DIhiksIGgBNwoDNCy8UCB1OO2
         S5YgPLGGNsZvx/ZStd7LEN74OK3mXqGSL/fkgvqpcNtrtyBOWldB2FaeYpfHVso1Oy
         rT5EYll0WcDJ1ndFmh+BU9GH7TrPMof00phX7D8UBvtHbPDjjBWpeGOmG0eC0w4106
         Z5gn1igZuUZGmpEfSM+HZx1LEOBU3tlyZxArQNGnPrXoVyn2E9tOQwvAjiBKiPD/ZL
         3DC3NaUIe72axnYTOj/8TMRlOMMHksnQJajzhjHfjy2S169f4BHy9wYn84kD1zxJn/
         oIBgB7PS43LBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C424C4166F;
        Wed, 31 Aug 2022 13:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ethernet: rocker: fix sleep in atomic context bug in
 neigh_timer_handler
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166195141563.28572.5578866701471008663.git-patchwork-notify@kernel.org>
Date:   Wed, 31 Aug 2022 13:10:15 +0000
References: <20220827153815.124475-1-duoming@zju.edu.cn>
In-Reply-To: <20220827153815.124475-1-duoming@zju.edu.cn>
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Sat, 27 Aug 2022 23:38:15 +0800 you wrote:
> The function neigh_timer_handler() is a timer handler that runs in an
> atomic context. When used by rocker, neigh_timer_handler() calls
> "kzalloc(.., GFP_KERNEL)" that may sleep. As a result, the sleep in
> atomic context bug will happen. One of the processes is shown below:
> 
> ofdpa_fib4_add()
>  ...
>  neigh_add_timer()
> 
> [...]

Here is the summary with links:
  - [net] ethernet: rocker: fix sleep in atomic context bug in neigh_timer_handler
    https://git.kernel.org/netdev/net/c/c0955bf957be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


