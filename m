Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF62AC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Apr 2022 12:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357231AbiDCMMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Apr 2022 08:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbiDCMMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 08:12:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1444F27B0D;
        Sun,  3 Apr 2022 05:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BF366111A;
        Sun,  3 Apr 2022 12:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1529C34112;
        Sun,  3 Apr 2022 12:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648987810;
        bh=0bblxPPvXqMxXV6Zwsr68c3xzusz/3jsIzxstdgbKEE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FLOpMBCFUbIpIahn9bPzgK5WyqPNRfyQ9vDdw4OR0VRWduBwIvmv7c8UdyV4fYwVY
         rqKjAz8jgIDtTU/YwfbXEwnuiHF7gJQOz9MYj9O/SPfMwj/vIqbNPD0WF6QY9qTo2e
         hahcbq849DTrPSzs9d4kGxKSJFRrIUr66P2SX5nGsXPSm780SOf9FAFH/nraB1ZdWv
         2PvF7kUJB32JrS/6OtQ9wSoHoqZsYh6UTlLtmfkeW8COs4aeRrfD+NxgYgGKHC5x+7
         gtE42BDerGc5n998R+h32IPM5bBRjx9+rOoKU46AxShZX/pDN0Rc+uEOauTnZAYKEl
         BUFDetNZaD+aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE63AE7BB0B;
        Sun,  3 Apr 2022 12:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] docs: net: dsa: fix minor grammar and punctuation issues
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164898781071.6266.2536082680283988294.git-patchwork-notify@kernel.org>
Date:   Sun, 03 Apr 2022 12:10:10 +0000
References: <20220402144623.202965-1-helgaas@kernel.org>
In-Reply-To: <20220402144623.202965-1-helgaas@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        corbet@lwn.net, vladimir.oltean@nxp.com, f.fainelli@gmail.com,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Sat,  2 Apr 2022 09:46:23 -0500 you wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix a few typos and minor grammatical issues.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/networking/dsa/dsa.rst | 64 ++++++++++++++--------------
>  1 file changed, 32 insertions(+), 32 deletions(-)

Here is the summary with links:
  - docs: net: dsa: fix minor grammar and punctuation issues
    https://git.kernel.org/netdev/net/c/5a48b7433a5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


