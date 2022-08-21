Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53E9C00140
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Aug 2022 23:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiHUXNv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Aug 2022 19:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiHUXNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 19:13:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B4912AA4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 16:13:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C1CF60DEB
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75542C43144;
        Sun, 21 Aug 2022 23:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661123627;
        bh=dxqP23U/LPwhwUrni+SBrGtiglUuoadc8DXJuoPfwMs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NuhbzFNvmS0G6a0XRMiqnTw+dRBKNQvotTak9uS4vSFNeKcFRO7u1w3rOZMCosM2x
         w/c058uMMTVUFsJnwZZ00pTlzIbdVomgFC+kFpahQ7OyjoMaaIfyte5imxAX9wNxPA
         IM1rXuEE/USuInLTN0QWa3EcZXy8sM+FeRj9qw7kpXUuCcnXCSKJVGH97XcNx+6BrP
         5+WfqRL+MOSG22KWPfHwwEref4hHfU6pjoloAqu5vpVCxmVKiguEvq9hD7mS8eep+z
         +LDjaSVxIb2Q+2yztyd9sa4ul4embDdZVcbPUNRWrQ2AiDFiIFltlVlqKGW+6gGYPm
         9UNS7vZi2TvPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F8E6C43142;
        Sun, 21 Aug 2022 23:13:47 +0000 (UTC)
Subject: Re: [GIT PULL] IRQ fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YwKfLrZvzIWmvYBL@gmail.com>
References: <YwKfLrZvzIWmvYBL@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YwKfLrZvzIWmvYBL@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-08-21
X-PR-Tracked-Commit-Id: 57646d6769f13f9484ffc6869c493e25a6568073
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4daa6a81c07c54f989e70d682fa0bff568c14df0
Message-Id: <166112362738.15654.8935540889271294799.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Aug 2022 23:13:47 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Aug 2022 23:10:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-08-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4daa6a81c07c54f989e70d682fa0bff568c14df0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
