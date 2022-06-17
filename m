Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C69C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 20:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344228AbiFQUXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 16:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiFQUXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:23:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7DE2E08F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:23:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62FDF62013
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 20:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFD83C3411B;
        Fri, 17 Jun 2022 20:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655497400;
        bh=I6C2oWGy1OtABM++A2l40xG06rRh6qefNOT2tIwYwbE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iZcgxMnA3vUZgpjYN9OlgyQuIRhqh1I/mWTgyJ86YIZoNTR8fAeajQ3VN8Vl1Nzcg
         000AtBZExe1Vp8Of9qtZe7kHs6tpOOsWpf2HNfObGIwvvdDZVyeT/cmp3mmTj6PE9Q
         +RgrVgUjN2SZQCwi2gVDdsc+K1Ry0B/NkhaHdUEzeeIKA1Izttt5hbG9WM3fiGXi8C
         1u25OSaWb6o8mhkpTSwHcBWLHYHVDPD6Xehw9Of6vhn8gm+d0sQW4bl9kAONU6siTo
         MKtUxqRBfci+NmuA0PEzZgAnVMkCRquIlFj+uWjNQCFtYJ7wqEy1vuZ6hmS3vYmI/2
         nQjGl9rGdX4pQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA76FFD99FF;
        Fri, 17 Jun 2022 20:23:20 +0000 (UTC)
Subject: Re: [GIT PULL] printk fixups for 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YqybK+kFriV9yeIx@alley>
References: <YqybK+kFriV9yeIx@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YqybK+kFriV9yeIx@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.19-rc3
X-PR-Tracked-Commit-Id: 38335cc5ffafa111210ad6bbe5a63a87db38ee68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93d17c1c8c1cc987aad378d5266d99e46efca43c
Message-Id: <165549740068.12674.8664595098022124039.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jun 2022 20:23:20 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Jun 2022 17:18:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93d17c1c8c1cc987aad378d5266d99e46efca43c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
