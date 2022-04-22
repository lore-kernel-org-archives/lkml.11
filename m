Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937E8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Apr 2022 22:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiDVW4k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiDVW40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:56:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02642702E2;
        Fri, 22 Apr 2022 15:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A87262123;
        Fri, 22 Apr 2022 22:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F4EAC385AB;
        Fri, 22 Apr 2022 22:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650666012;
        bh=RnCJaR8E6QPF7yP+mo6mKPy5EeOanC7RAlmXwDM7E+I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ktcEoBJFXbj6GJGM1SKd+C7qUjSJV7jNrzPrT6d0L83oYPyBLNEL+X40Ru63SGqTO
         1OOWYyVS8ObcbkjA0OQfyrJ9rxWW5C8H7zbqGrCTOr3mZ5aJhFClw3nm7UMXD8dydq
         /Iej83/0AsulbEpAa9Dr7ArSr32JX3jGOwu35/N1sIlhmukx/pjgaJTqpwi+7O86B4
         ubPYULSrNxwofyNW8yXw2/y46Xyj9L62BoZxYVCmxPOXmFn9FgOAy4LaOd0UDriBdQ
         n+i1hpYGVBj2da/16KhqfBxjOMJKX17LsQiIK5XKlUsWd2iyPCG1X3wkjmDkiXXYaJ
         2tNrwEpPHC9yA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82CA4E6D402;
        Fri, 22 Apr 2022 22:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] tcp: md5: incorrect tcp_header_len for incoming
 connections
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165066601253.17746.2255249203148338043.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Apr 2022 22:20:12 +0000
References: <20220421005026.686A45EC01F2@us226.sjc.aristanetworks.com>
In-Reply-To: <20220421005026.686A45EC01F2@us226.sjc.aristanetworks.com>
To:     Francesco Ruggeri <fruggeri@arista.com>
Cc:     pabeni@redhat.com, kuba@kernel.org, dsahern@kernel.org,
        yoshfuji@linux-ipv6.org, davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 Apr 2022 17:50:26 -0700 you wrote:
> In tcp_create_openreq_child we adjust tcp_header_len for md5 using the
> remote address in newsk. But that address is still 0 in newsk at this
> point, and it is only set later by the callers (tcp_v[46]_syn_recv_sock).
> Use the address from the request socket instead.
> 
> v2: Added "Fixes:" line.
> 
> [...]

Here is the summary with links:
  - [v2,net] tcp: md5: incorrect tcp_header_len for incoming connections
    https://git.kernel.org/netdev/net/c/5b0b9e4c2c89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


