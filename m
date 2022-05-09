Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D35EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 23:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiEIXEO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 19:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiEIXEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:04:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225612685C9;
        Mon,  9 May 2022 16:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B219F61166;
        Mon,  9 May 2022 23:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17D66C385C5;
        Mon,  9 May 2022 23:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652137213;
        bh=VcvEmvsda6PrBaWwE9OW+g7p7P/vLgVTvyoyN+0s2yg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MrE3sA1Idu/OhNdVHNzoVed1qL3IqBTt70wXZbZbmMj9a8MNpfR8LCzkLUKGgLrsd
         UPzL0A2sKa5uT+6deFs2iSRREykEpO+p2JZBw8yvrrvlkp6eGnkt+7VL8+ke+lkoO9
         cPua8mqJtkQrQWLDZjpyeMWd5zEXI6eRr1dqr7j1GcJIQ0KWF7HEG0EJBcI6nInj7A
         CVPBSRsCitln4Jyjmo4TJ/t5Dex/XkNgqH0lIGAcG4yqveSYS8rOlun1KwymShZryp
         FB72HjhNvSjS1RElNk7RpLsWzp1JdxPq0aAmrLE4uh3SPKhVDVWqB56ZYV3wCB1Iqo
         6BL7bweGuPj4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC929F0392B;
        Mon,  9 May 2022 23:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ionic: fix missing pci_release_regions() on error in
 ionic_probe()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165213721296.9878.17919495289155310348.git-patchwork-notify@kernel.org>
Date:   Mon, 09 May 2022 23:00:12 +0000
References: <20220506034040.2614129-1-yangyingliang@huawei.com>
In-Reply-To: <20220506034040.2614129-1-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        snelson@pensando.io, davem@davemloft.net, kuba@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 6 May 2022 11:40:40 +0800 you wrote:
> If ionic_map_bars() fails, pci_release_regions() need be called.
> 
> Fixes: fbfb8031533c ("ionic: Add hardware init and device commands")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - ionic: fix missing pci_release_regions() on error in ionic_probe()
    https://git.kernel.org/netdev/net/c/e4b1045bf9cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


