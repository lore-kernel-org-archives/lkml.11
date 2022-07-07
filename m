Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B309C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Jul 2022 19:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiGGTKc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Jul 2022 15:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbiGGTKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:10:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DBA21E3C;
        Thu,  7 Jul 2022 12:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FC2DB8229A;
        Thu,  7 Jul 2022 19:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A55FAC341C6;
        Thu,  7 Jul 2022 19:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657221026;
        bh=AXT0QwQ+C3Ok4Ijv8ZPM1RMtVPUftjLd3GsN/eSVPGM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EKtH+VFPEOY3Vwu/DF+FYCAQRQFQ/OCJp+wWqycN71qmRBNQSz4pEzdRyj7VOhOsZ
         qXt7ZiEudFwYlBVvC0ZFWICRhWZ/RGcUNwh/kiwm3ry9w8DvUREwMubdvguoxuwFmp
         Bpr+Ylgwuytc4vewATgfX3U71lmTGJTjszvvfU/dMrMGsA42NkPnE7vEsuBcrcENxB
         cAPytpUFYPH9mj3etkTw7y5m5wYWaip6lR1ffKr314ZGmMxWDmyRl7HUd5nQsAK6de
         OER8AIuUiXUPGjBqwQ49N1iG+ow0uXHjAg2xBdXzRrGyLJxG4eVnGifpovvjphsvHr
         1nZtn4wZ+goDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89C26E45BD9;
        Thu,  7 Jul 2022 19:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for 5.19-rc6
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165722102655.25210.83575038336801209.git-patchwork-notify@kernel.org>
Date:   Thu, 07 Jul 2022 19:10:26 +0000
References: <20220707102125.212793-1-pabeni@redhat.com>
In-Reply-To: <20220707102125.212793-1-pabeni@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu,  7 Jul 2022 12:21:25 +0200 you wrote:
> Hi Linus!
> 
> No known regressions on our radar at this point.
> 
> The following changes since commit 5e8379351dbde61ea383e514f0f9ecb2c047cf4e:
> 
>   Merge tag 'net-5.19-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2022-06-30 15:26:55 -0700)
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for 5.19-rc6
    https://git.kernel.org/netdev/net/c/ef4ab3ba4e4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


