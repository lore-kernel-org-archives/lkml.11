Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF361C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 20:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbiCBUhc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 15:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238714AbiCBUh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:37:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EF2C116B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:36:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6161617B5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 20:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3242EC004E1;
        Wed,  2 Mar 2022 20:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646253405;
        bh=zQy0WNRFfoSF8M6CkM9t9ucOlLwRhJNfydVDE5XAZcE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R0WLJBVgw5Rd7WcwQstMwaAMW/TWqPU8z2Jb0kND2JvYMZnFx5umnmnfrZXOt2ntR
         lIo4RCVyp1Cy+h3TvWNd9gXwlApckFd7AJ5Ml/Ib98w14sbN1/xY24n91uv5STASAr
         J8JJGDoGK5ahZPBSpznfkpbpCOxGRg7vAjGDYFNINiDh0zypt5Jeo61lHsXJiU2C51
         LVmfhXjodp/MhY/wW7je40jVF9EMtGlgdtt14pk4jcRcj2foNMAmgEhk9nrdJXVufn
         anXn0MyaT/lu85/G4zXPATejtq3pKyC46RREQDXjKVYNzxviO/C1isy00Z8VDE1KAp
         s5ZGqnRSmJrlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A2B8E7BB08;
        Wed,  2 Mar 2022 20:36:45 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fix for 5.17-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yh+CCr04nTTappWl@hsiangkao-PC>
References: <Yh+CCr04nTTappWl@hsiangkao-PC>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Yh+CCr04nTTappWl@hsiangkao-PC>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.17-rc7-fixes
X-PR-Tracked-Commit-Id: 22ba5e99b96f1c0dbdfa4f4e1d9751b4c8348541
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92ebf5f91b4dd5156886d2509202be0fb4230dfd
Message-Id: <164625340509.15521.3020679417776527674.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Mar 2022 20:36:45 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 2 Mar 2022 22:41:14 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.17-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92ebf5f91b4dd5156886d2509202be0fb4230dfd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
