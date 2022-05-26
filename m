Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB7BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 05:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345671AbiEZFAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 01:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiEZFAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 01:00:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168BD3584D;
        Wed, 25 May 2022 22:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A16D5619FA;
        Thu, 26 May 2022 05:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4EA9C34116;
        Thu, 26 May 2022 05:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653541212;
        bh=E8F0JbASHpDk8BvoYf8+toyRYsmuFLxx7WVt5BKAtJY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=J18m8ixkjV80MJHE4Npjqj4x2hxySjy6VhMOmZNCgqDQeGvjj0mScU1KvbnfEeRCw
         rrLourvVz9Gq+AcmqPtjrvHyZsF5JZARfedRideq4jqsuyLYZg1h4/GzsRlCwQREa5
         o1/uz2ipzY6Fdb1SAxj9RPtElN2pMqb+MyQhL34JbWAaNVCTF3DcAZ3ETPDWjetEgn
         utAxyJGOvW4eg8FcQlEIt8IdVqFd5lE7OqAv/cMCkyDhsKF005bbBZxrlNhUktg5LX
         hIGXzf2MR23T355KmGv4EQvCov1SekfXAsboiR3ByiVrXRdpHvaIUSjWs3eyJMFf+9
         9SxY5a12owQyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C04A1F03943;
        Thu, 26 May 2022 05:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ptp: ptp_clockmatrix: fix is_single_shot
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165354121278.19512.7453531995605424059.git-patchwork-notify@kernel.org>
Date:   Thu, 26 May 2022 05:00:12 +0000
References: <1653403501-12621-1-git-send-email-min.li.xe@renesas.com>
In-Reply-To: <1653403501-12621-1-git-send-email-min.li.xe@renesas.com>
To:     Min Li <min.li.xe@renesas.com>
Cc:     richardcochran@gmail.com, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 May 2022 10:45:01 -0400 you wrote:
> is_single_shot should return false for the power_of_2 mask
> 
> Fixes: b95fcd0e776f ("ptp: ptp_clockmatrix: Add PTP_CLK_REQ_EXTTS support")
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
> -Add Fixes tag
> 
> [...]

Here is the summary with links:
  - [net,v2] ptp: ptp_clockmatrix: fix is_single_shot
    https://git.kernel.org/netdev/net/c/d0bbe0328fe5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


