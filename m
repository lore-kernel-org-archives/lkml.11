Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999DDC04AA5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 01:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiHYB5S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 21:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiHYB47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 21:56:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCF0A1D0D;
        Wed, 24 Aug 2022 18:51:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05EA760DE4;
        Thu, 25 Aug 2022 01:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60A95C4347C;
        Thu, 25 Aug 2022 01:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661392214;
        bh=pcOqHJ5OtoMjIvOh0M9GjMirUSz25xmeL8d2/yf+u+c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qtioLEhDnng4MZcBkq1rYE1rzQ2a3Ixn7F0HvxMX3vlGxeaat3FvF8NN1+uRe+zdF
         argS+1rxX1+r4bxiEFcYtV2PhU8D+ynLqfqVHR+1H0aq4CxgEWOGbRZC/2CJbkQ22s
         plXd9hbGLUtMC+2Nl+rAPMWHDzq29kPiqV3nDoB0BSCfdNFgoBc45xilCLAbCGxsS+
         aJF5WrIv6oqQpwBA7Q5S5wqlfbNsy+bLIuOekVUYov9lwqdh3psdyWvupKaZR+jYTQ
         kGwNMAYYNqDTH3Akn8UfDBZcx1MS7tuhFpa0irpkpJfFZNETPHWRUnNx/k7UwmqOet
         cP9YHOjkHDyDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48110C0C3EC;
        Thu, 25 Aug 2022 01:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Documentation: sysctl: align cells in second content
 column
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166139221428.11258.13872554797501208069.git-patchwork-notify@kernel.org>
Date:   Thu, 25 Aug 2022 01:50:14 +0000
References: <20220824035804.204322-1-bagasdotme@gmail.com>
In-Reply-To: <20220824035804.204322-1-bagasdotme@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        corbet@lwn.net, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, hmukos@yandex-team.ru, lucien.xin@gmail.com,
        stephen@networkplumber.org, atenart@kernel.org,
        razor@blackwall.org, dsahern@kernel.org, sfr@canb.auug.org.au
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Aug 2022 10:58:04 +0700 you wrote:
> Stephen Rothwell reported htmldocs warning when merging net-next tree:
> 
> Documentation/admin-guide/sysctl/net.rst:37: WARNING: Malformed table.
> Text in column margin in table line 4.
> 
> ========= =================== = ========== ==================
> Directory Content               Directory  Content
> ========= =================== = ========== ==================
> 802       E802 protocol         mptcp     Multipath TCP
> appletalk Appletalk protocol    netfilter Network Filter
> ax25      AX25                  netrom     NET/ROM
> bridge    Bridging              rose      X.25 PLP layer
> core      General parameter     tipc      TIPC
> ethernet  Ethernet protocol     unix      Unix domain sockets
> ipv4      IP version 4          x25       X.25 protocol
> ipv6      IP version 6
> ========= =================== = ========== ==================
> 
> [...]

Here is the summary with links:
  - [net-next] Documentation: sysctl: align cells in second content column
    https://git.kernel.org/netdev/net-next/c/1faa34672f8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


