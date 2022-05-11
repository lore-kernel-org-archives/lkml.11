Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7E3C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 02:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbiEKCcU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 22:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241541AbiEKCag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:30:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FEB223865;
        Tue, 10 May 2022 19:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C657C61B8C;
        Wed, 11 May 2022 02:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2567CC385D8;
        Wed, 11 May 2022 02:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652236212;
        bh=za8c6QfqMEnkEPDAQWWy5CRNgJf8Ry8Evlv2S0C6WZA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hGbGYL2DMJBSOGpssHCTX6FvGf+mokdSJ/DuZyMAXyYfXMiv8vtdCPAzwwndCPfOe
         UkpigM/mWOpekCjPivze67wdAElsqwYWsZDuniyrefSc/VzqH9bBcne91hamjmFhMZ
         54VdOz/eJvsAjeuIE6a6yOy3PP9kD7E20k4KvAsfubNsTSvBfuqFy4yJBwv+KCRReR
         q6bRkpY2S3oHFPyB9F4u3p3AZ6WfO3F0+Amrvx39jHxk38YPA7bqrC/VcECrgzgIIA
         Y2cgHaIul+YV2BFUYJoJivUHCiZBt0oLWsioyGlCL/8++PHfElx0E/gv93nYcYU5/8
         SnRZ67Vd6zeFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BC74F0392C;
        Wed, 11 May 2022 02:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: stmmac: fix missing pci_disable_device() on error in
 stmmac_pci_probe()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165223621204.26540.11895833024977665930.git-patchwork-notify@kernel.org>
Date:   Wed, 11 May 2022 02:30:12 +0000
References: <20220510031316.1780409-1-yangyingliang@huawei.com>
In-Reply-To: <20220510031316.1780409-1-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 May 2022 11:13:16 +0800 you wrote:
> Switch to using pcim_enable_device() to avoid missing pci_disable_device().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   v2: switch to using pcim_enable_device()
> 
> [...]

Here is the summary with links:
  - [v2] net: stmmac: fix missing pci_disable_device() on error in stmmac_pci_probe()
    https://git.kernel.org/netdev/net/c/0807ce0b0104

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


