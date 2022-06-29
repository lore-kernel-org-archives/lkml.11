Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6350CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 15:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiF2PAQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 11:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiF2PAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A0018B26;
        Wed, 29 Jun 2022 08:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0FC361FBB;
        Wed, 29 Jun 2022 15:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07EAEC341CB;
        Wed, 29 Jun 2022 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656514814;
        bh=zI2C4UhduAZvbpcBT6RlMDdIriqAB5o5fTV0Dx8/V9k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QSjcxfMBqmolT5Kh/6ZduOuy0SnsHSefymWE/wGbtOOD3RNGhDwB+Sdr6rIPYcves
         hi7xEcGndcD/OAE5JkBEvQtAe13riIdH2K0yMiGULLmea2z3QZsY8/Bqiqja/ILxrF
         rZb4j2WsqJH/mrkwXDZxnrDd8Coe7SqUsFHGGOeH8Zh1xqAxRUEHRaHBRER3ogvDo2
         meuo0cLOeurAsTfJ856A5DCxHHF6O8+DzFofA1qr2wLJKqthdEdo8WgwLaWE29Kany
         lZi7495sz3ZB5b/tAFOhzSSTprxmuU9BwR3JegQlAOlAIOFfbAU4ZvqM0OPcb4iMmn
         qTY3+/H/vyvgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB454E49BBB;
        Wed, 29 Jun 2022 15:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: prestera: acl: add support for 'egress' rules
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165651481389.15358.9499561545776677242.git-patchwork-notify@kernel.org>
Date:   Wed, 29 Jun 2022 15:00:13 +0000
References: <20220627095019.152746-1-maksym.glubokiy@plvision.eu>
In-Reply-To: <20220627095019.152746-1-maksym.glubokiy@plvision.eu>
To:     Maksym Glubokiy <maksym.glubokiy@plvision.eu>
Cc:     tchornyi@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Mon, 27 Jun 2022 12:50:18 +0300 you wrote:
> The following is now supported:
> 
>   $ tc qdisc add PORT clsact
>   $ tc filter add dev PORT egress ...
> 
> Signed-off-by: Maksym Glubokiy <maksym.glubokiy@plvision.eu>
> 
> [...]

Here is the summary with links:
  - [net-next] net: prestera: acl: add support for 'egress' rules
    https://git.kernel.org/netdev/net-next/c/702e70143291

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


