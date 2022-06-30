Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC941C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 09:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbiF3Jkv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 05:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiF3JkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:40:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F8E43AC4;
        Thu, 30 Jun 2022 02:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DE56B827E3;
        Thu, 30 Jun 2022 09:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E27BC341CA;
        Thu, 30 Jun 2022 09:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656582013;
        bh=RY4c7Pum0yD/rlWNWuPghL/24LB9E8YULvxz3Jn4vsA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=T0VlJwQJ3Dt59UgcmGhcz+EZl+yiCOCupLsKaZoV8A10tZvI3Qh7c77/lrSQ/uxGR
         tTtAnreuB3Uzgf7up8qNa8BMVxc650SfqBTHZ+f5qZ66UPJaeuJ0RN43sxrIs8oS4A
         ZJNN9Zbob2AoVslMcyXCfl4HjWZcaY9+5OERTO/7nqmUd9x7t73F1mCP0T1WVKnF3q
         yeeIJ+EMy6mzr5u7tFG1q1P7tNkbN34BAS782HN0KJcc4NqC6W9803J8BhKhZuMx67
         PHFGKG6tsP9OwXPdbKlgQ6YDNt5Inxn5SOIlHLDwYJMA0Q/sdFeHohuMN62BG4Izju
         6nNt74+Y3sjKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0096EE49BBB;
        Thu, 30 Jun 2022 09:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 RESEND] net: rose: fix UAF bugs caused by timer handler
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165658201299.18643.15753400397215370488.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Jun 2022 09:40:12 +0000
References: <20220629002640.5693-1-duoming@zju.edu.cn>
In-Reply-To: <20220629002640.5693-1-duoming@zju.edu.cn>
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, ralf@linux-mips.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 29 Jun 2022 08:26:40 +0800 you wrote:
> There are UAF bugs in rose_heartbeat_expiry(), rose_timer_expiry()
> and rose_idletimer_expiry(). The root cause is that del_timer()
> could not stop the timer handler that is running and the refcount
> of sock is not managed properly.
> 
> One of the UAF bugs is shown below:
> 
> [...]

Here is the summary with links:
  - [v3,RESEND] net: rose: fix UAF bugs caused by timer handler
    https://git.kernel.org/netdev/net/c/9cc02ede6962

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


