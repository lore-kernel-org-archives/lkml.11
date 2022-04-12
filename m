Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A510C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 03:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344897AbiDLDmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 23:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344892AbiDLDma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 23:42:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541C713E3C;
        Mon, 11 Apr 2022 20:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E3A7B81A8D;
        Tue, 12 Apr 2022 03:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B934CC385AE;
        Tue, 12 Apr 2022 03:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649734811;
        bh=QSsKy83Tm0f2ZZsihBg96iw58bRZQn7S4W9PNzeh6IU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NxtyIYEfueBaHbM2MfB0w9z9bqeoYdVe4N7T0pIWDfo3db0loc10hklAXeu7IqXHq
         E1oahx3XM2qt4aJwziCkzRp9iCoSeE4ILLvDk7tGS1YNh0g2wFfgAIbjhdK7rdave+
         OgMKkzMHKd71phnAwvEvZwDk2xEFofUXQFs6YGv62NhufhyECL0ugAGGKTRqv3SOu3
         u7bf+Lge3+xJD/67kDljEw+ouUB2XelIVyw8tpTsrbauROWPbmES5ev0DuhtR4kS5A
         hkxIcCMiz8nqYImM4EFI0AaNPsn/D2dF3xzfeqEQZN/CLkJsw0OeJv20cKKYPyNyxt
         ZOGtifyQm5u2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1D2BE8DBD1;
        Tue, 12 Apr 2022 03:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: stmmac: using pm_runtime_resume_and_get instead of
 pm_runtime_get_sync
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164973481165.21815.4242211129127788144.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Apr 2022 03:40:11 +0000
References: <20220408081250.2494588-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220408081250.2494588-1-chi.minghao@zte.com.cn>
To:     CGEL <cgel.zte@gmail.com>
Cc:     peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chi.minghao@zte.com.cn, zealci@zte.com.cn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Apr 2022 08:12:50 +0000 you wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> 
> [...]

Here is the summary with links:
  - net: stmmac: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
    https://git.kernel.org/netdev/net-next/c/e2d0acd40c87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


