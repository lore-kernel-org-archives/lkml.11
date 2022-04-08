Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A11C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 04:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiDHECZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 00:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiDHECT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:02:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7055811F79F;
        Thu,  7 Apr 2022 21:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18A7EB829B5;
        Fri,  8 Apr 2022 04:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF270C385A9;
        Fri,  8 Apr 2022 04:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649390413;
        bh=J2WMTl7bPGmugySZ0EJ8BHjBtgmM+mIgq+r1Pyfoszk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YRIQX9ojI/RFfN8/4meH0XjNQKRWzJg1+G9LccjF+Ql86HDoDbaHhdfS/ST72gczG
         nsG/IyW9FXGBLLNaauF/qgr9RdY7KzB5/qDsPQs+lRUnNRa1HCavwWsXfcM8ihWUwj
         hweDGnxxznIKLi/i56yY+8VIxGkzl6G7yZTfdl7W0rmfbCP3FuPHFdTnSpaIxE9tCB
         cQyB+8pykYW3Fruenitrpw1diCXue1ok7TQVm+X1QHgEiZuyBDJNGi2lLG0XYGZqUI
         pPX/iaX2Iby7aqaVmHM8OShY4gscziZta9/5GMisIg9rTgsfqLcIo68P/Abs+qBbTx
         9HjEgOvZ1hASQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8996BE8DD18;
        Fri,  8 Apr 2022 04:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: Add tracepoint for tcp_set_ca_state
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164939041355.25172.5642827474257932355.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Apr 2022 04:00:13 +0000
References: <20220406010956.19656-1-jacky_gam_2001@163.com>
In-Reply-To: <20220406010956.19656-1-jacky_gam_2001@163.com>
To:     jackygam2001 <jacky_gam_2001@163.com>
Cc:     edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, rostedt@goodmis.org, mingo@redhat.com,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yhs@fb.com,
        ping.gan@dell.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Apr 2022 09:09:56 +0800 you wrote:
> From: Ping Gan <jacky_gam_2001@163.com>
> 
> The congestion status of a tcp flow may be updated since there
> is congestion between tcp sender and receiver. It makes sense to
> add tracepoint for congestion status set function to summate cc
> status duration and evaluate the performance of network
> and congestion algorithm. the backgound of this patch is below.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: Add tracepoint for tcp_set_ca_state
    https://git.kernel.org/netdev/net-next/c/15fcdf6ae116

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


