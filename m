Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73793C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 11:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348052AbiCOLv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 07:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348050AbiCOLvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:51:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3CB506FA;
        Tue, 15 Mar 2022 04:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11DD3B815D4;
        Tue, 15 Mar 2022 11:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF500C340ED;
        Tue, 15 Mar 2022 11:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647345010;
        bh=7zKKkK6thjRzy0CdUHiyxL71TTDDKxp55sKiyhoLiMk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lnBahXfuDLIJug7pPkf5023s6kVWhGbSyjti69A0PfUg+Vufr5p2AvBM6BBxcfQ1j
         YJPIkg2vm5jfUhumyWim+V+UTtOprIyagNvwlyqTYxTdtrNRzrn+70uvOydaDLoef2
         /s5AIcyNne71Jg291G7BC4/scQldl7Mp8TmNPfUKbtpc83hGu5aoJXafVqo+Lp9wJW
         XSm7T19OVMeS5mysBza82hPyQqWBnPejZFBI3XSXu6eJRhz7uidOb/qoPcmOqWwCIH
         TEsBg40fk7PMkGaDxclESb6yVFVqoiW6vZP/MDJ924uA0aVPADKnVJ2DA3KZO2Z1yB
         tfD+zlFrw3OFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95293E8DD5B;
        Tue, 15 Mar 2022 11:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2] net: phy: Kconfig: micrel_phy: fix dependency issue
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164734501060.2501.2253199048865874913.git-patchwork-notify@kernel.org>
Date:   Tue, 15 Mar 2022 11:50:10 +0000
References: <20220314110254.12498-1-anders.roxell@linaro.org>
In-Reply-To: <20220314110254.12498-1-anders.roxell@linaro.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 14 Mar 2022 12:02:54 +0100 you wrote:
> When building driver CONFIG_MICREL_PHY the follow error shows up:
> 
> aarch64-linux-gnu-ld: drivers/net/phy/micrel.o: in function `lan8814_ts_info':
> micrel.c:(.text+0x1764): undefined reference to `ptp_clock_index'
> micrel.c:(.text+0x1764): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_index'
> aarch64-linux-gnu-ld: drivers/net/phy/micrel.o: in function `lan8814_probe':
> micrel.c:(.text+0x4720): undefined reference to `ptp_clock_register'
> micrel.c:(.text+0x4720): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_register'
> 
> [...]

Here is the summary with links:
  - [PATCHv2] net: phy: Kconfig: micrel_phy: fix dependency issue
    https://git.kernel.org/netdev/net-next/c/231fdac3e58f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


