Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BE8C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 06:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbiDGGM0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 02:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbiDGGMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:12:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B109419FF40;
        Wed,  6 Apr 2022 23:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C2E0B826CC;
        Thu,  7 Apr 2022 06:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCFF7C385B0;
        Thu,  7 Apr 2022 06:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649311812;
        bh=MBze6DN7wKgyvdrTEpSIDkcRzzMRsVzzneWscD7DhwM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qz5OrYbcoMsJvPs5PHWnZpMv0EiFI5KUsgdFBhyNuyejPWcIMOsEeNpnCGXd0iZy2
         mlqjc1Fh9SC5EGalnPUXdtLs5xvYBhTG4bwTsjsVMZ0IEFRMD0Df5ffaOMyB4q5gh8
         OsGGyQ+Y9sw7qT4Qlr0DEkOtzttZ2QI62fDRogT/NUtrsaX45UGw9wLDMdH28a17F+
         TxtzzozKxGOgit7DIDqG+0i8LOP+LlzR05etXNo6blBgMCOQNrYug7hAp+4uy4hhmU
         zx0Wl/1x8P2YYPU89d9JUYe0ryiBGQ6N3dX/sGaDvbrMPsRskZb1a5CalvRtpiLigi
         +J8yWTMpFeTGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1119E8DD18;
        Thu,  7 Apr 2022 06:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] prestera: acl: add action hw_stats support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164931181264.23961.6968341673165749538.git-patchwork-notify@kernel.org>
Date:   Thu, 07 Apr 2022 06:10:12 +0000
References: <1649164814-18731-1-git-send-email-volodymyr.mytnyk@plvision.eu>
In-Reply-To: <1649164814-18731-1-git-send-email-volodymyr.mytnyk@plvision.eu>
To:     Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>
Cc:     netdev@vger.kernel.org, taras.chornyi@plvision.eu,
        mickeyr@marvell.com, serhiy.pshyk@plvision.eu, vmytnyk@marvell.com,
        tchornyi@marvell.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Apr 2022 16:20:14 +0300 you wrote:
> From: Volodymyr Mytnyk <vmytnyk@marvell.com>
> 
> Currently, when user adds a tc action and the action gets offloaded,
> the user expects the HW stats to be counted also. This limits the
> amount of supported offloaded filters, as HW counter resources may
> be quite limited. Without counter assigned, the HW is capable to
> carry much more filters.
> 
> [...]

Here is the summary with links:
  - [net-next] prestera: acl: add action hw_stats support
    https://git.kernel.org/netdev/net-next/c/e8bd70250a82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


