Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD85FC3F6B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Aug 2022 04:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbiHIEAY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Aug 2022 00:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHIEAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 00:00:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED5BDD7;
        Mon,  8 Aug 2022 21:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3665161165;
        Tue,  9 Aug 2022 04:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89B28C433C1;
        Tue,  9 Aug 2022 04:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660017614;
        bh=0zuPuI9oltl+XSx8zJPE3c1haO5OclQwKYEyUHU4Q3U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ec8bYfX4cJFWdbnyPzZT2jarZY1t42Bu1jqKqJGHbS/7zTHLI4y4JgjmvW8td383e
         L7A1bDL9cQLwrCkT5xAS9nkHi18j9fXBCRz0BY2ewjmCjR1VQegXrNBpJpKEZ1kG8u
         iD0ISC+5a6p2FdjiPDKO4o7+ZZ4M5LAOlaNgopTzHNpVYaFRtP347Qnb0p826wS6yl
         G+g/j+t2F6HrDZBxjpNAoOjOj12OkgU9nvgCv3eMHFmSe8p+MKQhAQD6vyVs7tM+/M
         UmNRxqecTDmyiMEvchb2qSCQHMR+gTvxLR8ReBKuUQeynXfAGWMwP+TPLQfrl9MzRl
         ilqQvO0LnW9yQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69B9FC43140;
        Tue,  9 Aug 2022 04:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: felix: fix min gate len calculation for tc when
 its first gate is closed
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166001761442.6286.6031346686908712641.git-patchwork-notify@kernel.org>
Date:   Tue, 09 Aug 2022 04:00:14 +0000
References: <20220804202817.1677572-1-vladimir.oltean@nxp.com>
In-Reply-To: <20220804202817.1677572-1-vladimir.oltean@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, xiaoliang.yang_1@nxp.com,
        richard.pearn@nxp.com, claudiu.manoil@nxp.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Aug 2022 23:28:17 +0300 you wrote:
> min_gate_len[tc] is supposed to track the shortest interval of
> continuously open gates for a traffic class. For example, in the
> following case:
> 
> TC 76543210
> 
> t0 00000001b 200000 ns
> t1 00000010b 200000 ns
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: felix: fix min gate len calculation for tc when its first gate is closed
    https://git.kernel.org/netdev/net/c/7e4babffa6f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


