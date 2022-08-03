Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE3AC19F2A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Aug 2022 19:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238479AbiHCTAe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Aug 2022 15:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbiHCTA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF746B4BE;
        Wed,  3 Aug 2022 12:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0296461320;
        Wed,  3 Aug 2022 19:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA6B8C4347C;
        Wed,  3 Aug 2022 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659553225;
        bh=PjAduTHwqHkqn7lS1w8O3apDUQRaCEe2ZOdp08jPSGc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u/OnGx7SSbpo8zAE8fbr8JTmz/Om35V0XP6Asz7N0M1ref/UgEEMJHIyIwRKVtQpe
         VH8snQwWVJxpD0rFuUUBxnahb0qhtmmuzep1dlUu8MUOUCOcbIC/1lRkDdiLbpOLXX
         1btdF62VH88CATOfa8MfIup8rVUH/9sjwaEuTFn/kASrYbkhsO3ukikPNzHDVcJSG/
         k1+ovyHOQqZzbYZDExUtULgFBlSA/rnKUJn4aWoD6xSw+6FohocL+eyC2fJ6WROLpw
         3npZJZiNlx8itUXLsptHw76x7ib4XUQ04AFnk0L3+jCoQncJxHhccP0eOhQ2gF0D+f
         iejoyet13nSQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4EFBC43140;
        Wed,  3 Aug 2022 19:00:25 +0000 (UTC)
Subject: Re: [git pull] vfs.git pile 3 - dcache
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YurA3aSb4GRr4wlW@ZenIV>
References: <YurA3aSb4GRr4wlW@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YurA3aSb4GRr4wlW@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.dcache
X-PR-Tracked-Commit-Id: 50417d22d0efbb1be76c3cb66b2329f83741c9c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 200e340f2196d7fd427a5810d06e893b932f145a
Message-Id: <165955322573.6947.18371092849558487517.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 19:00:25 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Aug 2022 19:39:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.dcache

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/200e340f2196d7fd427a5810d06e893b932f145a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
