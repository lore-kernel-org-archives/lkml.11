Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78289C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 23:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiDLXY3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 19:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiDLXYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:24:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8538A5BD0D;
        Tue, 12 Apr 2022 15:10:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8BA4FCE20CB;
        Tue, 12 Apr 2022 22:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE27EC385AA;
        Tue, 12 Apr 2022 22:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649800811;
        bh=1pT1rKstnA/xfByk8gzUWt5r+vz6RbFdQNtjjloFPq4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cS+6/lgLPAuhPGp8lxPTY24+WP+3iQGjGrM0Liom18Gu0z1/WSVSEvrcupW67b7bp
         tRGlTMwK0lTURg5Ck0gyCbWIU2tFy2i70jty6ssLU42M8uWd8IAxgEXcmyeeZLHP58
         O6W+pwdK+4NDTvd4A2R3Rm4iZ2IrwbOBOTq/pLgIhnikrJqqdlklQWiBT4qcgeLQqk
         hRvnIB94iBfFkc7YNL9KG0JJmF9mD3VGBeY/4bFZmDuZzmRt2pMGPs5Vcn1009EhoF
         L4P2SwIYec6Td0Q8k7Ifv1SZfI0u7WRb1SNfX/x1Z9rOJ7nRRkFixxxWnsQmtYhNbU
         N0rUpXlxS2VaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8EED7E8DD5E;
        Tue, 12 Apr 2022 22:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] fou: Remove XRFM from NET_FOU Kconfig
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164980081157.20212.8870993161912217213.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Apr 2022 22:00:11 +0000
References: <20220411213717.3688789-1-lixiaoyan@google.com>
In-Reply-To: <20220411213717.3688789-1-lixiaoyan@google.com>
To:     Coco Li <lixiaoyan@google.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        willemb@google.com, edumazet@google.com, gthelen@google.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Apr 2022 14:37:17 -0700 you wrote:
> XRFM is no longer needed for configuring FOU tunnels
> (CONFIG_NET_FOU_IP_TUNNELS), remove from Kconfig.
> 
> Also remove the xrfm.h dependency in fou.c. It was
> added in '23461551c006 ("fou: Support for foo-over-udp RX path")'
> for depencies of udp_del_offload and udp_offloads, which were removed in
> 'd92283e338f6 ("fou: change to use UDP socket GRO")'.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] fou: Remove XRFM from NET_FOU Kconfig
    https://git.kernel.org/netdev/net-next/c/753b953774b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


