Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAB5C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 May 2022 19:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiEHT77 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 May 2022 15:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiEHT75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:59:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B05BF7D;
        Sun,  8 May 2022 12:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E27BBB80E77;
        Sun,  8 May 2022 19:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEA1AC385B0;
        Sun,  8 May 2022 19:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652039762;
        bh=1T4NVr1kfOiAvFXa2/Jc2Ew2SxF3RMivCMa4J9pf6Hs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y90q8YlZrenOe+nHLV9QYGJMEN1y2CsNSv4TK1pt8CVUv2yvUbOVGA0y3yyMg/QV/
         SctCMM59nNOSiLEINepBE+h+j1uNNcsaHyVViTTU9yxWMJTPpsdh3GpSfqfdYym20U
         wTv2FFssWY53n3fYzM09YQw7wD4S2IRG3L//dHzLGKBlSEmV4eOM6BGBSyCZphJJl1
         PDvSNTgkXEUqTPbuRUsd55YebjqtS3pukk+ISKg1QRLsP1jT/u328GHxGUmhksOi9P
         wn6SgwoyoNRfP9cH6miwJmtPOhYH4Ga0xmY48ilggblacO8rZf1cqcErkYj+fc1CXS
         T+oCxZtd/m/ZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BF88E5D087;
        Sun,  8 May 2022 19:56:02 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture updates for v5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YngaRj/nUEkAKbZL@p100>
References: <YngaRj/nUEkAKbZL@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YngaRj/nUEkAKbZL@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.18/parisc-3
X-PR-Tracked-Commit-Id: ba0c04104082ca211e108dd8eec6db2ad7676528
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f002488d80b557c7dc540457b176011449895fcb
Message-Id: <165203976263.4566.16797864925732683691.pr-tracker-bot@kernel.org>
Date:   Sun, 08 May 2022 19:56:02 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 8 May 2022 21:30:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.18/parisc-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f002488d80b557c7dc540457b176011449895fcb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
