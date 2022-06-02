Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AE6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 18:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbiFBSUo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 14:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238049AbiFBSUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:20:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA645E756;
        Thu,  2 Jun 2022 11:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAF79B8212E;
        Thu,  2 Jun 2022 18:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C0BCC34115;
        Thu,  2 Jun 2022 18:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654194014;
        bh=bvRpiUFhvFmW2rWN3Ojnjkq+frJrph+s5sVUtgOIaKA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=li1pyebeg1hCGjlRZecL7fERA/9RtW6emhxvUn0CaDHc0t+rGKJ16lW6Wvt5MCT7s
         YAe4DWPNxxbr+PJsV5GY5b2pOqIo0CtAuLQWrjoHJ8Cb6AuHsNpyQzAisCAI+RzmJv
         3WbgNcY3F/EdchQQGai0uIGGhJQJusnPtJ+lLGcNRKW1g2uI8cn2i6NpP2nVXsUpq3
         xLnmSLkmy3mqFKY9Ti3l4GJpDcJoPbfmcf6CcX7Cm7F8BitUFBbWYycadZJCZGPo08
         yP+madLbn7Cl8cO1JdKuA60/tBIy0dfaaWAXgekzSYLRUO6DXN9UI4Kk3i/O9UtLD6
         eWXzhaS2f4nQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61077F0394E;
        Thu,  2 Jun 2022 18:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: stmmac: use dev_err_probe() for reporting mdio bus
 registration failure
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165419401439.24492.12105964226436236026.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Jun 2022 18:20:14 +0000
References: <20220602074840.1143360-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20220602074840.1143360-1-linux@rasmusvillemoes.dk>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Jun 2022 09:48:40 +0200 you wrote:
> I have a board where these two lines are always printed during boot:
> 
>    imx-dwmac 30bf0000.ethernet: Cannot register the MDIO bus
>    imx-dwmac 30bf0000.ethernet: stmmac_dvr_probe: MDIO bus (id: 1) registration failed
> 
> It's perfectly fine, and the device is successfully (and silently, as
> far as the console goes) probed later.
> 
> [...]

Here is the summary with links:
  - [v2] net: stmmac: use dev_err_probe() for reporting mdio bus registration failure
    https://git.kernel.org/netdev/net/c/839612d23ffd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


