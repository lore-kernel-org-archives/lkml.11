Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85173C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 03:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiGSDk1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jul 2022 23:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiGSDkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 23:40:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135CC62C8;
        Mon, 18 Jul 2022 20:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B198AB81901;
        Tue, 19 Jul 2022 03:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B797C341D3;
        Tue, 19 Jul 2022 03:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658202014;
        bh=Ha+G7/QZOBlSIVc+THxNSr3mjDzy4K0v97LH89eHzqE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ctj02x3oBaDnFmMd+kKobIerGKxk0/SGRgEQq3YQDp3RzOOg5DBiPZS/2GHZ+MhlO
         243812RrjLPHgwtOS5EuzXPAj15bPOrFnDeQdt8ZXCRar1fBfrFEG62JMdALNYrbW6
         Fr6505jakd4QjY0n28/ppisuhCdGysLfyviJh7lqZlQBLWSd4BaKxaCwJmUVMa40RP
         hKGHgd7jLGct8I4oySBoxueDIfTDlWVFVOx8FRmCzSeumNGxekDH5ipQ08rX4evxD/
         Ln8ZUtE7cJCH2uEYuivLFf62dyFts7oUTz7Ic7ARJ8EmIc92iWoFTwFFUMVGDlsEL4
         R7GDF3niYREWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32ADBE451BD;
        Tue, 19 Jul 2022 03:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net: stmmac: remove redunctant disable xPCS EEE call
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165820201420.29134.3465900880511304469.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Jul 2022 03:40:14 +0000
References: <20220715122402.1017470-1-vee.khee.wong@linux.intel.com>
In-Reply-To: <20220715122402.1017470-1-vee.khee.wong@linux.intel.com>
To:     Wong Vee Khee <vee.khee.wong@linux.intel.com>
Cc:     davem@davemloft.net, peppe.cavallaro@st.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        kuba@kernel.org, mcoquelin.stm32@gmail.com, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Jul 2022 20:24:02 +0800 you wrote:
> Disable is done in stmmac_init_eee() on the event of MAC link down.
> Since setting enable/disable EEE via ethtool will eventually trigger
> a MAC down, removing this redunctant call in stmmac_ethtool.c to avoid
> calling xpcs_config_eee() twice.
> 
> Fixes: d4aeaed80b0e ("net: stmmac: trigger PCS to turn off on link down")
> Signed-off-by: Wong Vee Khee <vee.khee.wong@linux.intel.com>
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: stmmac: remove redunctant disable xPCS EEE call
    https://git.kernel.org/netdev/net/c/da791bac104a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


