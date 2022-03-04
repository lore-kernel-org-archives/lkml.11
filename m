Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E582C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 13:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiCDNLc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 08:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiCDNLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:11:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF961B8BEF;
        Fri,  4 Mar 2022 05:10:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0E66601B6;
        Fri,  4 Mar 2022 13:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03D7CC36AE3;
        Fri,  4 Mar 2022 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646399413;
        bh=EvrSNaGtxB0W9UhBAOfNYFjzfF3ttJeEJoP7OTkzaNo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VH572zDDk+vysS5o8OaEBFvdAZB4Bghe7tFZ/cEbtYmCMnc3PXmIno0A/K/Xbuj8m
         6paLfoCWBHwWuGxyEYUd9vu3CJZtSNxqZoBpH4j4jsX2GhFMuHYKbUxABmh0pJ//Sg
         wL5x3JpBhxve/d4wi6T/HXzVESoWtVLR5mxta3CZD3p+bj3gOwFgUg8k9d3JK1D9tD
         Ik+ShE1BXvdkaBaUmFVZRb951DhMXHBak5lKiaxsPP+h6MRBcMOBQ941dHwV/l4z+X
         Sb8OyFy4gGZFyinaztlZIi7cnidvwXv0f2EUYuVOoakCm2mSnAk21IAFJZaweo/Jl1
         TlFac89A7W8eA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFF0FEAC099;
        Fri,  4 Mar 2022 13:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: ethernet: sun: Remove redundant code
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164639941291.4305.8882677453916625123.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Mar 2022 13:10:12 +0000
References: <20220304083653.66238-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220304083653.66238-1-jiapeng.chong@linux.alibaba.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     davem@davemloft.net, kuba@kernel.org, gustavoars@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        abaci@linux.alibaba.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri,  4 Mar 2022 16:36:53 +0800 you wrote:
> Since the starting value in the for loop is greater than or equal to 1,
> the restriction is CAS_FLAG_REG_PLUS is in the file cassini.h is
> defined as 0x1 by macro, and the for loop and if condition is not
> satisfied, so the code here is redundant.
> 
> Clean up the following smatch warning:
> 
> [...]

Here is the summary with links:
  - [v2] net: ethernet: sun: Remove redundant code
    https://git.kernel.org/netdev/net-next/c/1039135aedfc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


