Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF781C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 04:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344672AbiDLED1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 00:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiDLECc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:02:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D0A245BC;
        Mon, 11 Apr 2022 21:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34100B81B11;
        Tue, 12 Apr 2022 04:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C89B7C385A8;
        Tue, 12 Apr 2022 04:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649736012;
        bh=JQr8nc/fLXzYmZHteS1P6F/+WrEu7PTFCtSGGVDCopQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PSkzPva8YE+ZWh1rsH9fdgPMJlaAQF+hHpwTZKPv2IHbeh7tnSwZrilGmnj81qLGq
         0u1xLC4CCe30oMcQfhopPfLLDTryPpLp71XSd7rIeBVtSbykhpgjb17U1I+s7ji/j9
         85pOb+xndtOTduvIW3GFWD+n//gO4TMazpK1xtUdUu2mxHK4J0nu3ks6QORWQqwzTw
         eArFCxKawzMwqRsXO5o89KqvbUhOy6yHMz2Ymevy3GHcFixYkXLYVrxzlNoMx4T75G
         fLdj0mj6IiHOpiVY462He4ibG9JvHOEqtybIW8ljcB5QRe6WC4iinUimGDBrwkq4xu
         cIqynd0HoXoOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEFCCE8DBD1;
        Tue, 12 Apr 2022 04:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] net: lan966x: lan966x fixes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164973601271.30868.16345323941308657793.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Apr 2022 04:00:12 +0000
References: <20220409184143.1204786-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220409184143.1204786-1-horatiu.vultur@microchip.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 9 Apr 2022 20:41:39 +0200 you wrote:
> This contains different fixes for lan966x in different areas like PTP, MAC,
> Switchdev and IGMP processing.
> 
> Horatiu Vultur (4):
>   net: lan966x: Update lan966x_ptp_get_nominal_value
>   net: lan966x: Fix IGMP snooping when frames have vlan tag
>   net: lan966x: Fix when a port's upper is changed.
>   net: lan966x: Stop processing the MAC entry is port is wrong.
> 
> [...]

Here is the summary with links:
  - [net,1/4] net: lan966x: Update lan966x_ptp_get_nominal_value
    https://git.kernel.org/netdev/net/c/eb9c0d671e94
  - [net,2/4] net: lan966x: Fix IGMP snooping when frames have vlan tag
    https://git.kernel.org/netdev/net/c/6476f90aefaf
  - [net,3/4] net: lan966x: Fix when a port's upper is changed.
    https://git.kernel.org/netdev/net/c/d7a947d289dc
  - [net,4/4] net: lan966x: Stop processing the MAC entry is port is wrong.
    https://git.kernel.org/netdev/net/c/269219321eb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


