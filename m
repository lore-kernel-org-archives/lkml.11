Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF317C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 20:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiGKUkQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 16:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGKUkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:40:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A812F6716C;
        Mon, 11 Jul 2022 13:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40A9E615F9;
        Mon, 11 Jul 2022 20:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95BACC341CB;
        Mon, 11 Jul 2022 20:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657572013;
        bh=93mOM3cxrzM0+NvlClplt2QWuvIOUfwNWYuZS72n8sA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MbZPx+roPZKB3A4Voxqm5sfu/kXmzWS6ehjNDhg0nnBUC4nS3ucXoaJVXdwwK0qX4
         5J5l8xAfdRV6Y19HN0/emLiaV03G1+6FqKl6Ba6mIxoEYHyXP5BpO7FG0jnKRJQIoX
         vM3DCYg3C7tuKvx9xYoQBVMeReWkSkvGdyVo/aiFq7y2ga7wwxbLNdouYqmasDiBjh
         qdYjm7vaBdoqf8f2UbyFwCFoJEQIfBsj6OVpCWxC7FnQFDWqcXNMRfd0N4QjKY3MX+
         941ji6CrD9LyttRu3Lc10sMT1NHiGrR1rIxU5L4OgjVNcFc4nVM92RvPOiSLXL2V7K
         fgmHQTl9DqYpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72099E45225;
        Mon, 11 Jul 2022 20:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bcm63xx: fix Tx cleanup when NAPI poll budget is zero
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165757201346.9109.10275172511072121523.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Jul 2022 20:40:13 +0000
References: <20220708080303.298-1-liew.s.piaw@gmail.com>
In-Reply-To: <20220708080303.298-1-liew.s.piaw@gmail.com>
To:     Sieng-Piaw Liew <liew.s.piaw@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Jul 2022 16:03:03 +0800 you wrote:
> NAPI poll() function may be passed a budget value of zero, i.e. during
> netpoll, which isn't NAPI context.
> Therefore, napi_consume_skb() must be given budget value instead of
> !force to truly discern netpoll-like scenarios.
> 
> Fixes: c63c615e22eb ("bcm63xx_enet: switch to napi_build_skb() to reuse skbuff_heads")
> Signed-off-by: Sieng-Piaw Liew <liew.s.piaw@gmail.com>
> 
> [...]

Here is the summary with links:
  - bcm63xx: fix Tx cleanup when NAPI poll budget is zero
    https://git.kernel.org/netdev/net-next/c/10c8fd2f7a40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


