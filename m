Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DCFC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jun 2022 18:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349408AbiFESDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jun 2022 14:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351468AbiFESDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 14:03:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1F6F5B4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 11:03:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFDB161186
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 18:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37D27C341C7;
        Sun,  5 Jun 2022 18:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654452196;
        bh=lQqW/A9JQiJ1th7Em22sDi9sYIyP2y/h/qqGcQsdE+Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oAXh+3NuAySScSX41Fq/4WPjwYY7lyeBEV33ApcV8/Ie9ZmJWM0lp3o6iFR/08Dp0
         aK1cMngjBKbMui37vgc/WLMB401zhT2r3y0EFubcAmjIp7VLjjofmO3IULYoR6BzW5
         LhPZL3LHkbj6jDbKN51ivpUEkoM+i1gneDgXtLlgmxwFl38qSEcd3Q7c6M0b2p1LJg
         XIUqnTJJaZXbh7TKZKfeBTBqUGJvBtRY9nv6dXSOGv5TL7DukzhXXfQoLzdp835XCJ
         ZCFyTmnHWPDUn5nbSJxASkNpiSMuVHTNEV81zhVa5RTV8dtaYjtWvwpbqNczWO+Sid
         QgwDp92SJjCBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2538CF03875;
        Sun,  5 Jun 2022 18:03:16 +0000 (UTC)
Subject: Re: [GIT pull] x86/cleanups for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165442137838.152751.6839806816555222572.tglx@xen13>
References: <165442136963.152751.14259048792272164569.tglx@xen13> <165442137838.152751.6839806816555222572.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165442137838.152751.6839806816555222572.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2022-06-05
X-PR-Tracked-Commit-Id: f7081834b2d5bbc77d67073d8ab490bfeaf3c13b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a925128092d8dd5c2ea8644e1dddd510b7ebc9c7
Message-Id: <165445219614.28605.1336867964675721284.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jun 2022 18:03:16 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  5 Jun 2022 11:30:59 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2022-06-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a925128092d8dd5c2ea8644e1dddd510b7ebc9c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
