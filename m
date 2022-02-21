Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD91C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 13:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240481AbiBUNKn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 08:10:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238073AbiBUNKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:10:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1FF1EAFB;
        Mon, 21 Feb 2022 05:10:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B6BAB81185;
        Mon, 21 Feb 2022 13:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E29D1C340F6;
        Mon, 21 Feb 2022 13:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645449009;
        bh=H/AAOV/KPpcqeTNpNQIxUs7cqf+Kkl2uYNPyOYOeorI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TBEwfzE6Oj60w3d/u4uCzdf2Oqkac8lonvJhZHWRPNdn0ydmjS+INIIE/0HHhy2lj
         68JrNsCiSp3+gUeYFA9TDYhjvhQh7MmZYVbysJUXEka17UIp8B+AMDt1joowlukmWX
         cR7jxVdtgweTq9z5ZrkqCKk/hiVwQmSyip1NqSmqptdqZrGi6yMIcCib/x+t0GF5Pf
         NJwykknNfSb3AWcDG/mc/9OCS6nblb99R5qnBEePoGECI1HDS5dATFxrq/qtls8/OU
         pE3Pa2ky6L1Q1DAXwLiOjz89nDGmni/5CFtfCkTrjEQsngruECmbPIF8+yTmUdhwK9
         TL5SiFDmM7NKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1330E6D3E8;
        Mon, 21 Feb 2022 13:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v2 0/2] RVU AF and NETDEV drivers' PTP updates.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164544900985.23760.15653354946520544563.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Feb 2022 13:10:09 +0000
References: <20220221064508.19148-1-rsaladi2@marvell.com>
In-Reply-To: <20220221064508.19148-1-rsaladi2@marvell.com>
To:     Rakesh Babu Saladi <rsaladi2@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        richardcochran@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Mon, 21 Feb 2022 12:15:06 +0530 you wrote:
> Patch 1: Add suppot such that RVU drivers support new timestamp format.
> Patch 2: This patch adds workaround for PTP errata.
> 
> Changes made from  v1 to v2
> 1. CC'd Richard Cochran to review PTP related patches.
> 2. Removed a patch from the old patch series. Will submit the removed patch
> separately.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] octeontx2-pf: cn10k: add support for new ptp timestamp format
    https://git.kernel.org/netdev/net-next/c/74c1b2338e0e
  - [net-next,v2,2/2] octeontx2-af: cn10k: add workaround for ptp errata
    https://git.kernel.org/netdev/net-next/c/6426fc3abab9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


