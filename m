Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD7EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 18:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350163AbiFJS0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 14:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350111AbiFJSZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:25:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BC42CC96;
        Fri, 10 Jun 2022 11:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E0DB621D7;
        Fri, 10 Jun 2022 18:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2DE6C3411C;
        Fri, 10 Jun 2022 18:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654885554;
        bh=Pzu3SUTbWK/Q3isker9+qxUIRM4gxpovkhKIMxCnDPQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jwsZqIbK2inI3/zcNeLVwzTbjFEVTuuWksdgnxp3yD/z3bidBBeXANxCT1gAkgn4L
         dzbpNZuZCmpVJo1+cLS/ua4+M+0XxRqwe+r7dnJuslQzBdL6600rVCl2m0Y4i4xI/k
         mcAGCfXTdHeQap78n9MotdrOUdoAS+RSBgsSS8GQ0JIF3Uprll8K8AG1W2dnwDR/ja
         +Od3Y8x17jTesYR1W3F/mmYWqNTy8+Ywao2fi79wnXOOKx1HiwaG89rULbT7M/FusB
         ymCsx11O1cegjjqAVzWw0NOz+B7rfzgx92Ce7focrag4Z/4CxYuUVK7Dfvg82dfBKv
         kUJ87VVOKnnqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90306E737EE;
        Fri, 10 Jun 2022 18:25:54 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 5.19-rc2 (follow up)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220610053544.417023-1-kuba@kernel.org>
References: <20220610053544.417023-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220610053544.417023-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-5.19-rc2-2
X-PR-Tracked-Commit-Id: bf56a0917fd329d5adecfd405e681ff7ba1abb52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68171bbd1a9adaadac0c6a85c8558eaf0b718387
Message-Id: <165488555458.32117.10440003159446762788.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jun 2022 18:25:54 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  9 Jun 2022 22:35:44 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-5.19-rc2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68171bbd1a9adaadac0c6a85c8558eaf0b718387

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
