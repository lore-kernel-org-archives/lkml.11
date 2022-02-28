Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D486DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 13:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbiB1Nb5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 08:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiB1Nbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:31:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD577B559;
        Mon, 28 Feb 2022 05:31:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5AC4B810DD;
        Mon, 28 Feb 2022 13:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4996C340FC;
        Mon, 28 Feb 2022 13:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646055059;
        bh=1ia+snfJ5Mt+LKRqsgmhlU/MdPrM/xXjXAwfJjhkEdg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ik1K/CAvyMfeRogy98gzXbq5PHC8vLDMYlldQycE6gnF1xM46vxAUm9Oni2TtQfBS
         kPSzzn0wpcd4upRYSU4QCZN2rFonq0O4WMeX3A31ydEsIAKD6QSTX8IBp/vMGNZtfI
         GnLes4Ykth3rWhEVH2reGY+5aalmLStZVq1pihYj/ikDV0iLftwlbO2fr9DaRIH9Sp
         /swoxugUQwl8spwHIfTBdRHvLxgZUZrChxLltZcTkpQDirB7yWpQ1spBJstZPCdxVM
         qXC0eM/ciicdTPCCawiZFhssdXSYn46UHMIatUL0RC7DgJpo2lz+3QmdZyWSxMUJY4
         uIc/q6/kOVmcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA02AE5D087;
        Mon, 28 Feb 2022 13:30:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: decnet: use time_is_before_jiffies() instead of open
 coding it
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164605505969.13902.12629071764540834310.git-patchwork-notify@kernel.org>
Date:   Mon, 28 Feb 2022 13:30:59 +0000
References: <1646018155-61556-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1646018155-61556-1-git-send-email-wangqing@vivo.com>
To:     Qing Wang <wangqing@vivo.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-decnet-user@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Sun, 27 Feb 2022 19:15:55 -0800 you wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> Use the helper function time_is_{before,after}_jiffies() to improve
> code readability.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> 
> [...]

Here is the summary with links:
  - net: decnet: use time_is_before_jiffies() instead of open coding it
    https://git.kernel.org/netdev/net-next/c/98fffd72f934

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


