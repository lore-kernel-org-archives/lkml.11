Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64B8C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 19:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiEYTkh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 15:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344768AbiEYTkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C103066FAE;
        Wed, 25 May 2022 12:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C107A619FC;
        Wed, 25 May 2022 19:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82AB9C34118;
        Wed, 25 May 2022 19:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653507617;
        bh=wIxfHd5h9818LBe0A+En8Ee1j64AmnYyBhwjeZ1NDkU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S4YCmoiaayMGRXT1cUk/oRQ6PM3HuQdI+a6y793hj/kI0yTHEZLoFGtmx/0ZwIskT
         o2Vurmarp54h74iae2P84XjyeyhbxAIOG/ZicJmwxxrAXjW1eHs3oLEALi52ONQWL1
         kimIQNcr6VRTrHF4wLEq3yz4XUB4g66DJg107LK9x71WM/52y6z1EFd3wSdxG1MwEy
         kn2Z4d9nSlH4mb7uZ5ZFSa1kI8Z6gSjH0rdqZ7FOih81HiILWvLZmuLfgYXSnevSoy
         Futubbt3FoDgN/iTQ407dOmHBgXgVNhEv/gM2TJmRP+QrMuShuzJG67k+6B/etn5lM
         aWXh0AMt7UE+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67FA0F03943;
        Wed, 25 May 2022 19:40:17 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220524203159.1189780-1-kuba@kernel.org>
References: <20220524203159.1189780-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220524203159.1189780-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-5.19
X-PR-Tracked-Commit-Id: 57d7becda9c9e612e6b00676f2eecfac3e719e88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e062cda7d90543ac8c7700fc7c5527d0c0f22ad
Message-Id: <165350761739.19106.13025373260874025596.pr-tracker-bot@kernel.org>
Date:   Wed, 25 May 2022 19:40:17 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 May 2022 13:31:59 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e062cda7d90543ac8c7700fc7c5527d0c0f22ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
