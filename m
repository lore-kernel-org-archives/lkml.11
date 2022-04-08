Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F697C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 11:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiDHLCU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 07:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiDHLCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:02:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3E8F844A;
        Fri,  8 Apr 2022 04:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37E1461F7B;
        Fri,  8 Apr 2022 11:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A487C385A5;
        Fri,  8 Apr 2022 11:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649415612;
        bh=5V2H/avkRnqCfDyYcArGASEXAebwxezA5cdgwAkbkHI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rDkl40MVK8pe0VFWRR+6nkvzyT8uxD7gqyNEq6nLX7cNyonuS6XKIZQ9+Sdw9q1oi
         2gkhd7ZuLjbvHS+FlNl5/Mna5HY0xAgX4gMIhkVStolfeoaZuwPSji0RVoK620422q
         bB4i+JbOL4SZ4y/hmQ7bBz1cOHWH5b6WZPMnx/ATdi6fGK85PlhV0iJjizgeanZGcD
         PSfHWSUPl030QriC+JMppr/QJ0zEtzdzW9NCJcobJTUCItdexnCa+M9MfIns5sw+PS
         /APGeG0sGjmSIeJUM0ZVieKu+LnZDR5blGorGSpr4qHKyGNOFn88oOadakj3Fx2CCd
         AZwiOM55NIAgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B765E85BCB;
        Fri,  8 Apr 2022 11:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] dt-bindings: net: Fix ave descriptions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164941561236.15361.17486184547256592773.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Apr 2022 11:00:12 +0000
References: <1649145181-30001-1-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1649145181-30001-1-git-send-email-hayashi.kunihiko@socionext.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, mhiramat@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Tue,  5 Apr 2022 16:52:59 +0900 you wrote:
> This series fixes dt-schema descriptions for ave4 controller.
> 
> Kunihiko Hayashi (2):
>   dt-bindings: net: ave: Clean up clocks, resets, and their names using
>     compatible string
>   dt-bindings: net: ave: Use unevaluatedProperties
> 
> [...]

Here is the summary with links:
  - [1/2] dt-bindings: net: ave: Clean up clocks, resets, and their names using compatible string
    https://git.kernel.org/netdev/net/c/2610bd72efe4
  - [2/2] dt-bindings: net: ave: Use unevaluatedProperties
    https://git.kernel.org/netdev/net/c/5a80059d8804

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


