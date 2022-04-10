Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4000C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Apr 2022 17:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbiDJRyu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Apr 2022 13:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243803AbiDJRyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:54:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CA05D5F3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 10:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA0BB61188
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 17:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17901C385A4;
        Sun, 10 Apr 2022 17:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649613152;
        bh=dGX+ThV2PFsee0easY8X2jpXmDF4HGwCnjscT3P+PZg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zj/F8IesqMxvp1IAei2WzrxGpIDqVVCLFo9mIPyP7WUvGOCuVZskScqXZMDjUVaRg
         0LVQsNsASq7/go5KzjYAlUE0hHk18e9KSZZvr9HyIkpWv1UXIzpx19sFOsIb4CHuNx
         G3b33MHkJFVqb3KNiKIFKfSOY/Gf/XuL32O/Ehlu2oi9AvD1fWkEd0dsQdT7rPmMuq
         pAa+/uMb53zDoSlCegcOrUEi1Rq/wH0YN5L2nSbaCeynUdvqcbh3eDwNxn6OtiR5hi
         wuCOUphezY+WiFgGeuived6kJEhHViHV1HYF9xDWcmc+7hAhVifQ4+Sii/W9wW+bim
         7VPXIs6N/plPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDB9EE8DD5D;
        Sun, 10 Apr 2022 17:52:31 +0000 (UTC)
Subject: Re: [GIT PULL] locking/urgent for v5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YlK2X+uJ8C4H+N8p@zn.tnic>
References: <YlK2X+uJ8C4H+N8p@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YlK2X+uJ8C4H+N8p@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.18_rc2
X-PR-Tracked-Commit-Id: 273ba85b5e8b971ed28eb5c17e1638543be9237d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50c94de67cfcf858d32a868dcc4e40d8581137c1
Message-Id: <164961315197.10430.15243754240158954432.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Apr 2022 17:52:31 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Apr 2022 12:50:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.18_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50c94de67cfcf858d32a868dcc4e40d8581137c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
