Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45752C25B06
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Aug 2022 16:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240932AbiHNQ64 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Aug 2022 12:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243110AbiHNQ6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2A192F7E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 09:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDE8F60CFA
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 16:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39C65C43140;
        Sun, 14 Aug 2022 16:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660495871;
        bh=5x12jWQWyCom/Z75nAFf+f/Xg2dyhKKUKlNARGN2oJY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kxo54Rom+NvcgUo/FOWtYZhO70vQriHgk2fU89wrb4wmSMmGLGH6JyHPNrI3Sd26L
         s73ktgKR2gFLXevvbzVwzeGOcDSfbYtbANDv4VnyKtKATDmXhU2lTUX8R1wHtzl+uS
         yDJwP8/RXNBaPlVh/DLM2XnsdZZ0Sd2AR/o8Zlk0aKNi3l6MkTOEpeeozkc8qBIwIp
         dUFSJMGIZWDWQlJfjhcSsdJHkibcB1H/urkgzMwje7fbuYeVSMH9D+lwY1MfHvTSa0
         bwx8fbPJGwQd5aFlOWc2wzy7nBTS/6Sia/2TP63ujy+Zncrntgcs7X0CLPED1+sEKi
         OB8ZVRx5ZjApw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 267BFC43143;
        Sun, 14 Aug 2022 16:51:11 +0000 (UTC)
Subject: Re: [GIT PULL] xen: 2nd round of patches for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220814090737.29335-1-jgross@suse.com>
References: <20220814090737.29335-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220814090737.29335-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.0-rc1b-tag
X-PR-Tracked-Commit-Id: 5ad3134dcf5201c4d51c981e52557939256b02c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d6a0f4da9275f6c212de33777778673ba91241a
Message-Id: <166049587115.14047.8177190261062229682.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Aug 2022 16:51:11 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Aug 2022 11:07:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.0-rc1b-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d6a0f4da9275f6c212de33777778673ba91241a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
