Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A06C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 06:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiCCGVJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 01:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiCCGU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:20:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CF6166E3E;
        Wed,  2 Mar 2022 22:20:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1E33ECE254A;
        Thu,  3 Mar 2022 06:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51F57C340F1;
        Thu,  3 Mar 2022 06:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646288411;
        bh=2zJXSJwtIog4m6Hi3l5UpqnmitP/JXcddG36457y4tQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aoFL4k8jo3JxPJ+eskLPmTZkwjrzZ36Tu01pNxisdv0VrYiURB2uetz2hxjQ6+zqj
         u0ILL75Ym6Bss+dAwddmLhp933SrvKRmD6Ho8LAInrzuegZHjYc/eukiYsMMODIilP
         iWztcP1zZlBX7mjlZOGU6piuY7qxPrFS8rk02kTX8zF+ZhQI5nm5lMDd7nfqETE9ST
         NP20Ak+wn+K2Ph8dbaW50eJmfvJ4P+8iIDvfdBONo3QWsSGV3FIZcBY9URZkxZUiVI
         OhtWcsACHcqmj6P444bc4DLIUHruXtDS3ekppfAFt6nGtPpEhBJO02foIhnisWBqqQ
         r6E6+dJWFzOAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37B10E7BB08;
        Thu,  3 Mar 2022 06:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ipa: add an interconnect dependency
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164628841122.5215.2628804126734624595.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Mar 2022 06:20:11 +0000
References: <20220301113440.257916-1-elder@linaro.org>
In-Reply-To: <20220301113440.257916-1-elder@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     davem@davemloft.net, kuba@kernel.org, bjorn.andersson@linaro.org,
        mka@chromium.org, evgreen@chromium.org, cpratapa@codeaurora.org,
        avuyyuru@codeaurora.org, jponduru@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org, lkp@intel.com,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Mar 2022 05:34:40 -0600 you wrote:
> In order to function, the IPA driver very clearly requires the
> interconnect framework to be enabled in the kernel configuration.
> State that dependency in the Kconfig file.
> 
> This became a problem when CONFIG_COMPILE_TEST support was added.
> Non-Qualcomm platforms won't necessarily enable CONFIG_INTERCONNECT.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ipa: add an interconnect dependency
    https://git.kernel.org/netdev/net/c/1dba41c9d2e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


